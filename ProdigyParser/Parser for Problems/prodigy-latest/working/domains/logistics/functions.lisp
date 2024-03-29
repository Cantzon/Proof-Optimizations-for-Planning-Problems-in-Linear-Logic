;;; This is mostly a copy of the logistics functions, with some local
;;; modifications. Stuff that is purely for events is in events.lisp
;;; in this directory

(in-package "USER")

(setf *generator-functions*
      '((in-truck-city-p 2)))

(defun diff (x y) (not (eq x y)))
(defun varp (x) (p4::strong-is-var-p x))

;;; returns true if the truck is in the same city as the loc.
(defun in-truck-city-p (truck loc)
  (cond ((varp loc)
	 (if (varp truck)
	     (error "Can't have both truck and location variable in in-truck-city-p"))
	 ;; inefficient, but still a win to generate rather than test.
	 (let* ((city (get-city-of-truck truck))
		(ht  (gethash 'loc-at
			      (p4::problem-space-assertion-hash
			       *current-problem-space*)))
		(lits (get-relevant-lits-in-hash-table city ht 1)))
	   (mapcar #'(lambda (lit) (elt (p4::literal-arguments lit) 0))
		   lits)))
	(t
	 (eq (get-city-of-truck truck)
	     (get-city-of-loc loc)))))


;;; returns the name of the city where the truck is at.
(defun get-city-of-truck (truck)
  (declare (special *current-problem-space*))
  (let ((part-hash (gethash 'part-of
			    (p4::problem-space-assertion-hash
			     *current-problem-space*)))
	(result nil))
    (if part-hash
     ;;; I should really be testing if (hash-table-p ..)
     ;;; but because of the implementation, I know this always hold
     ;;; provided that part-hash is not empty.
	(maphash #'(lambda (key val)
		     (if (and (p4::literal-state-p val)
			      (eq (elt key 0) truck))
			 (setf result val)))
		 part-hash))
    (if result
	(elt (p4::literal-arguments result) 1)
	(error "~% CITY-OF-TRUCK: no entry for part-of ~A in the state."
	       truck))))


;;; get the name of the airport where the plane is.
(defun get-city-of-airplane (airplane)
  (declare (special *current-problem-space*))
  (let ((at-airplane-hash (gethash 'at-airplane
			    (p4::problem-space-assertion-hash
			     *current-problem-space*)))
	(result nil))
    (if at-airplane-hash
	(maphash #'(lambda (key val)
		     (if (and (p4::literal-state-p val)
			      (eq (elt key 0) airplane))
			 (setf result val)))
		 at-airplane-hash))
    (elt (p4::literal-arguments result) 1)))

;;; get the name of the city where loc (airport/post-office) is.
(defun get-city-of-loc (loc)
  (declare (special *current-problem-space*))
  (let ((loc-hash (gethash 'loc-at
			    (p4::problem-space-assertion-hash
			     *current-problem-space*)))
	(result nil))
    (if loc-hash
	(maphash #'(lambda (key val)
		     (if (and (p4::literal-state-p val)
			      (eq (elt key 0) loc))
			 (setf result val)))
		 loc-hash))
    (if result
	(elt (p4::literal-arguments result) 1)
	(error "~% CITY-OF-LOC: no entry for loc-at ~A in the state." loc))))


;;; returns T is obj is in the same city where the loc is.
(defun in-obj-city-p (obj loc)
  (let ((obj-city (get-city-of-obj obj))
	(airport-city (get-city-of-loc loc)))
    (eq airport-city obj-city)))


;;; returns the name of the city where obj is.  Since the object
;;; can be in-truck, in-airplane, or at-obj, I need the "or".
(defun get-city-of-obj (obj)
  (or (at-po-or-airport obj)
      (in-truck obj)
      (in-airplane obj)))

;;; if the obj is at post-office or at an airport, returns the name of
;;; the city where the obj is.
(defun at-po-or-airport (obj)
  (declare (special *current-problem-space*))
  (let* ((at-obj-hash (gethash 'at-obj
			       (p4::problem-space-assertion-hash
				*current-problem-space*)))
	 (result (get-relevant-literal-in-hash-table obj at-obj-hash)))
    (if result
	(get-city-of-loc (elt (p4::literal-arguments result) 1)))))


;;; if the obj is inside-truck, find the truck, and returns the city where
;;; the truck is part-of.
(defun in-truck (obj)
  (declare (special *current-problem-space*))
  (let* ((inside-truck-hash (gethash 'inside-truck
				     (p4::problem-space-assertion-hash
				      *current-problem-space*)))
	 (result (get-relevant-literal-in-hash-table obj inside-truck-hash)))
    (if result
	(get-city-of-truck (elt (p4::literal-arguments result) 1)))))


;;; if the obj is inside-airplane, returns the city where the
;;; airplane is at now.
(defun in-airplane (obj)
  (declare (special *current-problem-space*))
  (let* ((inside-airplane-hash
	  (gethash 'inside-airplane
		   (p4::problem-space-assertion-hash *current-problem-space*)))
	 (result (get-relevant-literal-in-hash-table obj inside-airplane-hash)))
    (get-city-of-airplane (elt (p4::literal-arguments result) 1))))

(defun get-relevant-literal-in-hash-table (obj hash-table)
  (maphash #'(lambda (key val)
	       (if (and (p4::literal-state-p val)
			(eq (elt key 0) obj))
		   (return-from get-relevant-literal-in-hash-table val)))
	   hash-table)
  nil)

;;; Allows the position to vary and more than one hit
(defun get-relevant-lits-in-hash-table (obj hash-table &optional (pos 0))
  (let ((res nil))
    (maphash #'(lambda (key val)
		 (if (and (p4::literal-state-p val)
			  (eq (elt key pos) obj))
		     (push val res)))
	     hash-table)
    res))
