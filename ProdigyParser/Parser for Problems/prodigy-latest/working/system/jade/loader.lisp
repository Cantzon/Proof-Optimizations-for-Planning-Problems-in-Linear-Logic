(unless (find-package "FRONT-END")
  (make-package "FRONT-END" :nicknames '("FE") :use '("LISP" "P4")))

(in-package "FRONT-END")

(export '(load-jade-source jade-compile-all))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; JADE (Prodigy/Analogy--ForMAT) front end loader code
;;;
;;; The front end accepts ForMAT input and provides case modification
;;; suggestions to its user in the Jade integrated system.

;;; History
;;;
;;; 22jul98 Deleted function load-f and removed it from export list because it
;;; is now obsolete. [cox]
;;;

;;; ASSUME that Prodigy is already loaded.


(defparameter *format-directory* 
  (concatenate 'string 
	       user::*system-directory* "jade/")
  "Base pathname for the JADE front-end.")



(defparameter *format-binary-pathname*
  (user::set-binary-path *format-directory*)
  )




;;;
;;; The program parameter *front-end-files* comprises the list of filenames 
;;; (without extension) for the PRODIGY/ForMAT system. 
;;;
(defparameter *front-end-files*
  '("front-end"
    "messages"
    "utils"
    "prodigy-suggestions"
    "set-problem"
    "problem-file"
    "transformations"   
    "goal-reorder"
    "retrieve"
    "ratio-rep"
    "case-list"
    "jade"
    "prodigy-patch"
    )
  "The list of files for the PRODIGY/ForMAT interface.")

(defparameter *front-end-modules* 
  `(("/watchdog/sockets/" "c-interface" "socket-interface2")
    ("/watchdog/" "watchdog")
    ("/source/" ,@*front-end-files*)
    )
  )


;;;
;;; The *ForMat-Loaded* flag is used to tell the build-problem-statement 
;;; function whether or not it should try to translate ForMAT goals into 
;;; PRODIGY form. This is only used when the front-end to ForMAT is loaded. 
;;; Such code should set this flag to t when this is the case. 
;;;
(defvar *ForMat-Loaded* nil
  "Indicates whether PRODIGY is working with JADE front-end.")


;;;
;;; IMPORTANT SOCKET VARIABLES
;;;
;;; In addition to the variables and parameters in this loader file, the
;;; following are important program parameters in the socket code:
;;;
;;; *sockets-directory* *sock2p* *socket-interface-object-file*
;;; *building-standalone?* 
;;;
;;; See file watchdog/sockets/socket-interface2.lisp.
;;;



;;;
;;; FUNCTION DEFINITIONS
;;;

(defpackage :sockfig)

(defun load-jade-source ()
  (dolist (each-mod *front-end-modules*)
    (dolist (each-file (cdr each-mod))
      (user::p-load 
       (car each-mod) 
       each-file 
       *format-directory*)))
  ;; Setting to nil makes sure that it is not loaded by socket-interface2.lisp
  (setf sockfig::*load-sock-file-p* nil)
  (setf *format-loaded* t))



(defun load-jade (&aux
		  (ender 
		   (concatenate 
		    'string 
		    "." 
		    user::*binary-extension*)))
  (dolist (each-mod *front-end-modules*)
	  (dolist (each-file (cdr each-mod))
		  (load (concatenate 
			 'string 
			 *format-binary-pathname* 
			 each-file 
			 ender))))
  (setf *format-loaded* t)
  )

(defun jade-compile-all ()
  (dolist (each-mod *front-end-modules*)
	  (dolist (each-file (rest each-mod))
		  (user::p-compile 
		   (first each-mod)
		   each-file 
		   *format-directory* 
		   *format-binary-pathname*)))
  )


(setf p4::*always-remove-p* t)

;;; Here is where the assumption that it is previously compiled comes
;;; into play.
(defvar *load-format-immediately* t)

(when *load-format-immediately*
      (load-jade)
      (format t "~%;;; Prodigy/CBMIP is loaded.~%~%")
      )



