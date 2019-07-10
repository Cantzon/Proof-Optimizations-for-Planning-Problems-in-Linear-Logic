
(control-rule depth-first-search
	      (IF (and (candidate-node <x>)
		       (candidate-node <y>)
		       (newer-node <x> <y>)))
	      (THEN prefer node <x> <y>))


