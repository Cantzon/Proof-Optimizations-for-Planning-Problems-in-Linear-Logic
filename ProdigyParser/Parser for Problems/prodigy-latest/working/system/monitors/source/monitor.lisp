(in-package user)

;;; For some implementation comments, see file README

;;; The open-node-p calls in the dynamically created control rules are probably
;;; redundant. [cox 7apr98]

;;;
;;; I still need to handle the situation where the forall literal is shared by
;;; another (sub)goal in the goal tree.

;;;
;;; The two main functions are try-2-create-forall-handler and
;;; create-precond-handlers. If *use-monitors-p* is non-nil, then the Prodigy
;;; function (in package P4) really-expand-operator will call them to install
;;; any monitors as :state-change interrupt handlers. The file patches.lisp
;;; modifies really-expand-operator to do this.
;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Standard MONITORS (non-universally quantified, i.e., forall, monitors)


;;; Note that this will create handlers for the *finish* node as well as
;;; regular binding nodes. We want this to happen because in the case of top
;;; level goals that are existential goals, we might wish to try different
;;; bindings given new info.
;;;
;;; We are handling all preconditions here. Both open preconditions for which
;;; Prodigy will plan, and satisfied preconditions for which Prodigy will do
;;; nothing. These are really misnomers. Open literals are just dynamic
;;; preconditions that are currently not true in the state. If the goal is to
;;; have the literal false, then it would actually be satisfied since prodigy
;;; would not have to plan for it. This distinction is handled in the
;;; predicates open-precond-now-satisfied-p and satisfied-precond-now-open-p.
;;;
(defun create-precond-handlers (bnode
				&aux
				false-literals)
  (multiple-value-bind 
   (dynamic-preconds static-preconds)
   (ret-dynamic-preconds 
    (p4::binding-node-instantiated-op 
     bnode))
   (setf false-literals
	 (ret-non-true-literals 
	  dynamic-preconds))
   ;; The next two dolist forms establish alternative-base-subgoal monitors
   (dolist (each-false-precond 
	    false-literals)
	   (multiple-value-bind 
	    (monitor monitor-name)
	    (create-monitor
	     bnode each-false-precond)
	    (spawn-handler 
	     bnode monitor monitor-name each-false-precond)))
   (dolist (each-true-precond 
	    (set-difference		;True literals
	     dynamic-preconds 
	     false-literals))
	   (multiple-value-bind 
	    (monitor monitor-name)
	    (create-monitor
	     bnode each-true-precond t)
	    (spawn-handler 
	     bnode monitor monitor-name each-true-precond)))
   (if *monitor-trace*
       (format t "STATIC PRECONDS: ~%~S~%" static-preconds))
   ;; The next dolist form establishes alternative-base-usability monitors.
   (if (not (equal '(AND) static-preconds))
       (dolist (each-static-precond
		static-preconds)
	       (multiple-value-bind 
		(monitor monitor-name)
		(create-usability-monitor 
		 bnode each-static-precond)
		(spawn-handler 
		 bnode monitor monitor-name each-static-precond)))))
  )



;;;
;;; Assume that all predicates passed as the argument predicate will be either
;;; a literal or a list with the first element the tilde (negation symbol) and
;;; the second element a literal.
;;;
;;; Need to check on how negated preconditions are actually handled during
;;; planning to get this function right.
;;;
(defun create-usability-monitor 
  (bnode 
   predicate
   &aux
   (negated-literal-p
    (and (consp predicate)
	 (eq (first predicate)
	     '~)))
   (true-literal-p
    (p4::literal-state-p 
     (if negated-literal-p (second predicate)
       predicate)))
   (monitor-name
    (gentemp 
     (format 
      nil 
      "USABILITY-MONITOR~a."
      (p4::binding-node-name
       bnode))))   )
  "Generate a closure to implement a monitor for usability condition changes."
  (values
   (function
    (lambda (signal
	     &aux
	     (signal-data (rest signal)))
      (declare (ignore signal))
      (if (satisfied-precond-now-open-p 
	   signal-data 
	   (if negated-literal-p
	       (second predicate)
	     predicate)
	   true-literal-p
	   negated-literal-p)
	  (jump-2-node bnode signal-data monitor-name))))
   monitor-name)
  )



;;;
;;; Function create-monitor generates a Prodigy signal-handler for
;;; :state-change interrupts raised by the sense-world signal-handler. It
;;; returns two values. The monitor (signal-handler) and the name of the
;;; monitor. The purpose of the monitor will be to watch for the arrival of new
;;; information confirming a state for which we are planning an achievement,
;;; disconfirming a state we believed to be satisfied, or bearing on the
;;; relevancy of an alternative operator.
;;;
;;; The bnode argument is a binding node in the planning search tree.  The
;;; predicate argument is a copy of the operator precondition that constitutes
;;; the planning rationale for the monitor. The true-literal-p flag indicates
;;; whether predicate was true or false in the state when the monitor was
;;; generated (i.e., when the bnode was created).
;;; 
;;; The signal-data structure will be a list of two elements. The first item is
;;; either the symbol 'a or 'd corresponding to whether the new information is
;;; an add or a delete. The seconds list element is the new literal.
;;;
(defun create-monitor (bnode 
		       predicate
		       &optional
		       true-literal-p
		       &aux
		       (monitor-name
			(gentemp 
			 (format 
			  nil 
			  "MONITOR~a."
			  (p4::binding-node-name
			   bnode))))
		       )
  "Generate a closure to implement an environmental planning monitor."
  (values
   (function
    (lambda (signal
	     &aux
	     (signal-data (rest signal)))
      (declare (ignore signal))
      (cond ((open-precond-now-satisfied-p
	      signal-data predicate true-literal-p 
	      (p4::literal-neg-goal-p predicate))
	     (undo-planning-attempt 
	      bnode signal-data predicate monitor-name true-literal-p))
	    ((satisfied-precond-now-open-p
	      signal-data predicate true-literal-p 
	      (p4::literal-neg-goal-p predicate))
	     (cond ((member (p4::literal-name predicate)
			    (p4::problem-space-static-preds 
			     *current-problem-space*))
		    (if *monitor-trace*
			(format t
				"~%MONITOR ERROR: Should not be at this point.~%"))
		    (jump-2-node	; Should not be possible since only
		     bnode		; dynamic variables are monitored by
		     signal-data	; this function.
		     monitor-name))
		   (t
		    (do-add-to-pending-goals
		     bnode signal-data predicate monitor-name true-literal-p))))
	    ((eq (first (second signal-data))
		 (p4::literal-name predicate))
	     (handle-conspiracy-change
	      bnode signal-data predicate monitor-name true-literal-p)))))
   monitor-name)
  )


;;; Note there exists a add-to-pending-goals function in
;;; matcher-interface.lisp. Is it useful?
;;;
(defun do-add-to-pending-goals (bnode 
			     signal-data 
			     predicate
			     monitor-name 
			     true-literal-p)
  (if *monitor-trace*
      (format t "~%Execute function do-add-to-pending-goals~%"))
  (let ((done-var (gentemp "DONE-VAR"))
	(parent-bnode (give-me-node-of-type 
		       'p4::binding-node 
		       (p4::binding-node-parent bnode))))
    (set done-var nil)
    ;; Create a one-shop control rule to jump to goal node above bnode.
    (eval `(control-rule ,(gentemp 
			   "CR-ONE-SHOT-ADD-GOAL-")
			 (if (and (one-shot ,done-var)
				  (candidate-node 
				   ,parent-bnode)
				  (open-node-p ,parent-bnode)))
			 (then select node ,parent-bnode))))
  ;(p4::add-to-pending-goals predicate bnode) ;Does not seem to do anything
;  (break)
  )


;;;
;;; Function jump-2-node is used to implement the closing of a binding node in
;;; the Prodigy search tree when a monitor detect that a usabillity condition
;;; suddenly becomes false. It is called by the lambda closure returned by
;;; create-usability-monitor and installed as an interrupt handler by function
;;; spawn-handler.
;;;
(defun jump-2-node (bnode signal-data monitor-name
			   &aux 
			   (done-var (gentemp "DONE-VAR"))
			   (parent-opnode (give-me-node-of-type 
					  'p4::operator-node 
					  (p4::binding-node-parent bnode)))
			   (parent-gnode (give-me-node-of-type 
					  'p4::goal-node 
					  (p4::binding-node-parent bnode))))
  (when (ok-stream)
;	(send-to-tcl (format nil "Notices ~s" monitor-name))
	(if (eq (first signal-data) 'a)
	    (send-to-tcl ;Signal the data
	     (format nil "SData ~s {~s}" monitor-name (second signal-data)))
	  (send-to-tcl ;Signal negative data
	   (format nil "SNData ~s {~s}" monitor-name (second signal-data))))
;	(send-to-tcl (format nil "SData ~s" (second signal-data)))
	)
  (if *monitor-trace*
      (format t 
	      "~%Execute of function jump-2-node from bnode ~s~%"
	      bnode))
					;  (break)
  ;; Changed from close-node call. [cox 7apr98]
  (p4::close-node-and-children 
   bnode 
   :sensed-delete-of-usability-condition)
  (set done-var nil)
  ;; Create a one-shot control rule to jump to op node above bnode.
  ;; Should really only create this if there exists valid binding alternatives.
  (eval `(control-rule ,(gentemp 
			 "CR-ONE-SHOT-JUMP-2-NEW-BINDING-")
	    (if (and (one-shot ,done-var)
		     (candidate-node 
		      ,parent-opnode)
		     (open-node-p ,parent-opnode)))
	    (then select node ,parent-opnode)))
  ;;Make another unique variable identifier.
  (setf done-var (gentemp "DONE-VAR"))
  (set done-var nil)
  ;; Create a one-shot control rule to jump to goal node above bnode.
  ;; Should really only create this if there exists valid op alternatives.
  (eval `(control-rule ,(gentemp 
			 "CR-ONE-SHOT-JUMP-2-NEW-OP-")
	    (if (and (one-shot ,done-var)
		     (candidate-node 
		      ,parent-gnode)
		     (open-node-p ,parent-gnode)))
	    (then select node ,parent-gnode)))
  )


;;;
;;; If predicate open-precond-now-satisfied-p returns t, then a state (either
;;; positive or negative) for which Prodigy was planning to achieve is now
;;; satisfied. This predicate signals that Prodigy should not plan for it any
;;; longer and should remove parts of the plan already created to achieve the
;;; state.
;;;
(defun open-precond-now-satisfied-p (signal-data 
				     predicate 
				     true-literal-p
				     neg-goal-p)
  (and
   (or
    ;; Either the literal was originally false in the state, we wanted to
    ;; achieve it, and now it is added exogenously
    (and (not true-literal-p)
	 (not neg-goal-p) ;(p4::literal-goal-p predicate)
	 (eq (first signal-data) 'a)
	 )
    ;; or the literal was originally true in the state, we wanted to make it
    ;; false, and now it is deleted exogenously.
    (and true-literal-p
	 neg-goal-p ;(p4::literal-neg-goal-p predicate)
	 (eq (first signal-data) 'd)
	 ))
   ;; and the original predicate matches the new data.
   (literal-match-p (second signal-data) predicate))
  )


;;;
;;; See comments above on predicate open-precond-now-satisfied-p, but reverse
;;; the logic.
;;;
(defun satisfied-precond-now-open-p (signal-data 
				     predicate 
				     true-literal-p
				     neg-goal-p)
  (and
   (or
    (and true-literal-p
	 (not neg-goal-p) ;(p4::literal-goal-p predicate)
	 (eq (first signal-data) 'd)
	 )
    (and (not true-literal-p)
	 neg-goal-p ;(p4::literal-neg-goal-p predicate)
	 (eq (first signal-data) 'a)
	 ))
   (literal-match-p (second signal-data) predicate)
   )
  )


;;; The new data matches the predicate exactly iff ...
;;;
(defun literal-match-p (new-data predicate)
  (and (eq (first new-data) ;The predicate symbol
	   (p4::literal-name predicate))
       (every #'(lambda (data-arg predicate-arg)
		      (eql data-arg
			   (p4::prodigy-object-name 
			    predicate-arg))
		      )
	      (rest new-data)
	      (p4::literal-arguments predicate)))
  )


(defun undo-planning-attempt (bnode 
			      signal-data 
			      predicate 
			      monitor-name 
			      true-literal-p)
  (when (ok-stream)
;	(send-to-tcl (format nil "Notices ~s" monitor-name))
	(send-to-tcl
	 (format nil "SData ~s {~s}" monitor-name (second signal-data)))
;	(send-to-tcl (format nil "SData ~s" (second signal-data)))
	)
  (if *monitor-trace*
      (format 
       t
       "~%Executed undo-planning-attempt with node ~s, predicate ~s, signal-data ~s, and true-literal-p ~s~%"
       (p4::binding-node-name bnode) predicate signal-data true-literal-p))
  (let ((done-var (gentemp "DONE-VAR")))
    (set done-var nil)
    ;; Create a one-shot control rule to jump to bnode.
    (eval `(control-rule ,(gentemp 
			   "CR-ONE-SHOT-JUMP-2-READY-STEP-")
			 (if (and (one-shot ,done-var)
				  (candidate-node 
				   ,bnode)
				  (open-node-p ,bnode)))
			 (then select node ,bnode))))
  (if (not (in-tail-plan-p bnode))
      (make-protected predicate))
  )

(defun is-protected-p (literal)
  (getf (p4::literal-plist literal) :just-sensed)
  )

(defun make-protected (literal)
  (setf (getf (p4::literal-plist literal) 
	      :just-sensed) 
	t)
  )

(defun reset-protection (literal)
  (setf (getf (p4::literal-plist literal)
	      :just-sensed) 
	nil)
  )



;;;
;;; Function find-ready-op returns the first alternative operator that has all
;;; preconditions satisfied. The alternative instatntiated operators can be
;;; found in the bindings left list of the operator node that is the parent of
;;; the binding node (bnode) passed as an argument to the function. We search
;;; for an operator who has no dynamic preconditions that are not true in the
;;; current state.
;;;
(defun find-ready-op (bnode
		      &aux
		      (inst-op-alts
		       (p4::operator-node-bindings-left
			(p4::nexus-parent bnode))))
;  (format t  "~%Alts: ~s~%" inst-op-alts)
  (some
   #'(lambda (each-alt)
       (if (eq 0
	       (length
		(ret-non-true-literals ;Make sure that this covers negative
				       ;goals. ??
		 (ret-dynamic-preconds
		  each-alt))))
	   each-alt))
   inst-op-alts)
  )

  
;;;
;;; Function ret-dynamic-preconds returns a list of unachieved dynamic
;;; preconditions to the instantiated operator. This function is called by both
;;; find-ready-op and create-open-precond-handlers.
;;;
;;; As a second return value, this function returns a list of static
;;; preconditions.
;;;
(defun ret-dynamic-preconds (inst-op
			     &aux 
			     (dynamic-literal-names
			      (p4::non-static-rule-p 
			       (p4::instantiated-op-op inst-op)))
			     (preconds 
			      (p4::instantiated-op-precond
			       inst-op)))
  "Given an instantiated operator, return all dynamic preconditions."
  (if (atom preconds)
      (setf preconds (list preconds)))
  (values
   (mapcan
    #'(lambda (each-precond)
	(if (p4::literal-p each-precond)
	    (if (member (p4::literal-name each-precond)
			dynamic-literal-names)
		(list each-precond))))
    preconds)
   (or (and				; The special case of one negative .
	(consp preconds)                ; precondition. We will assume that it 
	(eq (first preconds) '~)        ; is not of the form (~ (and ...))
	(p4::literal-p 
	 (second preconds))
	(not (member 
	      (p4::literal-name 
	       (second preconds))
	      dynamic-literal-names))
	(list preconds))                ; Return list if pass other and clauses
       (set-difference preconds 
		       dynamic-literal-names 
		       :test 
		       ;; Need to simplify this test by using the following: 
		       ;; (member (p4::literal-name predicate)
		       ;;         (p4::problem-space-static-preds 
		       ;;            *current-problem-space*))
		       #'(lambda (precond d-literal-name)
			   (or;; Is a dynamic precondition
			    (and 
			     (atom precond)
			     (eq precond 'and))
			    (and
			     (p4::literal-p precond)
			     (eq (p4::literal-name precond)
				 d-literal-name))
			    ;; Is a universally quantified  precondition
			    (and
			     (consp precond)
			     (eq (first precond)
				 'forall))
			    ;; Is an existentially quantified  precondition
			    (and
			     (consp precond)
			     (eq (first precond)
				 'exists))
			    ;; Is a negative dynamic precondition
			    (and
			     (consp precond)
			     (eq (first precond)
				 '~)
			     (eq (p4::literal-name (second 
						    precond))
				 d-literal-name)))))))
  )


;;;; Used for debugging.
;(defun temp (p-list names)
;  (cond ((null p-list ) nil)
;	((not (p4::literal-p (first p-list)))
;	 (temp (rest p-list ) names))
;	((member (p4::literal-name (first p-list))
;		 names)
;	 (cons (first p-list)
;	       (temp (rest p-list) names)))
;	(t (temp (rest p-list) names))))


;;;
;;; Given a list of literals, function ret-non-true-literals returns those
;;; literals in the list that are not yet true in the state.
;;;
;;; Will negative preconditions that are false in state have their
;;; literal-state-p slot non-nil? ??
;;;
(defun ret-non-true-literals (lit-list)
  "Return false literals."
  (cond ((null lit-list) nil)
	((p4::literal-state-p (first lit-list))
	 (ret-non-true-literals (rest lit-list)))
	(t (cons (first lit-list)
	       (ret-non-true-literals (rest lit-list))))))


;;;
;;; Function handle-conspiracy-change is called if new information is
;;; sensed that makes true a precondition for which Prodigy is (or has)
;;; planned. Is this comment current?
;;;
(defun handle-conspiracy-change (bnode signal-data predicate monitor-name true-literal-p)
  "Choose alternate bindings if new info makes all preconds t for that set of bindings."
  (when (ok-stream)
;	(send-to-tcl (format nil "Notices ~s" monitor-name))
	(send-to-tcl
	 (format nil "SData ~s {~s}" monitor-name (second signal-data)))
;	(send-to-tcl (format nil "SData ~s" (second signal-data)))
	)
  (if *monitor-trace*
      (format 
       t
       "~%Executed handle-conspiracy-change with node ~s, predicate ~s, signal-data ~s, and true-literal-p ~s~%"
       (p4::binding-node-name bnode) predicate signal-data true-literal-p))
  (let ((alternative-op (find-ready-op bnode)))
    (when alternative-op
	  (if *monitor-trace*
	      (format t 
		      "~%Alternative operator found: ~s~%"
		      alternative-op))
	  (setf *done-already* nil)
	  (let ((parent-op-node (give-me-node-of-type 
			       'p4::operator-node 
			       (p4::binding-node-parent bnode)))
		(done-var (gentemp "DONE-VAR"))
;		(parent-gnode (give-me-node-of-type 
;			       'p4::goal-node 
;			       (p4::binding-node-parent bnode)))
		)
	    (set done-var nil)
	    ;; Create a one-shot control rule to jump to binding node above bnode.
	    (eval `(control-rule ,(gentemp 
				   "CR-ONE-SHOT-JUMP-2-READY-STEP-")
                      (if (and (one-shot ,done-var)
			       (candidate-node 
				,parent-op-node)
			       (open-node-p ,parent-op-node)))
		      (then select node ,parent-op-node)))
;	    (setf done-var (gentemp "DONE-VAR"))
;	    (set done-var nil)
;	    (eval (print `(control-rule test3
;                      (if (and (one-shot ,done-var)
;			       (candidate-goal
;				,parent-gnode)))
;		      (then select goal ,parent-gnode))))
	    )
	  ))
;	  (break)
  )


;;;
;;; Predicate in-tail-plan-p returns t if the instantiated operator of the
;;; bindings node bnode has not been applied (or if applied, then is currently
;;; backtracked from the application).
;;;
;;; (eq (p4::binding-node-instantiated-op (find-node 16))
;;;     (p4::APPLIED-OP-NODE-INSTANTIATED-OP (FIND-NODE 29))) 
;;; --> T
;;;
(defun in-tail-plan-p (bnode 
		       &optional 
		       (current-node *current-node*))
  (member (p4::binding-node-instantiated-op bnode)
	  ;; From meta-predicates.lisp
	  (compute-expanded-operators current-node))
  )


(defun in-head-plan-p (bnode 
		       &optional 
		       (current-node *current-node*)
		       &aux
		       (inst-op 
			(p4::binding-node-instantiated-op 
			 bnode)))
  (some
   #'(lambda (current-node)
       (and (p4::applied-op-node-p current-node)
	    (or
	     (eq inst-op
		 (p4::applied-op-node-instantiated-op
		  current-node))
	     ;; This case handles instantiated inference rules. 
	     (some 
	      #'(lambda (current-application)
		  (eq inst-op
		      (p4::op-application-instantiated-op
		       current-application)))
	      (p4::applied-op-node-applied
	       current-node)))))
   ;; Gives the path from bnode to *current-node* if bnode is on the current
   ;; search tree branch. 
   (member bnode 
	   (p4::path-from-root 
	    *current-node*)))
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; FORALL-MONITORS

;;;
;;; Places a pointer to the interrupt handler on the plist of bnode so that if
;;; bnode is closed, then the handler can be removed. Still need to perform
;;; this removal, however.
;;;
(defun try-2-create-forall-handler (bnode)
  "Spawn a monitor when a forall precondition is a part of the inst-op."
  (multiple-value-bind (monitor monitor-name)
		       (create-forall-monitor
			bnode)
		       (if monitor
			   (spawn-handler bnode monitor monitor-name)))
  )


;;;
;;; Function create-forall-monitor uses a closure to remember the binding node
;;; from which it was spawned. Function create-forall-monitor is specific to
;;; the universally quantified expression. It establishes quantified-condition
;;; monitors.
;;;
;;; Returns two values: The monitor function and a name for the monitor.
;;;
(defun create-forall-monitor (bnode
			      &aux
			      (predicate 
			       (detect-forall-precond 
				bnode)))
  (if predicate
      (let ((monitor-name
	     (gentemp 
	      (format 
	       nil 
	       "FORALL-MONITOR~a."
	       (p4::binding-node-name
		bnode)))))
	(values
	 (function
	  (lambda (signal
		   &aux
		   (signal-data (rest signal)))
	    (declare (ignore signal))
	    (if (eq (first (second signal-data))
		    predicate)
		(check-forall-preconditions 
		 bnode signal-data monitor-name))))
	 monitor-name
	 )))
  )


(defun detect-forall-precond (bnode
			      &aux
			      (inst-precond 
			       (p4::instantiated-op-precond 
				(p4::binding-node-instantiated-op 
				 bnode))))
  "Return a constraining predicate from gen-from-pred in forall precond."
  (if inst-precond
      (first 
       ;; Extract gen-from-pred predicates in the forall clause
       (extract-predicate 
	(get-forall-precond inst-precond)))

    )
  )



;;; Example clause 
;;; (FORALL
;;; ((<CROSSING>
;;;   (AND RIVER-CROSSING 
;;;        (GEN-FROM-PRED (ENABLES-MOVEMENT-OVER <CROSSING> <RIVER>)))))
;;; (IS-DESTROYED <CROSSING>))
;;; would extract (ENABLES-MOVEMENT-OVER <CROSSING> <RIVER>)
;;;
(defun extract-predicate (clause)
  "Find predicates given to gen-from-pred within clause."
  (cond ((null clause)
	 nil)
	((atom (first clause))
	 (extract-predicate (rest clause)))
	((eq (first (first clause))
	     'gen-from-pred)
	 (first (rest (first clause))))
	(t
	 (or (extract-predicate (first clause))
	     (extract-predicate (rest clause)))))
  )

(defun get-forall-precond (inst-precond)
  "Given an instantiated precondition, return a forall clause if it exists."
  (cond ((or (null inst-precond)
	     (atom inst-precond))
	 nil)
	((atom (first inst-precond))
	 (get-forall-precond (rest inst-precond)))
	((eq (first (first inst-precond))
	     'forall)
	 (first inst-precond))
	(t
	 (get-forall-precond (rest inst-precond))))
  )


;;; Checks the binding node (bnode) to see if the new input (attached to signal
;;; data) affects the universally quantified preconditions of the instantiated
;;; operator. This function is called by the spawned monitor.
;;;
(defun check-forall-preconditions (bnode signal-data monitor-name)
  (let* ((inst-preconds (p4::binding-node-instantiated-preconds bnode))
	 (inst-op (p4::binding-node-instantiated-op bnode))
	 (bindings (mapcar #'(lambda (varspec val)
			       (cons (first varspec) val))
			   (second (p4::rule-precond-exp
				    (p4::instantiated-op-op inst-op)))
			   (p4::instantiated-op-values inst-op)))
	 (old-goals (getf (p4::nexus-plist bnode) 'goal-nodes))
	 (resultdetected-new-precondition-p
	  (new-get-forall-goals (if (eq (first inst-preconds) 'forall)
				    inst-preconds
				  (first (rest inst-preconds)))
				nil 
				(p4::instantiated-op-op inst-op) 
				t
				bindings
				0 
				bnode
				inst-op
				monitor-name
				signal-data)))
    (when (and resultdetected-new-precondition-p
	     (getf (p4::nexus-plist bnode) :closed))
	(p4::do-book-keeping-to-reopen-node bnode)
	(if *monitor-trace*
	    (format t
		    "~%Re-opened Binding node~%")))
    (if *monitor-trace*
	(format t
		"~%check-forall-preconditions~%Bnode: ~s~%Signal Data ~s~%"
		bnode
		signal-data))
;    (break)
    (if (in-head-plan-p bnode)
	(p4::set-state-p 
	 (p4::goal-node-goal (give-me-node-of-type 
			      'p4::goal-node 
			      bnode))
	 nil))
;    (let ((done-var (gentemp "DONE-VAR")))
;      (set done-var nil)
;      (eval 
;       `(control-rule ,(gentemp 
;			"CR-ONE-SHOT-JUMP-2-FORALL-STEP-")
;          (if (and (one-shot ,done-var)
;		   (candidate-node ,bnode)))
;	  (then select node ,bnode))))
    ))



;;; Like function old-get-forall-goals of file matcher-interface.lisp, but
;;; having the property of function set-goals-forall of file search.
;;;
;;; Probably should change the name of the function since the return value is
;;; not the preconditions established by the forall clause. Rather, it is t if
;;; new preconditions are detected, nil otherwise.
;;;
;;; Also added arg monitor-name
;;;
(defun new-get-forall-goals (expr disj op parity bindings level bnode inst-op
				  monitor-name signal-data
				  &aux detected-new-precondition-p)
  (do* ((generator
	 (cdr (assoc (second expr) 
		     (getf (p4::rule-plist op)
			   :quantifier-generators))))
	(static-data (if generator (funcall generator nil)))
	(vars (mapcar #'car (second expr)))
	(running-data
	 (p4::first-valid-choice static-data vars bindings (second expr))
	 (p4::next-valid-choice static-data (first running-data)
				(second running-data) 0 vars bindings
				(second expr)))
	(choice (first running-data) (first running-data))
	(result nil))
       ((null choice) (values detected-new-precondition-p result))
       (setf result
	     (append (or (p4::penders-rec (third expr) disj op parity
					 (append
					  (p4::choice-bindings
					   expr (second running-data) choice)
					  bindings)
					 level bnode)
			;; At this point, we have an expression that does not
			;; map to an already pending goal. Create a new
			;; one. [13oct97 cox]
			(or 
			 ;;Guaranteed to be nil
			 (and
			  (setf detected-new-precondition-p t)
			  nil)
			 ;; Print notification of monitor activity.
			 (if *monitor-trace*
			     (format 
			      t 
			      "~%Monitor notices new relvant data for node ~s~%"
			      bnode))
			 ;; Added 30oct97 so UI can activate monitor [cox]
			 (when (ok-stream)
;			       (send-to-tcl 
;				(format nil "Notices ~s" monitor-name))
			       (send-to-tcl
				(format nil "SData ~s {~s}" monitor-name (second signal-data))))
			 (p4::set-goals-inst 
			  (third expr) disj parity inst-op op
			  (append (p4::choice-bindings
				  expr (second running-data)
				  choice)
				 bindings))))
		    result)))
  )


;;;
;;; Function spawn-handler takes a binding node (bnode), a monitor, and the
;;; monitor's name as input, and performs the following side-effects: The
;;; monitor is bound to the function property of the name so that it can be
;;; called, the name is placed on the :monitors property of the bnode, a
;;; message it printed in the Lisp Listener, if the UI is active then the
;;; monitor name is passed to Tcl/Tk, and the monitor is added as a Prodigy
;;; interrupt.
;;;
(defun spawn-handler (bnode
		      monitor
		      monitor-name
		      &optional 
		      literal)
  (setf (symbol-function monitor-name) monitor)
  (setf (getf (p4::binding-node-plist bnode) :monitors)
	(cons monitor-name
	      (getf (p4::binding-node-plist bnode) :monitors)))
  (if *monitor-trace*
      (format t "~%Spawning monitor ~s at node ~s ~a~%" 
	      monitor-name 
	      (p4::binding-node-name bnode)
	      (if literal
		  (format
		   nil
		   "for literal ~s"
		   literal)
		"")))
  ;; Added 30oct97 so UI can display monitor [cox]
  (if (ok-stream)
      (send-to-tcl (format nil "Sentinel ~s" monitor-name)))
  (add-handler
   monitor-name
   :state-change)
  )


;;;
;;; Predicate ok-stream returns t if the UI is running; that is, it returns t
;;; if *tcl-send* is a bound variable pointing to an open stream.
;;;
(defun ok-stream ()
  "Return t if UI running."
  (declare (special *tcl-send*))
  (and (boundp '*tcl-send*)
       (open-stream-p *tcl-send*))
  )


;;; This function is now obsolete. Monitor names saved in closure and passed to
;;; run-time function.
(defun return-sentinel (bnode) 
  (first (getf (p4::binding-node-plist bnode) :monitors))
  )



(defvar *done-already* nil)

;;;
;;; A one-shot predicate that allows the system to generate control rules that
;;; will attempt to fire only once. Afterwards, the control rulle can have not
;;; unintended results. Note that the value of done-already is a name of a
;;; variable that specified the condition.
;;;
;;; Temporarily made this a global one shot so that only one jump will occur
;;; during data collection on Manuela's artificial domain. [5dec97 cox]
;;; 
;;; [20dec cox] Made the function change behavior automatically depending on
;;; whether or not the experiment is being run.
;;;
(defun one-shot (done-already)
  "If not done-already, will return t on the first call."
  (if *run-experiment*
      (setf (symbol-value done-already) ; Added [5dec97 cox]. Remove later.
	    *done-already*)) 
  (when (null (symbol-value done-already))
	(if *run-experiment*
	    (setf *done-already* t)	; Added [5dec97 cox]. Remove later.
	  (set done-already t))		; Commented [5dec97 cox]. Uncomment later.
	t)
  )



(defun open-node-p (node)
  (not (getf (p4::nexus-plist node) :closed))
  )
