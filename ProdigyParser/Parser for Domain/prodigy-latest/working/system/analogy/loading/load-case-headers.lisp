;;; Manuela Veloso

(setf *case-headers* nil)

;;;***************************************************************************
;;; Loads all the case headers from a given directory
;;; As default, it loads the case headers in the current case headers dir

(defun load-all-case-headers (&key (case-dir (concatenate 'string *problem-path* 
							  "probs/cases/headers/")))
  (apply #'load-case-headers (return-file-strings case-dir)))

(defun return-file-strings (dir-string)		     
  (mapcar #'pathname-name (directory dir-string)))

;;;***************************************************************************
;;; Call (load-case-headers "case-bb2-2" "case-test-5-14-4" "case-bb1-5")

(defun load-case-headers (&rest case-list)
  (setf *case-headers* nil)
  (dolist (case case-list)
    (setf *path-to-case-header*
	  (concatenate 'string *problem-path* "/probs/cases/headers/" case ".lisp"))
    (load-case-header case))
  (format t "~%~% Done loading all case headers!")
  (format t "~% The global variable *case-headers* points at them."))

(defun load-case-header (case)
  (setf *path-to-case-header*
	(concatenate 'string *problem-path* "/probs/cases/headers/" case ".lisp"))
  (setf problem-solved nil
	goal nil
	initial-state nil
	case-objects nil
	footprint-by-goal nil
	insts-to-vars nil
	result nil)
  (load *path-to-case-header*)
  (format t "~% Creating case header for ~S" case)
  ;;It has the same name as a guiding case in different structure types.
  (setf case-header
	(make-case-header
	 :name case
	 :problem problem-solved
	 :goal goal
	 :initial-state (or initial-state ':not-computed)
	 :objects case-objects
	 :footprint footprint-by-goal
	 :insts-to-vars insts-to-vars
	 :result result
	 ))
  (push case-header *case-headers*)
  (format t "~% Done loading case header!")
  (format t "~% It was pushed into the list *case-headers*.")
  nil)

(defun show-case-header (case-header)
  (format t "~% name ~S" (case-header-name case-header))
  (format t "~% problem ~S" (case-header-problem case-header))
  (format t "~% goal ~S" (case-header-goal case-header))
  (format t "~% initial-state ~S" (case-header-initial-state case-header))
  (format t "~% objects ~S" (case-header-objects case-header))
  (format t "~% footprint ~S" (case-header-footprint case-header))
  (format t "~% insts-to-vars ~S" (case-header-insts-to-vars case-header)))


;;; case-name is a string, e.g. "case-prob1-robot", and
;;; the variable *case-cache* is a list of all the case-headers
;;; loaded.

(defun get-case-header-from-case-name (case-name)
  (find-if #'(lambda (x) (string= (case-header-name x) case-name))
	   *case-headers*))

