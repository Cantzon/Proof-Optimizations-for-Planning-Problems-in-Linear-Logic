;;; Classical Blocksworld domain
;;; The control rules in this version are by Manuela, 10/94

(create-problem-space 'blocksworld :current t)

(ptype-of OBJECT :top-type)

(OPERATOR PICK-UP
  (params <ob1>)
  (preconds 
   ((<ob1> OBJECT))
   (and (clear <ob1>)
	(on-table <ob1>)
	(arm-empty)))
  (effects 
   () ; no vars need genenerated in effects list
   ((del (on-table <ob1>))
    (del (clear <ob1>))
    (del (arm-empty))
    (add (holding <ob1>)))))

(OPERATOR PUT-DOWN
  (params <ob>)
  (preconds 
   ((<ob> OBJECT))
    (holding <ob>))
  (effects 
   ()
   ((del (holding <ob>))
    (add (clear <ob>))
    (add (arm-empty))
    (add (on-table <ob>)))))


(OPERATOR UNSTACK
  (params <ob> <underob>)
  (preconds
   ((<ob> Object)
    (<underob> Object))
   (and (on <ob> <underob>)
	(clear <ob>)
	(arm-empty)))
  (effects 
   ()
   ((del (on <ob> <underob>))
    (del (clear <ob>))
    (del (arm-empty))
    (add (holding <ob>))
    (add (clear <underob>)))))

(CONTROL-RULE BUILD-TOWER-FROM-BOTTOM
  (if (and (candidate-goal (on <x> <y>))
	   (candidate-goal (on <y> <z>))
	   (~ (above <z> <x>))))
  (then select goal (on <y> <z>)))

(CONTROL-RULE BUILD-TOWER-FROM-BOTTOM-STATE
  (if (and (candidate-goal (on <x> <y>))
	   (other-candidate-goals)
	   (true-in-state (on <y> <z>))))
  (then reject goal (on <x> <y>)))

(CONTROL-RULE ARM-EMPTY-FIRST
  (if (and (candidate-goal (arm-empty))
	   (true-in-state (holding <x>))))
  (then select goal (arm-empty)))

(CONTROL-RULE SELECT-OP-UNSTACK-FOR-HOLDING
  (if (and (current-goal (holding <x>))
	   (true-in-state (on <x> <y>))))
  (then select operator UNSTACK))

(CONTROL-RULE SELECT-BINDINGS-UNSTACK-HOLDING
  (if (and (current-goal (holding <x>))
	   (current-ops (UNSTACK))
	   (true-in-state (on <x> <y>))))
  (then select bindings ((<ob> . <x>) (<underob> . <y>))))

(CONTROL-RULE SELECT-OP-UNSTACK-FOR-CLEAR
  (if (and (current-goal (clear <x>))
	   (true-in-state (on <y> <x>))))
  (then select operator UNSTACK))

(CONTROL-RULE SELECT-BINDINGS-UNSTACK-CLEAR
  (if (and (current-goal (clear <y>))
	   (current-ops (UNSTACK))
	   (true-in-state (on <x> <y>))))
  (then select bindings ((<ob> . <x>) (<underob> . <y>))))

(CONTROL-RULE SELECT-OP-PICKUP-FOR-HOLDING
  (if (and (current-goal (holding <ob>))
	   (true-in-state (on-table <ob>))))
  (then select operator PICK-UP))

(CONTROL-RULE SELECT-OP-PUTDOWN-FOR-CLEAR
  (if (and (current-goal (clear <ob>))
	   (true-in-state (holding <ob>))))
  (then select operator PUT-DOWN))

(CONTROL-RULE SELECT-OP-PUTDOWN-FOR-ARMEMPTY
  (if (and (current-goal (arm-empty))
	   (true-in-state (holding <ob>))))
  (then select operator PUT-DOWN))

(CONTROL-RULE SELECT-BINDINGS-PUTDOWN
  (if (and (current-ops (PUT-DOWN))
	   (true-in-state (holding <x>))))
  (then select bindings ((<OB> . <x>))))

(defun diff (x y)
  (not (eq x y)))

(defun other-candidate-goals ()
  (if (> (length (candidate-goals)) 1) t nil))

;;; assume x and y are bound
(defun above (x y)
  (and (not (eq x y))
       (or (known (list 'on x y))
	   (let ((x-support (known (list 'on x '<z>))))
	     (and x-support
		  (above (cdaar x-support) y))))))

