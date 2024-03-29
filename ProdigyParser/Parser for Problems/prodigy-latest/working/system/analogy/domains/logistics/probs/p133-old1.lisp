;;; This is one of the two "old cases" used in the multiple-case replay
;;; discussion in Veloso (1994), pp. 133-135. See files p133-new.lisp and
;;; p133-old2.lisp.
;;;
(setf (current-problem)
      (create-problem
       (name p133-old1)
       (objects
	(object-is ob3  OBJECT)
	(object-is tr2 TRUCK)
	(object-is p15 AIRPLANE)
	(object-is p4 POST-OFFICE)
	(objects-are a4 a12  AIRPORT)
	(objects-are pittsburgh boston CITY))
       (state
	(and (at-obj ob3 a4)
	     (at-airplane p15 a12)
	     (at-truck tr2 p4)
	     (part-of tr2 pittsburgh)
	     (loc-at p4 pittsburgh)
	     (loc-at a4 pittsburgh)
	     (loc-at a12 boston)
	     (same-city p4 a4)
	     (same-city a4 p4)
	     ))
       (igoal
	(and (inside-airplane ob3 p15)))))
