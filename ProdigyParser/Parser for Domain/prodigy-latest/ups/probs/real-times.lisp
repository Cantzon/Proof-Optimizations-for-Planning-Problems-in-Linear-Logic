(setf (current-problem)
      (create-problem
       (name real-times)
       (objects
	(hub0 hub1 hub2 hub3 hub4 HUB)
	(pac0 pac1 OBJECT))
       (state
	(and (link hub0 hub1 3.3)
	     (link hub1 hub4 4.5)
	     (link hub0 hub2 20.76)
	     (link hub2 hub4 5)
	     (link hub0 hub3 5.7)
	     (link hub3 hub4 15)
	     (effectively-at pac0 hub0 0)
	     (effectively-at pac1 hub0 0)))
       (igoal (and (satisfy-deadline pac0 hub4 10.5)
		   (satisfy-deadline pac1 hub4 40)))))

