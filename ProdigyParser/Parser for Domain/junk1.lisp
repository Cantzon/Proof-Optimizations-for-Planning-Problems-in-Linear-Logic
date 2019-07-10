;;; C2 Tasks Taxonomy

(create-problem-space 'c2-tasks :current t)


(OPERATOR PICKUP
  (params <ob1>)
  (preconds 
   ()
   (and (clear <ob1>)
	(ontable <ob1>)
	(armempty)))
  (effects 
   () ; no vars need genenerated in effects list
   ((del (ontable <ob1>))
    (del (clear <ob1>))
    (del (armempty))
    (add (holding <ob1>)))))
