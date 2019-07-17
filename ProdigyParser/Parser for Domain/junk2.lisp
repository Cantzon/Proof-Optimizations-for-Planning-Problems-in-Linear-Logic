
(control-rule depth-first-search
	      (IF (and (candidate-node <x>)
		       (candidate-node <y>)
		       (newer-node <x> <y>)))
	      (THEN prefer node <x> <y>))


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

