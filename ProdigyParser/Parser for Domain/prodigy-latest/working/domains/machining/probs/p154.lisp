(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
        (object-is grinder1 GRINDER)
	(object-is grinding-wheel1 GRINDING-WHEEL)
	(object-is grinding-wheel2 GRINDING-WHEEL)
	(object-is grinding-wheel3 GRINDING-WHEEL)
	(object-is grinding-wheel4 GRINDING-WHEEL)
        (object-is magnetic-chuck1 MAGNETIC-CHUCK)
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)
	(object-is part5 PART))
       (state
	(and
	 (always-true)       
	 (hardness-of-wheel grinding-wheel1 HARD)
	 (grit-of-wheel grinding-wheel1 COARSE-GRIT)
	 (hardness-of-wheel grinding-wheel2 SOFT)
	 (grit-of-wheel grinding-wheel2 COARSE-GRIT)
	 (hardness-of-wheel grinding-wheel3 HARD)
	 (grit-of-wheel grinding-wheel3 FINE-GRIT)
	 (hardness-of-wheel grinding-wheel4 SOFT)
	 (grit-of-wheel grinding-wheel4 FINE-GRIT)
	 (material-of part5 ALUMINUM)
	 (size-of part5 LENGTH 5)
	 (size-of part5 WIDTH 3)
	 (size-of part5 HEIGHT 3)))
       (goal
	((<part> PART))
	(surface-finish-side <part> SIDE5 FINISH-GRIND))))