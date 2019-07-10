
(setf *limit* 20)
(setf (current-problem)
      (create-problem
       (name large-7)
       (objects
        (ball1 ball2 BALL))
       (goal
        (and
         (at ball1 9 18)
       ))
       (state
        (and
         (at-robot 7 2)
         (at ball1 3 8)
         (at ball2 11 17)
         (blocked 13 10)
         (blocked 12 15)
         (blocked 18 0)
         (blocked 0 9)
         (blocked 5 5)
         (blocked 10 8)
         (blocked 0 15)
         (blocked 18 11)
         (blocked 4 4)
         (blocked 1 2)
         (blocked 17 11)
         (blocked 5 1)
         (blocked 14 10)
         (blocked 16 1)
         (blocked 2 12)
         (blocked 0 10)
         (blocked 8 18)
         (blocked 0 16)
         (blocked 4 18)
         (blocked 17 17)
         (blocked 8 4)
         (blocked 4 9)
         (blocked 11 15)
         (blocked 2 15)
         (blocked 18 5)
         (blocked 12 6)
         (blocked 14 12)
         (blocked 3 12)
         (blocked 1 19)
         (blocked 4 12)
         (blocked 12 14)
         (blocked 7 17)
         (blocked 18 2)
         (blocked 8 15)
         (blocked 3 18)
         (blocked 13 3)
         (blocked 2 10)
         (blocked 14 17)
         (blocked 7 3)
         (blocked 1 8)
         (blocked 14 2)
         (blocked 17 6)
         (blocked 14 6)
         (blocked 6 6)
         (blocked 7 10)
         (blocked 15 4)
         (blocked 0 17)
         (blocked 10 9)
         (blocked 1 12)
         (blocked 18 19)
         (blocked 4 1)
         (blocked 3 14)
         (blocked 6 0)
         (blocked 2 4)
         (blocked 16 15)
         (blocked 2 6)
         (blocked 19 15)
         (blocked 14 16)
         (blocked 17 4)
         (blocked 15 10)
         (blocked 0 13)
         (blocked 3 7)
         (blocked 5 9)
         (blocked 10 15)
         (blocked 16 6)
         (blocked 17 19)
         (blocked 6 17)
         (blocked 3 15)
         (blocked 16 0)
         (blocked 8 12)
         (blocked 8 10)
         (blocked 2 13)
         (blocked 9 12)
         (blocked 3 4)
         (blocked 13 5)
         (blocked 19 8)
         (blocked 13 6)
         (blocked 8 1)
         (blocked 16 9)
         (blocked 6 19)
         (blocked 18 6)
         (blocked 1 11)
         (blocked 7 5)
         (blocked 3 9)
         (blocked 6 2)
         (blocked 2 19)
         (blocked 8 3)
         (blocked 7 6)
         (blocked 5 18)
         (blocked 17 1)
         (blocked 10 16)
         (blocked 15 17)
         (blocked 16 16)
         (blocked 17 2)
         (blocked 0 7)
         (blocked 11 0)
         (blocked 8 0)
         (blocked 2 0)
         (blocked 14 13)
         (blocked 6 11)
       ))
))