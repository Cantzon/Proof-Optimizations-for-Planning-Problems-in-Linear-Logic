;;; -*- Mode: LISP; Syntax: Common-lisp; Package: user ;;; -*-

(defpackage :sockfig)
(in-package :sockfig)

;;; copyright goes here

;;; Modified version of the socket code from BBN. David Rager, Nov/Dec 1997
;;;  - Loads sock2.so/sock2.o or sock.so/sock.o based on value of *sock2p*
;;;  - Added definition of handle-errors-if-possible
;;;  - Added my own client connect and disconnect routines to replace
;;;    with-client-connection 
;;;  - Added ipc-listen function
;;;  - Added ipc-server-connect-no-block a non-blocking version of
;;;    ipc-server-connect.  Requires sock2.so/sock2.o
;;;  - Changed ipc-length-read so it no longer requires status to be 1
;;;  - Removed dead code
;;;  - Added *load-sock-file-p* and *sock2p* flags to control loading
;;;  - Created :sockfig package for this code.
;;;  - Modified sockfig-connected-p so it works with client sockfigs too.


;;;
;;; Global Parameters
;;;

;;; Directory with socket code. This parameter is also defined in file
;;; system/ui/loader.lisp.
;;;
(defparameter user::*prod-ui-home* 
  (concatenate 'string 
	       user::*system-directory*
	       "ui/"))
;(defvar *prod-ui-home* "/fs/parka/rager/tie-prodigy/")

;;; Load the C socket file when true. If nil, then it has already been loaded
;;; (e.g., by the UI).
(defvar *load-sock-file-p* t)

;;; Loads sock2 file when true (providing non-blocking ipc-server-connect)
(defvar *sock2p* nil)


;;; PURPOSE: this is a general socket interface for both clients and
;;; servers. It supports read/writing lisp objects, as well as the Named
;;; Entity Protocol used by hspurt and nymble. It can handle a single
;;; server connection, and multiple client connections provided they're
;;; established with WITH-IPC-CONNECTION
;;;
;;; A typical top-level picture is like this:
;;; SERVER                         CLIENT
;;; ------                         ------
;;; IPC-SERVER-INIT - once
;;; loop
;;; IPC-SERVER-CONNECT
;;;                                (IPC-CLIENT-CONNECT)
;;;
;;; (talk talk talk talk talk talk talk talk talk talk)
;;;                                    
;;; IPC-CLOSE-STREAM               (IPC-CLIENT-DISCONNECT)
;;; go to loop
;;; IPC-SERVER-SHUTDOWN finally
;;;
;;;
;;;
;;; -------------------- User-modifiable variables:
;;;
;;; *IPC-DEFAULT-PORT* 2611                                         [PARAMETER]
;;;    Usual default for initializing socket connections. Calling
;;;    net_connect_to_server with this value will use the default, which is
;;;    a magic number. Client and server must agree!
;;;
;;; *IPC-DEFAULT-HOST* (get-environment-variable "host")            [PARAMETER]
;;;    Client and server must agree!
;;;
;;; *TRACE-IPC* ()                                                  [PARAMETER]
;;;    Show all IPC activity, all items read and printed, initialization
;;;    and closing.
;;;
;;; -------------------- User-readable variables:
;;;
;;; *LAST-SOCKFIG* ()                                               [PARAMETER]
;;;    The last SOCKet conFIGuration for which initialization was
;;;    attempted. Careful if you have multiple sockets: this is changed by
;;;    both server and client initialization.
;;;
;;; -------------------- Externally-callable functions:
;;;
;;; -------------------- SOCKFIG tests
;;;
;;; SOCKFIG-READY-P (sockfig)                                        [FUNCTION]
;;;    Is SOCKFIG listening for a connection? 
;;;
;;; SOCKFIG-CONNECTED-P (sockfig)                                    [FUNCTION]
;;;    Is SOCKFIG connected? 
;;;
;;; -------------------- IPC connections
;;;
;;; IPC-SERVER-INIT (&optional (port *ipc-default-port*))            [FUNCTION]
;;;    Wait for a connection on PORT, *ipc-default-port* if not supplied.
;;;    If successful, returns the socket configuration with socket=<socket #>
;;;    and status=:listening, and resets *last-sockfig* to it: if
;;;    unsuccessful, returns nil.
;;;    Does _not_ set up the stream: IPC-SERVER-CONNECT does that.  This
;;;    does file locking in /tmp/.ipc-<port#>, so it requires write access
;;;    there. 
;;;
;;; IPC-SERVER-CONNECT (&optional (sf *last-sockfig*))               [FUNCTION]
;;;    Listen until a server connection is established on the socket
;;;    associated with SOCKFIG (defaults to *last-sockfig*), waiting until a
;;;    client has issued a request to connect. The socket must have already
;;;    been initialized: after it's been closed, though, you can call
;;;    ipc-server-connect again. This sets the sockfig's stream to what's
;;;    opened, and returns the sockfig.  
;;;
;;; IPC-SERVER-CONNECT-NO-BLOCK (&optional (sf *last-sockfig*))      [FUNCTION]
;;;    Same as above, except it returns :EWOULDBLOCK if the call would
;;;    block. (DER)
;;;
;;; IPC-CLOSE-STREAM (&optional (sf *last-sockfig*))                 [FUNCTION]
;;;    Close the stream for SOCKFIG, which defaults to
;;;    *last-sockfig*. Servers can re-open it again with IPC-SERVER-CONNECT
;;;    (the client side needs to be re-initialized). 
;;;
;;; IPC-SERVER-SHUTDOWN (&optional (sf *last-sockfig*))              [FUNCTION]
;;;    Do final cleanup on SOCKFIG, presumably because you're killing the
;;;    server. 
;;;
;;; SERVER-ALREADY-EXISTS-P (port)                                   [FUNCTION]
;;;    Is there already a server running on this port? Checks for a file
;;;    named /tmp/.ipc-<portnumber>: if the file exists and the PID it
;;;    contains is active, then return T, else overwrite the file with the
;;;    current process' PID and return NIL.
;;;
;;; WITH-IPC-CONNECTION (&rest body)                                    [MACRO]
;;;    Open a connection as a client on HOST and PORT: the server should
;;;    already be listening. Execute the body, and then close the
;;;    connection. Within the score of this macro, *init-socket*,
;;;    *ipc-stream*, and *last-sockfig* are locally bound. 
;;;
;;; IPC-CLIENT-CONNECT (&optional (host *ipc-default-host*)          [FUNCTION]
;;;                               (port *ipc-default-port*))
;;;    Open a connection as a client on HOST and PORT: the server should
;;;    already be listening.  Sets *last-sockfig* and returns the sockfig. (DER)
;;;
;;; IPC-CLIENT-DISCONNECT (&optional (sf *last-sockfig*))            [FUNCTION]
;;;    Close the client stream to the server. (DER)
;;;
;;;
;;; -------------------- I/O functions
;;;
;;; IPC-LISTEN (&optional (sf *last-sockfig*)                        [FUNCTION]
;;;    Does a listen on the sockfig.  Returns T if there's data to be read or NIL.
;;;    If the stream is closed, :EOF is returned. (DER)
;;;
;;; IPC-READ (&optional (sf *last-sockfig*))                         [FUNCTION]
;;;    Read from the stream associated with SOCKFIG, preserving whitespace
;;;    (otherwise Allegro misbehaves). Returns the data,or (:EOF) on
;;;    end-of-file
;;;
;;; IPC-PRINT (datum &optional (sf *last-sockfig*)                   [FUNCTION]
;;;            (add-newline nil))
;;;    Currently just the lisp standard format: this works for numbers,
;;;    strings, and symbols. If there's no delimter after symbols like
;;;    whitespace, right paren, etc, they don't get seen by ipc-read until
;;;    the stream is closed. With optional arg ADD-NEWLINE non-nil, write a
;;;    newline character after the data: this matters for some readers. 
;;;
;;; IPC-LENGTH-PRINT (string &optional (sf *last-sockfig*))          [FUNCTION]
;;;    Print to the stream for SOCKFIG 6 bytes representing the length of
;;;    STRING (padded with blanks on the left), then the string itself. This
;;;    is for servers supporting TCL/TK GUIs (or their protocols). 
;;;
;;; IPC-PRINT-AND-CHECK-OK (datum &optional (sf *last-sockfig*))     [FUNCTION]
;;;    Print DATUM using IPC-PRINT with a newline, read the return value
;;;    using IPC-LENGTH-READ, and warn if it's not OK. Returns whether it's
;;;    OK or not.
;;;
;;; IPC-LENGTH-READ (&optional (sf *last-sockfig*))                  [FUNCTION]
;;;    Read from the stream for SOCKFIG 6 bytes representing the number of
;;;    bytes of data, and then the appropriate number of bytes to get all of
;;;    the data. This is for fetching return values from commands designed
;;;    to write to TCL/TK GUIs. Returns the data (as a string).
;;;    DER - Modified so the status can be any integer.
;;;
;;; IPC-READ-BRACES (&optional (sf *last-sockfig*))                  [FUNCTION]
;;;    Read from the stream for SOCKFIG 6 bytes representing the number of
;;;    bytes of data, toss them, read two status bytes, toss them, and then
;;;    read data delimited by braces. This is for reading from functions
;;;    that think they're writing to TCL. Returns the data on end-of-file,
;;;    or the list (:EOF). WARNING: this function locally changes the
;;;    readtable. 
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; user modifiable variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; in hspurt days, this was 2611: both numbers are arbitrary
;; conventions. sboisen 7/2/97
(defparameter *ipc-default-port* 4797
  "Usual default for initializing socket connections. Calling
net_connect_to_server with this value will use the default, which is a
magic number. Client and server must agree!") 

(defparameter *ipc-default-host* (sys:getenv "HOST")
  "Default host where the server resides: client and server must
agree!")

(defparameter *trace-ipc* nil
  "Show all IPC activity, all items read and printed, initialization
and closing.")

(defvar *building-standalone?* nil
  "If T, don't load sock.so.  Instead load sock.o directly into the
image being built.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; no good reason to be changing these ...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *socket-interface-object-file*
    (concatenate 'string 
		 user::*prod-ui-home* 
		 "/sockets/" 
		 (if (find :dlfcn *features*)
		     (if *sock2p* "sock2.so" "sock.so")
		   (if *sock2p* "sock2.o" "sock.o")))
  "Where the object code for the socket reading C code is.")


;; it's for SOCKets, it's a conFIGuration: it's SOCKFIG!
(defstruct (sockfig (:print-function print-sockfig))
  host					; what host is it on
  ;; name					; arbitrary identifier
  port					; port #
  ;; clients only use the comm-socket
  comm-socket				; socket or NIL
  init-socket				; socket or NIL
  ;; for servers
  ;; :closed <- init-socket = NIL
  ;; :listening <- init-socket = open, comm-socket = NIL
  ;; :connected <- init-socket = open, comm-socket = open
  ;; for clients
  ;; :closed <- comm-socket = NIL
  ;; :connected <- comm-socket = open
  status
  stream				; stream, if connected, or NIL
  type					; :server or :client
  )

(defun print-sockfig (sockfig stream depth)
  (declare (ignore depth))
  (when (sockfig-p sockfig)
    (format stream "#<~a ~a on ~a:~d>"
	    (sockfig-status sockfig)
	    (sockfig-type sockfig)
	    (sockfig-host sockfig)
	    (sockfig-port sockfig))))

(defun sockfig-ready-p (sockfig)
  "Is SOCKFIG listening for a connection? "
  (and (sockfig-p sockfig)
       (eq (sockfig-status sockfig) :listening)))

(defun sockfig-connected-p (sockfig)
  "Is SOCKFIG connected?"
  (and (sockfig-p sockfig)
       (or (and (eq (sockfig-type sockfig) :server)
		(eq (sockfig-status sockfig) :open))
	   (and (eq (sockfig-type sockfig) :client)
		(eq (sockfig-status sockfig) :connected)))))

(defparameter *ipc-stream* nil
  "Stream connected to socket.")

(defparameter *last-sockfig* nil
  "The last SOCKet conFIGuration for which initialization was
attempted. Careful if you have multiple sockets: this is changed by
both server and client initialization.")

(defparameter *safety-net-sf* nil)

(defparameter *init-socket* nil
  "Socket for initializing communications: in two socket systems, this
only gets the message to make a connection. ")

(defparameter *comm-socket* nil
  "Socket for actual communications in two-socket systems. ")

#|
(defmacro handle-errors-if-possible (error-case &body body)
  `(handler-case 
    (progn ,@body)
    (error () ,error-case)))
|#

(defmacro handle-errors-if-possible (error-case &body body)
  `(progn ,@body))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;  INTERFACE FUNCTIONS 

;;; The server side will typically call (IPC-SERVER-INIT)
;;; to lay claim to the socket, and then (IPC-SERVER-CONNECT)
;;; to establish a bidirectional stream.  After the conversation with
;;; the GUI is over, use IPC-CLOSE-STREAM to close the stream: you can 
;;; re-open it with IPC-SERVER-CONNECT. When the entire session is
;;; finished, do (IPC-CLOSE) to relinquish the port.

(defun IPC-SERVER-INIT (&optional (port *ipc-default-port*))
  "Wait for a connection on PORT, *ipc-default-port* if not supplied.
If successful, returns the socket configuration with socket=<socket #>
and status=:listening, and resets *last-sockfig* to it: if
unsuccessful, returns nil.
   Does _not_ set up the stream: IPC-SERVER-CONNECT does that.  This does
file locking in /tmp/.ipc-<port#>, so it requires write access
there. "
  (declare (special *last-sockfig*))
  (unless (server-already-exists-p port)
    (let ((sf (make-sockfig :host (sys:getenv "HOST")
			    :port port
			    :type :server))
	  (socket (test-c-return (sock-server-init port))))
      (when *trace-ipc*
	(format t "~%;; SOCK-SERVER-INIT returned ~A" socket))
      (if (< socket 0)
	  (progn
	    (setf (sockfig-status sf) :closed)
	    (warn "IPC-SERVER-INIT failed for ~a~%" sf))
	(progn
	  (setf (sockfig-init-socket sf) socket
		(sockfig-status sf) :listening
		*last-sockfig* sf))))))

 
(defun IPC-SERVER-CONNECT (&optional (sf *last-sockfig*))
  "Listen until a server connection is established on the socket
associated with SOCKFIG (defaults to *last-sockfig*), waiting until a
client has issued a request to connect. The socket must have already
been initialized: after it's been closed, though, you can call
ipc-server-connect again. This sets the sockfig's stream to what's
opened, and returns the sockfig.  "
  (declare (special *last-sockfig*))
  (if (not (sockfig-ready-p sf))
      (warn "IPC-SERVER-CONNECT: ~a isn't listening!" sf)
    ;; this doesn't wait if the socket is closed
    (let* ((comm-socket (test-c-return
		    (sock-accept-conn (sockfig-init-socket sf)))))
      (when *trace-ipc*
	(format t "~%;; SOCK-ACCEPT-CONN returned ~A" comm-socket))
      (if (= comm-socket -1)
	  (warn "IPC-SERVER-CONNECT: sock-accept-conn failed for ~a!" sf)
	(setf (sockfig-comm-socket sf) comm-socket
	      (sockfig-stream sf) (make-socket-stream comm-socket)
	      (sockfig-status sf) :open))))
  sf)


(defmacro WITH-IPC-CONNECTION (&rest body)
  "Open a connection as a client on HOST and PORT: the server should
already be listening. Execute the body, and then close the
connection, and return the result of evaluating body, preserving
multiple values. Within the score of this macro, *init-socket*,
*ipc-stream*, and *last-sockfig* are locally bound. "
  (declare (special *ipc-default-host* *ipc-default-port* *last-sockfig*))
  `(let* ((port *ipc-default-port*)
	  (host *ipc-default-host*)
	  (comm-socket (test-c-return (sock-client-init host port))))
     (when *trace-ipc*
       (format t "~%;; SOCK-CLIENT-INIT returned ~A for ~a:~s"
	       comm-socket port host))
     (if (> comm-socket -1)
	 (let* ((stream (make-socket-stream comm-socket))
		(*last-sockfig*
		 (make-sockfig :host host :port port
			       :comm-socket comm-socket
			       :status :connected
			       :stream stream
			       :type :client)))
	   (setq *safety-net-sf* *last-sockfig*)
	   (unwind-protect
	       (handle-errors-if-possible
		(warn "Error inside WITH-IPC-CONNECTION: ~a" '(progn ,@body))
		(let ((result (multiple-value-list (progn ,@body))))
		  (values result)))

	     (ipc-close-stream *last-sockfig*)))
       (warn "WITH-IPC-CONNECTION: couldn't open connection for ~a:~s"
	     port host))))

;; this ought to be the rightful owner of the name ipc-close-connection
(defun IPC-CLOSE-STREAM (&optional (sf *last-sockfig*))
  "Close the stream for SOCKFIG, which defaults to
*last-sockfig*. Servers can re-open it again with IPC-SERVER-CONNECT (the
client side needs to be re-initialized). "
  (when *trace-ipc* (format t "~%;; calling IPC-CLOSE-STREAM for ~a" sf))

  ;; quickie handler for a broken-pipe/socket...CRH, 7-30-96.
  (handler-case
   (close (sockfig-stream sf))
   ;; broken pipe/socket
   ;; gotta do these next few things no matter what...
   (file-error (e)
	       (declare (ignore e))
     t)
   (program-error (e) (if (null (sockfig-stream sf)) t))
   )        
  (setf (sockfig-stream sf) ())
  (setf (sockfig-comm-socket sf) nil)
  (if (eq (sockfig-type sf) :server)
      (setf (sockfig-status sf) :listening)
    (setf (sockfig-status sf) :closed))
  sf)

#|
;; this should go away
(defun IPC-CLOSE (&optional (sf *last-sockfig*))
  "Close the stream and socket connection for SOCKFIG, reset its
status to :closed, and remove the lock file: you have to re-initialize
it once you do this. Returns sockfig. " 
  (declare (special *trace-ipc*))
  (when *trace-ipc* (format t "~%;; calling IPC-CLOSE for ~a" sf))
  (when (sockfig-init-socket sf)
    (let ((result (test-c-return (sock-close (sockfig-init-socket sf)))))
      ;; maybe only do this if the result is okay? 
      (setf (sockfig-init-socket sf) nil
	    (sockfig-status sf) :closed
	    (sockfig-stream sf) nil)
      result)))
|#


(defun IPC-SERVER-SHUTDOWN (&optional (sf *last-sockfig*))
  "Do final cleanup on SOCKFIG, presumably because you're killing the
server. "
  (if (sockfig-p sf)
      (let ((return
	     (when (sockfig-init-socket sf)
	       (test-c-return (sock-close (sockfig-init-socket sf))))))
	(when *trace-ipc* (format t "~%;; SOCK-CLOSE returned ~A for ~a" return sf))
	;; reset the sockfig to show it's closed
	(setf (sockfig-init-socket sf) nil
	      (sockfig-stream sf) nil
	      (sockfig-status sf) :closed)
	;; remove the lockfile
	(let ((pid-file (format nil "/tmp/.ipc-~d" (sockfig-port sf))))
	  (if (probe-file pid-file)
	      (delete-file pid-file)))
	sf)
    (warn "IPC-SERVER-SHUTDOWN: invalid sockfig, can't shutdown.")))

#|
;; this is tailored for two-socket connections, so watch the defaults
;; NOW BADLY OUT OF SYNC! sboisen 7/17/96
(defun IPC-CLOSE-CONNECTION (&optional (comm-socket *comm-socket*))
  "Close the socket connection: you have to re-open it once you do this."
  (declare (special *comm-socket*))
  (when *trace-ipc*
      (format t "~%;; calling IPC-CLOSE-CONNECTION"))
  (let ((result (sock-close comm-socket)))
    ;; set these to nil so we can tell things are closed
    (setq *comm-socket* nil
	  *ipc-stream* nil)
    result))
|#



;;; Define my own client connect and disconnect functions (DER)

(defun ipc-client-connect (&optional (host *ipc-default-host*)
				     (port *ipc-default-port*))
  (let ((comm-socket (test-c-return (sock-client-init host port))))
     (when *trace-ipc*
       (format t "~%;; SOCK-CLIENT-INIT returned ~A for ~a:~s"
	       comm-socket port host))
     (if (> comm-socket -1)
	 (let* ((stream (make-socket-stream comm-socket))
		(sf
		 (make-sockfig :host host :port port
			       :comm-socket comm-socket
			       :status :connected
			       :stream stream
			       :type :client)))
	   (setq *last-sockfig* sf))
       (warn "WITH-IPC-CONNECTION: couldn't open connection for ~a:~s"
	     port host))
     ))


(defun ipc-client-disconnect (&optional (sf *last-sockfig*))
  (when *trace-ipc*
	(format t "~%;; calling IPC-CLIENT-DISCONNECT for ~a" sf))
  (when (sockfig-comm-socket sf)
	(ipc-close-stream sf)
	(setf (sockfig-init-socket sf) nil
	      (sockfig-status sf) :closed
	      (sockfig-stream sf) nil)
	t)
  )


(defun ipc-listen (&optional (sf *last-sockfig*))
  (let ((stream (sockfig-stream sf)))
    (if (streamp stream) 
	(listen stream)
      :EOF)))


;;; Non-blocking server connection function

(defun IPC-SERVER-CONNECT-NO-BLOCK (&optional (sf *last-sockfig*))
  "Listen until a server connection is established on the socket
associated with SOCKFIG (defaults to *last-sockfig*), waiting until a
client has issued a request to connect. The socket must have already
been initialized: after it's been closed, though, you can call
ipc-server-connect again. This sets the sockfig's stream to what's
opened, and returns the sockfig.  "
  (declare (special *last-sockfig*))
  (if (not (sockfig-ready-p sf))
      (warn "IPC-SERVER-CONNECT-NO-BLOCK: ~a isn't listening!" sf)
    ;; this doesn't wait if the socket is closed
    (let* ((comm-socket (test-c-return
		    (sock-accept-conn-no-block (sockfig-init-socket sf)))))
      (when *trace-ipc*
	(format t "~%;; SOCK-ACCEPT-CONN returned ~A" comm-socket))
      (cond ((= comm-socket -1)
	     (warn "IPC-SERVER-CONNECT: sock-accept-conn failed for ~a!" sf))
	    ((= comm-socket 0)
	     :EWOULDBLOCK)
	    (t
	     (setf (sockfig-comm-socket sf) comm-socket
		   (sockfig-stream sf) (make-socket-stream comm-socket)
		   (sockfig-status sf) :open)
	     sf)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; utility functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun server-already-exists-p (port)
  "Is there already a server running on this port? Checks for a file
named /tmp/.ipc-<portnumber>: if the file exists and the PID it
contains is active, then return T, else overwrite the file with the
current process' PID and return NIL."
  (progn
    (unless (fboundp 'kill)
      (def-c-function kill :entry-point "kill" :return-type :fixnum
	:arguments ((pid :fixnum) (signal :fixnum))))
    (let ((pid-file (format nil "/tmp/.ipc-~d" port))
	  (pid (excL::getpid))
	  (no-server-p nil))
      (if (probe-file pid-file)
	  (let ((old-pid (with-open-file (file pid-file :direction :input)
					 (read file))))
	    ;; kill PID 0 queries to see if there's such a process
	    (if (= (kill old-pid 0) 0)
		(warn "Server on ~d already exists." port)
	      (setq no-server-p t)))
	(setq no-server-p t))
      (when no-server-p
	(with-open-file
	 (file pid-file :direction :output :if-exists :supersede)
	 (format file "~D~%" pid))
	;; modify permissions in case a different user has to modify
	;; the file later: vector avoids some unix overhead. chyde 7/31/96
	(
	 #+ALLEGRO excl:run-shell-command
	 #+LUCID run-program
	 (format nil "chmod a+rwx ~a" pid-file)
	 #+IGNORE(vector "chmod" "chmod" "a+rwx" pid-file)
	 :wait t))
      (null no-server-p))))

(defun make-socket-stream (socket)
  "Vendor-independent way to return a bidirectional stream for a socket."
  #+LUCID(lcl::make-lisp-stream :input-handle socket
				:output-handle socket
				:auto-force t)
  #+ALLEGRO(make-instance 'excl::bidirectional-terminal-stream
			  :fn-in  socket
			  :fn-out socket))

(defparameter *stdout-sockfig* (make-sockfig :host "self"
					     :port "no port"
					     :type :server
					     :status :open
					     :stream *standard-output*)
  "Bogus sockfig attached to stdout for testing purposes (Let-bind
*last-sockfig* to this): not fully functional since there's no sockets
involved (so you can't close it). ")

;; bad naming: this is for a Lisp server with a second socket used for
;; the actual communications (ipc-wait-for-connection).
;; ipc-initialize-STREAM is for a Lisp _client_ with single socket
;; communication. These ought to be named and organized better, but
;; that requires fixes in numerous other places that i don't want to
;; mess with right now.
;; sboisen 5/8/95

#|
;; don't call these anymore! use ipc-server/client-init instead, better name
;; ... sboisen 6/24/96
(defun IPC-INITIALIZE (&optional (port *ipc-default-port*))
  (ipc-server-init port))

(defun IPC-INITIALIZE-STREAM (&optional (host *ipc-default-host*)
				 (port *ipc-default-port*))
  (ipc-client-init host port))



;; this is for when there are double connections: basically obsolete,
;; though jingtian still uses it.
;; sboisen 4/21/95
(defun IPC-WAIT-FOR-CONNECTION (&optional (init-socket *init-socket*))
  (declare (special *ipc-stream* *comm-socket*))
  (let ((comm-socket (sock-accept-conn-when-avail init-socket)))
    (when *trace-ipc*
	  (format t "~%;; IPC-WAIT-FOR-CONNECTION returned ~A" comm-socket))
    (setq *comm-socket* comm-socket)
    (setq *ipc-stream* (make-socket-stream comm-socket))
    *ipc-stream*))


(defparameter *times-to-try-accept-conn* 20)

(defun SOCK-ACCEPT-CONN-WHEN-AVAIL (init-socket)
  "This function added to force a WAIT for connection if the client
isn't ready.  LUCID does this automatically, but Allegro times out
quickly" 
  #+ALLEGRO    ;; well, it's expected to stay up forever...
  (loop ;; (dotimes (i *times-to-try-accept-conn*))
   (let ((*handle-errors* t)
	 comm)
     (handle-errors-if-possible
      (progn (sleep 5)
	     (format *standard-output* "Failed sock-accept-conn, retrying" ))
      (unless (equal -1
		     (setq comm (sock-accept-conn init-socket)))
	      (return comm)))))
  #-ALLEGRO(sock-accept-conn init-socket))
|#



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; I/O functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; this seems to hang if symbols are being printed without whitespace:
;; sboisen 6/25/96
(defun IPC-READ (&optional (sf *last-sockfig*))
  "Read from the stream associated with SOCKFIG, preserving whitespace
 (otherwise Allegro misbehaves). Returns the data, or (:EOF) on
end-of-file or a socket error. "
  ;; what to do about EOF?
 (handle-errors-if-possible
  (warn "IPC-READ got an error on ~a!" sf)

   ;;handle a broken socket here by returning :EOF ...CRH, 11-8-96.
   (let ((input (handler-case
		 (read-preserving-whitespace (sockfig-stream sf) nil '(:eof))
		 (FILE-ERROR (e)
			     (declare (ignore e))
			     '(:eof)))))
     (when *trace-ipc*
       (format t "~%;; IPC-READ on ~A< ~A" sf input))
     input)))


(defun IPC-PRINT (datum &optional (sf *last-sockfig*) (add-newline nil))
  "Currently just the lisp standard format: this works for numbers,
strings, and symbols. If there's no delimter after symbols like
whitespace, right paren, etc, they don't get seen by ipc-read until
the stream is closed. With optional arg ADD-NEWLINE non-nil, write a
newline character after the data: this matters for some readers. "
  (declare (special *last-sockfig*))
  (handle-errors-if-possible
   (warn "IPC-PRINT got an error on ~a!" sf)
   (let ((stream (sockfig-stream sf)))
     (write datum :stream stream :base 10 :escape t)
     (when add-newline
       (write #\Newline :stream stream :escape nil))
     (when *trace-ipc*
       (format t
	       (if add-newline
		   "~%;; IPC-PRINT on ~a> |~s
|"
		 "~%;; IPC-PRINT on ~a> |~s|")
	       sf datum))
     (finish-output stream))))


(defun IPC-LENGTH-PRINT (&key (string nil)
			      (status 1)
			      (sf *last-sockfig*))
  "Print STRING to the stream for SOCKFIG, including STATUS and the
length of STRING, following the NEP-like protocol:
  <status><nl><length><nl><response>" 
  (declare (special *trace-ipc*))
  (handler-case
   (let ((stream (sockfig-stream sf))
	 (true-len #-ICS (length string)
		   ;; EUC puts a NULL at the end: chyde
		   #+ICS (1- (length (string-to-euc string)))))
     (when *trace-ipc*
       (format t "~%;; IPC-LENGTH-PRINT on ~a> status=~d, ~s" sf status string))
     (format stream "~D~%~D~%" status true-len)
     (when string
       (princ string stream))
     (finish-output stream))
   ;;no socket at all
   (ERROR (e) e (if (null sf)
		    (warn "Tried to write to a non-existent socket.")))
   ;;equal socket closed by client for some reason (like it got killed)
   (FILE-ERROR (e) e (warn "IPC-LENGTH-PRINT got an error on ~a!" sf))))

(defun IPC-PRINT-AND-CHECK-OK (datum &key (sf *last-sockfig*)
				     (read-braces nil))
  "Print DATUM using IPC-PRINT with a newline, read the return value
using IPC-LENGTH-READ, and warn if it's not OK. On success, returns
two values: the result (which is an empty string if there's no
response), and the status. Returns :EOF on end-of-file, and NIL on
failure. See ipc-length-read about key arg :read-braces. "
  (declare (special *readtable*))
  (unless (sockfig-connected-p sf)
    (warn "IPC-PRINT-AND-CHECK-OK: sockfig not connected.")
    (return-from ipc-print-and-check-ok nil))
  (handle-errors-if-possible
   (warn "IPC-PRINT-AND-CHECK-OK got an error on ~a!" sf)
   (ipc-print datum sf t)
   (multiple-value-bind
    (result status)
    (ipc-length-read :sf sf :read-braces read-braces)
    (case result
	  (:eof
	   (warn "IPC-PRINT-AND-CHECK-OK: got EOF on ~a for ~s" sf datum)
	   :eof)
	  (:err
	   (warn "IPC-PRINT-AND-CHECK-OK: got error on ~a for ~s" sf datum)
	   (warn (ipc-print-and-check-ok `(id_get_error_text))))
	  ;; this should now always be T
	  (t (values result status))))))


;;; Modified so status can be any integer (DER)

(defun IPC-LENGTH-READ (&key (sf *last-sockfig*) (read-braces nil))
  "Read a line from the stream for SOCKFIG to get the number of bytes
of data, and then the appropriate number of bytes to get all of the
data. This is for fetching return values from commands designed to
write to TCL/TK GUIs. When successful, returns two values: the data
and the status. If there's a problem reading, returns the two values
:EOF or :ERR and a symbol indicating where the problem occurred
<:length, :status, or :data>. If key arg :read-braces is non-nil, then
read the data specially using an altered readtable <!> and return a
list, otherwise return a string. "
  (declare (special *trace-ipc))
  (handle-errors-if-possible
   (warn "IPC-LENGTH-READ got an error on ~a!" sf)
   
   (let* ((stream (sockfig-stream sf))
	  (status-line (read-line stream nil :eof))
	  status)
     (if (eq status-line :eof)
	 (return-from ipc-length-read (values :eof :status))
       (let* ((status (parse-integer status-line)))
	   (let* ((len-line (read-line stream nil :eof)))
	     (if (eq len-line :eof)
		 (return-from ipc-length-read (values :eof :length))
	       (let* ((len (parse-integer len-line))
		      data)
		 (setq data
		       (if read-braces
			   (let ((*readtable* *IPC-READ-BRACES-READTABLE*))
			     (read-preserving-whitespace stream nil '(:eof)))
			 (concatenate
			  'string
			  (loop for i to (1- len) collect (read-char stream)))))
		 (when *trace-ipc*
		   (format t "~%;; IPC-LENGTH-READ on ~a> (~d bytes, status=~d) ~A"
			   sf len status data))
		 (values data status)))))))))


;; better know what you're doing if you go messing with this ... 
(defvar *IPC-READ-BRACES-READTABLE*
  (let ((*readtable* (copy-readtable)))
    (set-macro-character #\} (get-macro-character #\)))
    (flet ((read-right-brace (stream char)
			     (declare (ignore char))
			     (read-delimited-list #\} stream)))
	  (set-macro-character #\{ #'read-right-brace))
    *readtable*)
  "Alternate readtable in which braces act like parenthesis: used for
reading output intended for TCL. ")

(defun IPC-READ-BRACES (&optional (sf *last-sockfig*))
  "Read from the stream for SOCKFIG the status, check it, read the
length of the data response (and toss them), and then read data
delimited by braces as a list (so if the braces aren't balanced, this
will lose). This is for reading from functions that think they're
writing to TCL. Returns NIL on end-of-file, or the list (:EOF).
WARNING: this function locally changes the readtable. "
  (handle-errors-if-possible
   (warn "IPC-READ-BRACES got an error on ~a!" sf)
   (let ((stream (sockfig-stream sf))
	 data)
     (setq
      data
      (catch :irb-eof
	(if (eq (read-char-no-hang stream nil :eof) :eof)
	    (throw :irb-eof :eof)
	  ;; more robust to parse an integer out of this? ... sboisen 9/4/97
	  (let ((status (read-line stream nil :eof)))
	    (if (find :eof status)
		(throw :irb-eof :eof)
	      (let ((len (read-line stream nil :eof)))
		(if (find :eof len)
		    (throw :irb-eof :eof)
		  (let* ((true-len (parse-integer len :junk-allowed t))
			 (input nil))
		    (unless (string= status "1 ")
		      (warn "IPC-READ-BRACES: status ~a, returning NIL." status)
		      (return-from ipc-read-braces nil))
		    (let ((*readtable* *IPC-READ-BRACES-READTABLE*))
		      (setq input (read-preserving-whitespace stream nil '(:eof))))
		    (when *trace-ipc*
		      (format t "~%;; IPC-READ-BRACES on ~a> (~d data bytes, status=~a) ~%;;~A"
			      sf (- true-len 2) status input))
		    input))))))))
     (if (eq :eof data)
	 (warn "IPC-READ-BRACES: EOF on ~a" sf)
       data))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; The foreign function stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when
 (eval load)

 (progn

   ;; Load C socket code
   (when *load-sock-file-p*
	 (cond ((probe-file  *socket-interface-object-file*)
		(unless *building-standalone?*
			(
			 #+LUCID lucid::load-foreign-files
			 #+ALLEGRO load
			 *socket-interface-object-file*)
			(setf *load-sock-file-p* nil)))
	       (t
		(warn "__________________________________________________~%~
Couldn't find *socket-interface-object-file*,~%~
~s~%~
The socket interface won't work without it: talk to a C developer ~
about what's wrong~%~
__________________________________________________"
		      *socket-interface-object-file*))
	       ))

   ;; Define LISP interface functions to C socket code.

   ;; Takes a port number for the TCP/IP connection. Returns a
   ;; fixnum for the socket.
   (def-c-function sock-server-init :return-type :fixnum
     :entry-point "sock_server_init"
     :arguments ((port :fixnum)))

   ;; for clients, not servers
   ;; sboisen 4/21/95
   (def-c-function sock-client-init :return-type :fixnum
     :entry-point "sock_client_init"
     :arguments ((host #+ICS (simple-array (unsigned-byte 8))
		       #-ICS :string)
		 (port :fixnum)))

   ;; Takes a init-socket (like sock-server-init returns), and opens a
   ;; communications socket. "
   (def-c-function sock-accept-conn :return-type :fixnum
     :entry-point "sock_accept_conn"
     :arguments ((init-socket :fixnum)))

   ;; Takes a init-socket (like sock-server-init returns), and opens a
   ;; communications socket. "
   (if *sock2p*
	 (def-c-function sock-accept-conn-no-block :return-type :fixnum
	   :entry-point "sock_accept_conn_no_block"
	   :arguments ((init-socket :fixnum)))
	 )

   (def-c-function sock-close :return-type nil
     :entry-point "sock_close"
     :arguments ((init-socket :fixnum)))
   )
   

   )

(export '(*trace-ipc* *ipc-default-host* *ipc-default-port*
		      ipc-server-init ipc-server-connect
		      ipc-close-stream ipc-server-shutdown
		      with-ipc-connection ipc-client-connect 
		      ipc-client-disconnect ipc-listen ipc-read
		      ipc-print ipc-length-print ipc-length-read
		      sockfig-connected-p sockfig-ready-p))

(provide 'socket-interface)


