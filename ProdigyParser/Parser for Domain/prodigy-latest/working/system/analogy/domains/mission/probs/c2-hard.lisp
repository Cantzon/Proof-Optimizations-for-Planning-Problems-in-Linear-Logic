;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Problem File: Mission Impossible: Simple Mission 1		;;
;; Author:	 Anthony G. Francis, Jr.			;;
;; Assignment:	 Visiting Research Work.			;;
;; Due:		 Not Specified					;;
;;--------------------------------------------------------------;;
;; Module:	 Mission Impossible Domain version 1		;;
;; File:	 "probs/compete-original.lisp"			;;
;;--------------------------------------------------------------;;
;; Notes: 							;;
;;--------------------------------------------------------------;;
;;**************************************************************;;

;;**************************************************************;;
;; PROBLEM DEFINITION						;;
;;**************************************************************;;
(setf (current-problem)
      (create-problem
       ;;-------------------------------------------------------
       ;; PROBLEM NAME
       ;;-------------------------------------------------------
       (name c2-hard)

       ;;-------------------------------------------------------
       ;; OBJECT DECLARATIONS
       ;;-------------------------------------------------------
       (objects

	;;=====================================================
	;; Largely Fixed Domain Objects
	;;=====================================================
	;;--- UNITED STATES ------
	(Roswell  Place)
	(Area51   Place)
	(Langley  Place)

	;;--- UNITED KINGDOM -----
	(London   Place)

	;;=====================================================
	;; Changeable Problem Objects
	;;=====================================================
	;;--- MOBILE OBJECTS------
	(Noc-List Secret)
	)

       ;;-------------------------------------------------------
       ;; INITIAL STATE
       ;;-------------------------------------------------------
       (state 
	(and 
	 ;;=====================================================
	 ;; Largely Fixed Domain Knowledge
	 ;;=====================================================

	 ;;=====================================================
	 ;; Changeable Problem Knowledge
	 ;;=====================================================
	 ;;--- PLACES -------------
	 (insecure Area51)

	 ;;--- SECRETS ------------
	 (stored      Noc-List     Langley)
	 (stored      Noc-List     Area51)

	 ;;--- PEOPLE -------------
	 (at          Langley)

	 ;;--- PASSPORTS ----------
	 (pass        Roswell      Langley)
	 (pass        Area51       London)
	 (pass        Langley      London)
	 (pass        Langley      Area51)
	 )
	)

       ;;-------------------------------------------------------
       ;; GOAL STATE
       ;;-------------------------------------------------------
       (goal (and
	      (holding Noc-List)
	      (at London)
	      )
	     )
       )
      )
