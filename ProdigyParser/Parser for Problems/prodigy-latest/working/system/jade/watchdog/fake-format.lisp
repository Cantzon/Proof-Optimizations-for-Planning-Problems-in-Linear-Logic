;;; Load this file into a lisp process and call the function 
;;; (start-fake-format FILE) 
;;; where FILE is the trace file of messages to send to Prodigy
;;;
;;; (start-fake-format "/fs/parka2/format/format-1.4.1/data/prodigy/history/prodigy-trace.10-24-97.1026")
;;; (start-fake-format "/afs/cs/project/prodigy-1/format/PRODIGY.05-16-97.0947")

;;; Load the watchdog code.

(defvar *system-directory*
    "/afs/cs/project/prodigy/version4.0/working/system/")

(defpackage "FE")
(defvar FE::*format-directory*
    (concatenate 'string *system-directory* "jade/"))


;;; SET PATH
(load (concatenate 'string FE::*format-directory* "watchdog/watchdog.lisp"))


(use-package :watchdog)


;;; Default hostname for Prodigy
(defvar *default-prodigy-hostname* "yoyoma.prodigy.cs.cmu.edu")
;(defvar *default-prodigy-hostname* "gama.prodigy.cs.cmu.edu")

;;; Default port number for Prodigy
(defvar *default-prodigy-port* 3283)
;(defvar *default-prodigy-port* 5003)


;;; Sleep time between messages
(defvar *sleep* 4)



(defun start-fake-format (file)
  (format t "~&========================================~%")
  (format t "Connecting to Prodigy server...~%")

  (cond ((watchdog:client-connect *default-prodigy-hostname* 
				  *default-prodigy-port*)

	 (format t "...Connected.~%")
	 (format t "========================================~%")

	 (with-open-file 
	  (in file :direction :input)
   
	  (let (message)
	    (loop
	     (let ((msg (watchdog:watchdog-read-message)))
	       (when msg
		     (format t "~&Received message ~D~%   ~S~%"
			     watchdog::*watchdog-received-message-count*
			     msg)))
	     
	     (setq message (read in nil :eof))
	     (when (eq message :eof) (return))
	     (when (member (second message) *prodigy-events-to-trace*)
		   (format t "~&Sending message ~D~%   ~S~%"
			   (1+ watchdog::*watchdog-sent-message-count*)
			   message)
		   (watchdog:watchdog-send-message message)
		   (sleep *sleep*)
		   )
	     ))
	  )
	 (format t "Disconnecting from Parka server~%")
	 (watchdog:client-disconnect)

	 (format t "Fake ForMAT finished.~%")
	 t)

	(t
	 (format t "Unable to connect to Prodigy server.~%")
	 (format t "========================================~%")
	 nil)
	))

		  

(defparameter *prodigy-events-to-trace*
  '(
    ;; SMC 6/26/1996.  Task window
    :set-task-status
    ;; SMC 3/15/1996.  Newer goal ops.
    :completed-prodigy-tasks
    :load-goals
    :copy-goal
    :paste-ulns
    :duplicate-fm-records
    :add-parent
    :add-child
    :remove-parent
    :remove-child
    ;; SMC 3/15/1996.  Ops no longer used by the goal editor.
    :add-new-subgoal
    ;; Goal ops
    :change-goal-name
    :set-guidance
    :save-goals
    :delete-goals
    :add-new-goal
    :quit-goal-editor
    :set-active-goals
    :copy-goals-to-features
    :check-goal-consistency
    :cut-subgoals
    :add-subgoal
    :edit-goals
    ;; FM ops
    :copy-fm
    :create-fm
    :delete-fms
    :execute-fm-query
    :retrieved-cases
    ;; ULN ops
    :cut-ulns
    :set-edit-uln-fields
    :change-uln-fields
    ;; FM features
    :paste-features
    :define-feature
    :add-fm-feature
    :delete-features
    :change-feature-value
    ;; TPFDD actions
    :load-tpfdd
    :create-tpfdd
    :save-tpfdd
    ;; Casebase
    :save-casebase
    ;; Misc
    :autoload
    :fm-query-report
    :save-default-features
    :exit-format

    :report-uln-ratios-report
    :report-P4-ratios-report
    ))






