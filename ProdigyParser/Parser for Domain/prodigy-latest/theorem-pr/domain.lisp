;;; Turn off package-definition-lock error produced by defstruct in file 
;;; functions.lisp. Allegro version newer than when domain originally written.
;;; This should eventually be fixed correctly. [cox 10sep97]

(setf excl:*enable-package-locked-errors* nil)

;;May 1994
;;convention for input of terms
;;each term is input in brackets, e.g. (f (a)); (f(a b ));
;;(f ( (f(a b)) c)) (a) (x) a x
;;Convention of input of formulas:
;;(= (t1 t2)); (R(a b)); (R(a)); (R ((f(a b)) x)); (andf (R(a)) (F2));
;;((forallf x) ((forallf z) (implf (R(x)) (Q(z)))))



(create-problem-space 'theorem-pr :current t)
(infinite-type TERM #'term-symbol-p)
(infinite-type FORMULA #'formula-symbol-p)
(infinite-type SUBSTITUTION #'subst-symbol-p)
(infinite-type ASS-SET #'ass-set-symbol-p)


;;;************************************
;;;
;;;   OPERATORS
;;;
;;;;*************************************


(OPERATOR DED
  (params <F>)
  (preconds
   ((<Ass> ASS-SET)
    (<F> (and FORMULA (implication-p <F>)))
    (<F1> (and FORMULA (left-of-impl <F>)))
    (<F2> (and FORMULA (right-of-impl <F>))) 
    (<setF1> (and ASS-SET (create-set <F1>))) 
    (<Ass1> (and ASS-SET (build-union <Ass> <setF1>))))
   (and (follows <Ass1> <F2>)
	(hypothesized-formula <F1>)))
  (effects
   ()
   ((add (follows <Ass> <F>)))))

;;;;;;;;;;;;;
;;;HYP-Introduction is called when another operator yields
;;;the subgoal (processed-formula...). This should be the case for all
;;;operators which introduce new assumptions such as DED
;; ****control-rule required: Chose it ONLY when called by another
;; operator that introduces processed-formula****

(OPERATOR HYP-INTRO
  (params <Ass> <F>)
  (preconds
   ((<F> FORMULA)
    (<Ass> (and ASS-SET (create-set <F>))))
   (nothing))
  (effects
   ()
   ((add (follows <Ass> <F>))
    (add (hypothesized-formula <F>)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
;;The next operator splits a conjunction in the assumption set to elements
;;of a new assumption set
(operator SPLIT-CONJ-ASSUMPTION
 (params <Ass2>)
 (preconds
  ((<Ass2> ASS-SET)
   (<F> FORMULA)
   (<FA> (and FORMULA (conj-in-set <Ass2>)))
   (<A> (and ASS-SET (create-set <FA>)))
   (<FA1> (and FORMULA (left-of-conj <FA>)))
   (<A1> (and ASS-SET (create-set <FA1>)))
   (<FA2> (and FORMULA (right-of-conj <FA>)))
   (<A2> (and ASS-SET  (create-set <FA2>)))
   (<Ass3> (and ASS-SET (build-set-diff <Ass2> <A>)))
   (<Ass4> (and ASS-SET (build-union <Ass3> <A1>)))
   (<Ass1> (and ASS-SET (build-union <Ass4> <A2>))))
  (follows <Ass1> <F>))
 (effects
  ()
  ((add (follows <Ass2> <F>)))))
|#
#|
;;;;;;;;;;;;;;
;;This operator, to start with, is less complicated than
;;apply-definition-left and applicable for not quantified equivalences.
;;note the RESTRICTION to EMPTY assumptions of the equivalence
;;To prefer when (emptyset <D>) is in the state already,i.e. no
;;subgoaling on it.

(OPERATOR APPLY-EQUIVALENCE-LEFT
 (params <F1>)
 (preconds
  ((<D> (and FORMULA (equivalence-in-state-p <D>)))
   (<Ass> ASS-SET)
   (<F2> (and FORMULA (left-of-equiv <D> <F2>))) 
   (<F1> (and FORMULA (right-of-equiv <D> <F1>))))
   (and (follows <Ass> <D>)
        (follows <Ass> <F1>)))
 (effects
  ()
  ((add (follows <Ass> <F2>)))))


(OPERATOR APPLY-EQUIVALENCE-RIGHT
 (params <F1>)
 (preconds
  ((<D> (and FORMULA (equivalence-in-state-p <D>)))
   (<Ass> ASS-SET)
   (<F1> (and FORMULA (right-of-equiv <D> <F1>)))
   (<F2> (and FORMULA (left-of-equiv <D> <F2>))))
   (and (follows <Ass> <D>)
        (follows <Ass> <F2>)))
 (effects
  ()
  ((add (follows <Ass> <F1>)))))
|#

;;;;;;;;;;;


;The next is an operator for the application of definitions which are
;forall-quantified equivalences. We need an eager inference rule
;for the same step.

(OPERATOR APPLY-DEFINITION-LEFT
 (params <SF2>)
 (preconds
  ((<D> (and FORMULA (Aquantified-p <D>)))
   (<SF2> FORMULA)
   (<Ass> ASS-SET)
   (<F> (and FORMULA (corpus-sym <D>)));also poss. create-formula-inst-sym
   (<F2> (and FORMULA (left-of-equiv <F>))) 
   (<F1> (and FORMULA (right-of-equiv <F>)))
   (<S> (and SUBSTITUTION
	     (get-substitution-symbol <F2> <SF2>))) 
   (<SF1> (and FORMULA
	       (get-substitute-symbol <S> <F1>)))) 
 (and (is-definition <D>)
   (follows <Ass> <SF1>)))
 (effects
  ()
  ((add (follows <Ass> <SF2>)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;The next is an operator for the introduction of conjunctions. You
;need for the same purpose an inference rule. note that the operator
;can handle only two problems with the same assumption-set. So it is 
;less exact.
(OPERATOR AND-INTRO-OP
  (params <CF>)
  (preconds
   ((<Ass> Ass-SET)
    (<CF> (and FORMULA (conjunction-p <CF>)));changed from is-conj-p
    (<F1> (and FORMULA (left-of-conj <CF>)))
    (<F2> (and FORMULA (right-of-conj <CF>))))
   (and (follows <Ass> <F1>)
	(follows <Ass> <F2>)))
  (effects
   ()
   ((add (follows <Ass> <CF>)))))

;;;;;;;;;;;;;;;;
;;;operator FORALL-INTRO 

(OPERATOR FORALL-INTRO-OP
  (params <F1>)
  (preconds
   ((<Ass> Ass-SET)
    (<AF> (and FORMULA (Aquantified-p <AF>)))
    (<F1> (and FORMULA (corpus-sym <AF>))))
   (follows <Ass> <F1>))
  (effects
   ()
   ((add (follows <Ass> <AF>)))))

;;;;;;;;;
;;the operator REDUCED-ASSUMPTION removes a follow-literal as a subgoal
;;if a follow-literal just with extended assumptions is in the state
(OPERATOR REDUCED-ASSUMPTION
  (params <Ass2> <F>)
  (preconds
   ((<F> FORMULA)
    (<Ass1> ASS-SET)
    (<Ass2> (and ASS-SET (gen-from-pred (follows <Ass2> <F>))
		 (build-subset-sym <Ass2> <Ass1>))))
   (nothing))
  (effects
   ()
   ((add (follows <Ass1> <F>)))))
;;;;;;

;;modus-ponens-op-left is applied when the implication (with a smaller
;;ass-set) is in the state
;;
(operator MODUS-PONENS-OP-left
  (params <F1>)
  (preconds
   ((<F2> FORMULA)
    (<Ass> ASS-SET)
    (<Ass1> (and ASS-SET (build-subset-sym <Ass1> <Ass>)))
    (<F3> (and FORMULA (gen-from-pred (follows <Ass1> <F3>)) (right-of-impl <F3> <F2>)))
    (<F1> (and FORMULA (left-of-impl <F3>))))
   (follows <Ass> <F1>))
  (effects
   ()
   ((add (follows <Ass> <F2>)))))
;;;;;;;;;;;;;;;;;;;;;;

;;;changed in order to have more flexibility
(operator GENERALIZED-MODUS-PONENS-OP-left
  (params <F1>)
  (preconds
   ((<F2> FORMULA)
    (<Ass> ASS-SET)
    (<Ass1> (and ASS-SET (build-subset-sym <Ass1> <Ass>)))
    (<F3> (and FORMULA (gen-from-pred (follows <Ass1> <F3>))
	       (Aquantified-p <F3>)))
    (<F4> (and FORMULA (corpus-sym <F3>)))
    (<F5> (and FORMULA (right-of-impl <F4>)))
    (<F6> (and FORMULA (corpus-sym <F5>)))
    (<S> (and SUBSTITUTION (get-substitution-symbol <F6> <F2>)))
    (<F7> (and FORMULA (left-of-impl <F4>)))
    (<F1> (and FORMULA (get-substitute-symbol <S> <F7>))))
   (follows <Ass> <F1>))
  (effects
   ()
   ((add (follows <Ass> <F2>)))))
;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;
;;If the operator EXISTS-INTRO is in the domain, then we have a
;;stronger get-substitution, such that marked constants emerging from
;;exists-intro can be matched to some constant in the state
;;formulas. This is also taken care of in this MATCH-OP.
(OPERATOR MATCH-OP
  (params <F1> <F2>)
  (preconds
   ((<Ass1> Ass-SET)
    (<F1> FORMULA)
    (<F2> (and FORMULA (get-generaliz-symbol <F1>)))
    (<F3> (and FORMULA (corpus-sym <F2>)))
    (<S> (and SUBSTITUTION (get-substitution-symbol <F3> <F1>)))
    (<Ass2> (and ASS-SET (gen-from-pred (follows <Ass2> <F2>))
                  (general-subset-sym <Ass2> <Ass1> <S>))))
     (nothing))
  (effects
   ()
   ((add (follows <Ass1> <F1>)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
;;
(operator EXISTS-INTRO
  (params <F>)
  (preconds
   ((<EF> (and FORMULA (existential-p <EF>)))
    (<Ass> ASS-SET)
    (<F> (and FORMULA (get-e-instant-sym <EF>))))
   (follows <Ass> <F>))
  (effects
   ()
   ((add (follows <Ass> <EF>)))))
;;;;;;;;;;;;;;;;;
#|
;;modus-ponens-op-left is applied when the implication (with a smaller
;;ass-set) is in the state  TESTEN*****is nonsense if it causes DED-op
;;MAKE CONTROL RULE THAT SAFES THE RESULT of (generalized)MODUS-PONENS-OP-RIGHT FROM DED-op
;;THIS IS A DANGEROUS OPERATOR, THEREFORE AT THE END 
(operator MODUS-PONENS-OP-RIGHT
  (params <F2>)
  (preconds
   ((<F2> FORMULA)
    (<Ass> ASS-SET)
    (<Ass1> (and ASS-SET (build-subset-sym <Ass1> <Ass>)))
    (<F1> (and FORMULA (gen-from-pred (follows <Ass1> <F1>))))
    (<F3> (and FORMULA (get-impl-symbol <F1> <F2>))))
   (follows <Ass> <F3>))
  (effects
   ()
   ((add (follows <Ass> <F2>)))))
|#
;;**************************
;;     RULES
;;
;;*************************

(inference-rule RULE-FORALL-DELETION
  (mode eager)
  (params <F>)
  (preconds
   ((<AF> (and FORMULA (Aquantified-p <AF>)))
    (<Ass> (and ASS-SET (gen-from-pred (follows <Ass> <AF>))))
    (<F> (and FORMULA (corpus-sym <AF>))))
   (follows <Ass> <AF>))
;   (and (follows <Ass> <AF>)
;   (~(follows <Ass> <F>))))
  (effects
   ()
   ((add (follows <Ass> <F>)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;now with a generator for Ass1, such that bindings can be produced.
(inference-rule RULE-AND-DELETION
  (mode eager)
  (params <F2> <F1>)
  (preconds
   ((<F3> (and FORMULA (conjunction-p <F3>)))
    (<F1> (and FORMULA (left-of-conj <F3>)))
    (<F2> (and FORMULA (right-of-conj <F3>)))
    (<Ass1> (and ASS-SET (gen-from-pred (follows <Ass1> <F3>)))))
   (follows <Ass1> <F3>))
;   (and (follows <Ass1> <F3>)
;   (~(follows <Ass1> <F2>))))
  (effects
   ()
   ((add (follows <Ass1> <F2>))
    (add (follows <Ass1> <F1>)))))

;;;;;;;;;;;;;;;

;;;;;;;;new such that it shoould fire not only at the beginning
(inference-rule RULE-MODUS-PONENS
  (mode eager)
  (params <F2>)
  (preconds
   ((<F3> (and FORMULA (implication-p <F3>)))
    (<F1> (and FORMULA (left-of-impl <F3>)))
    (<F2> (and FORMULA (right-of-impl <F3>)))
    (<Ass1> (and ASS-SET (gen-from-pred (follows <Ass1> <F3>))))
    (<Ass2> (and ASS-SET (gen-from-pred (follows <Ass2> <F1>))))
    (<Ass3> (and ASS-SET (build-union <Ass1> <Ass2>))))
   (and (follows <Ass1> <F3>)
   (~(follows <Ass3> <F2>))))
  (effects
   ()
   ((add (follows <Ass3> <F2>)))))

;;This is a combination of forall-Del and modus-ponens which
;;includes simple modus-ponens. change it such that the rule is allpied
;;not only at the beginning
(inference-rule RULE-GENERALIZED-MODUS-PONENS
  (mode eager)
  (params <F2c>)
  (preconds
   ((<F4> (and FORMULA (Aquantified-p <F4>)))
    (<F3> (and FORMULA (corpus-sym <F4>) (implication-p <F3>)))
    (<F1> (and FORMULA (left-of-impl <F3>)))
    (<F2> (and FORMULA (right-of-impl <F3>)))
    (<F1c> (and FORMULA (get-instance-symbol <F1>)))
    (<S> (and SUBSTITUTION (get-substitution-symbol <F1> <F1c>)))
    (<F2c> (and FORMULA (get-substitute-symbol <S> <F2>)))
    (<Ass1> (and ASS-SET (gen-from-pred (follows <Ass1> <F4>))))
    (<Ass2> (and ASS-SET (gen-from-pred (follows <Ass2> <F1c>))))
    (<Ass3> (and ASS-SET (build-union <Ass1> <Ass2>))))
   (and (follows <Ass1> <F4>)
   (~(follows <Ass3> <F2c>))))
  (effects
   ()
   ((add (follows <Ass3> <F2c>)))))

;;;;;;;;;;;;;;;
;;
(inference-rule RULE-APPL-DEF-LEFT
  (mode eager)
  (params <F2c>)
  (preconds
   ((<D> (and FORMULA (Aquantified-p <D>)))
    (<F3> (and FORMULA (corpus-sym <D>)))
    (<F1> (and FORMULA (left-of-equiv <F3>)))
    (<F2> (and FORMULA (right-of-equiv <F3>)))    
    (<F1c> (and FORMULA (get-instance-symbol <F1>)))
    (<Ass> (and ASS-SET (gen-from-pred (follows <Ass> <F1c>))))
    (<S> (and SUBSTITUTION (get-substitution-symbol <F1> <F1c>)))
    (<F2c> (and FORMULA (get-substitute-symbol <S> <F2>))))
    (and (is-definition <D>)
	 (follows <Ass> <F1c>)
	 (~(follows <Ass> <F2c>))))
  (effects
   ()
   ((add (follows <Ass> <F2c>)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
;;TESTEN ******
(inference-rule RULE-APPL-DEF-RIGHT
  (mode eager)
  (params <F1c>)
  (preconds
   ((<D> (and FORMULA (Aquantified-p <D>)))
    (<F3> (and FORMULA (corpus-sym <D>)))
    (<F1> (and FORMULA (left-of-equiv <F3>)))
    (<F2> (and FORMULA (right-of-equiv <F3>)))    
    (<F2c> (and FORMULA (get-instance-symbol <F2>)))
    (<Ass> (and ASS-SET (gen-from-pred (follows <Ass> <F2c>))))
    (<S> (and SUBSTITUTION (get-substitution-symbol <F2> <F2c>)))
    (<F1c> (and FORMULA (get-substitute-symbol <S> <F1>))))
    (and (is-definition <D>)
	 (follows <Ass> <F2c>)
	 (~(follows <Ass> <F1c>))))
  (effects
   ()
   ((add (follows <Ass> <F1c>)))))
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(inference-rule RULE-INTRODUCE-DEFINITION
  (mode eager)
  (params <D>)
  (preconds
   ((<D> (and FORMULA (gen-from-pred (is-definition <D>)))))
   (is-definition <D>))
  (effects
   ()
   ((add (follows emptyset <D>)))))

;;****************
;;
;;  CONTROL-RULES
;;
;;******************
;;HYP-INTRO should only fire when the goal is (hypothesized bla)
(control-rule reject-hyp-intro
  (if (current-goal (follows <Ass> <y>)))
  (then reject operator HYP-INTRO))

;;control-rule that rejects to apply DED-op to results of
;;(generalized)MODUS-PONENS-OP-RIGHT 
(control-rule reject-ded
  (if (and (current-goal (follows <Ass> <F3>))
	   (goal-introduced-only-by-op
	    (follows <Ass> <F3>)
	    (MODUS-PONENS-OP-RIGHT; (follows <Ass>
	     <F2> <Ass> <Ass1> <F1> <F3>))))
  (then reject operator DED))

;(control-rule ASK-FOR-OPERATOR
;  (if (and (candidate-operator <op>)
;           (get-guidance-operator <op> <operator>)))
;  (then select operator <operator>))

