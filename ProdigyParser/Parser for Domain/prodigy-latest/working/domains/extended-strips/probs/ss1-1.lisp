(setf (current-problem)
      (create-problem
       (name SS1-1)
       (objects
	(a b BOX)
	(dr12 DOOR)
	(key12 KEY)
	(rm1 rm2 ROOM))
       (state
	(and (arm-empty)
	     (dr-to-rm dr12 rm2)
	     (dr-to-rm dr12 rm1)
	     (connects dr12 rm2 rm1)
	     (connects dr12 rm1 rm2)
	     (dr-closed dr12)
	     (locked dr12)
	     (carriable A)
	     (inroom B rm2)
	     (inroom A rm1)
	     (inroom key12 rm2)
	     (inroom robot rm2)
	     (carriable key12)
	     (is-key dr12 key12)))
       (goal (unlocked dr12))))
