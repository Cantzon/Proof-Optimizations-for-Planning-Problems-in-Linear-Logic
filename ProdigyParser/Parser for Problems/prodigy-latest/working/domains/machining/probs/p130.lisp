(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
        (object-is lathe1 LATHE)
	(object-is rough-toolbit1 ROUGH-TOOLBIT)
        (object-is 4-jaw-chuck1 4-JAW-CHUCK)
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)
        (object-is part5 PART))
       (state
	(and
	 (always-true)
	 (material-of part5 ALUMINUM)
	 (size-of part5 LENGTH 5)
	 (size-of part5 WIDTH 3)
	 (size-of part5 HEIGHT 2)))
       (goal
	((<part> PART))
	(size-of <part> DIAMETER 1.9))))