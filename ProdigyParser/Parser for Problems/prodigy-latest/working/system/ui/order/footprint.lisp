;;; Jim: had to copy it here to change the load lines, which would
;;; not work except on Alicia's machine. No code has changed.

; make a list of all the applied op nodes in the solution path
(defun extract-applied-op-nodes (solution-path)
  (let ((app-op-nodes nil ))
    (dolist (node solution-path)
            (case (type-of node)
                  (p4::applied-op-node (push node app-op-nodes))))
    app-op-nodes
  ))

; make list of instantiated effects for an applied-node-op-application
(defun get-instantiated-effects-applied (applied)
  (let* ( (inst-op (p4::op-application-instantiated-op applied))
          (op (p4::instantiated-op-op inst-op))
          (vars (p4::rule-vars op))
          (values (p4::instantiated-op-values inst-op))
          (precond-bindings (p4::precond-bindings vars values)))
    (p4::compute-effects op precond-bindings applied)))

(defun footprint (solution-path)
  (let ((app-op-nodes (extract-applied-op-nodes solution-path))
        (goals        (cdr (p4::problem-goal (current-problem))))
        (last-node    (car (last solution-path))))
    (if (eq (caar goals) 'and)
        (setf goals (cdr (car goals))))

    (dolist (app-op-node app-op-nodes)
      (set-valid-preconds last-node app-op-node)
      
      ; must look at all applied operators in order to cover inference rules
      (dolist (applied (p4::applied-op-node-applied app-op-node))
        (let* ((effects  (get-instantiated-effects-applied applied))
               (del-list  (add-neg-signs (mapcar #'format-literals-to-list
                                                 (car effects))))
               (add-list (mapcar #'format-literals-to-list (second effects)))
               (newgoals     nil)
               (search-list nil)
               (instop (p4::op-application-instantiated-op applied))
               (preconds-list   (format-literals-to-list
                                 (getf (p4::instantiated-op-plist instop)
                                       :satisfying-preconds)))
               (conditional-preconds (getf (p4::instantiated-op-plist instop)
                                           :conditional-preconditions))
               (relevant-cond-pre nil))
          (dolist (goal goals)
            (if (eq '~ (car goal))
                (progn
                  (setf search-list del-list)
                  (setf relevant-cond-pre (car conditional-preconds)))
                (progn
                  (setf search-list add-list)
                  (setf relevant-cond-pre (second conditional-preconds))))

            (if (find goal search-list :test #'equalp)
                ; if goal is found, add preconditions to new goallist
                ;   must also add conditional preconditions if necessary
                ; else put this goal back into the new goallist
                (setf newgoals (n-union newgoals
                                      (n-union preconds-list
                                              (add-conditional-preconds
                                                    relevant-cond-pre
                                                    goal))))
                ;else
                (setf newgoals (n-union (list goal) newgoals)))
          )
          (setf goals newgoals)
        )))
    goals))

(defun add-conditional-preconds (conditional-preconds goal)
  (let ((newgoals nil))
    (if (and (boundp 'user::*short-circuit-preconditions*)
             (eq user::*short-circuit-preconditions* t))
        (do* ((pair       (car conditional-preconds)
                          (car (setf conditional-preconds
                                     (cdr conditional-preconds))))
              (test-match (equalp (format-literals-to-list (cdr pair)) goal)
                          (equalp (format-literals-to-list (cdr pair)) goal))
              (exit-loop  nil))

           (exit-loop ; exit condition
            nil)  ; return value
          (if test-match
              (progn
                (setf exit-loop t)
                (setf newgoals
                      (n-union (format-literals-to-list (car pair)) newgoals))))
        )
        (dolist (pair conditional-preconds)
          (if (equalp (format-literals-to-list (cdr pair)) goal)
              (setf newgoals (n-union (format-literals-to-list (car pair)) newgoals)))))
    newgoals))

(defun add-neg-signs (l)
   (mapcar #'(lambda (x) (list '~ x)) l))

(defun listify (preconds)
; change format of preconditions from #<> to lists
; only works in simplest of conjuctions.
  (let ((preconds-list nil))
    (dolist (pre (case (type-of preconds)
                          (cons (cdr preconds))
                          (t (list preconds)))   )
         (case (type-of pre)
                  (p4::literal (push (format-literals-to-list pre) preconds-list))
                  (cons (push (list '~ (format-literals-to-list (car (cdr pre))))
                                   preconds-list))))
    preconds-list))

;;this was called nunion but that is a common Lisp function
;;(destructive union) and caused me problems

(defun n-union (l1 l2)
  ; union of nested things
  (union l1 l2 :test #'equalp))


(load (concatenate 'string *prod-ui-home* "/order/preconds.lisp"))
(load (concatenate 'string *prod-ui-home* "/order/print-rules.lisp"))

