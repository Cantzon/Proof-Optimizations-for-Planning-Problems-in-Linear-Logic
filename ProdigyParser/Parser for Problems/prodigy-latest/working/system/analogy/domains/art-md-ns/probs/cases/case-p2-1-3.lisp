 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g1))
              (p4::instantiate-consed-literal '(g3)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g1))
              (p4::instantiate-consed-literal '(g3)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 2013 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g3)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2013))
  (list
    (p4::make-operator-node 
        :name 2014 
        :parent (find-node 2013) 
        :operator (p4::get-operator a2-3))))
 
(setf (p4::nexus-children (find-node 2014))
  (list
    (p4::make-binding-node 
        :name 2015 
        :parent (find-node 2014)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2015))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 2015)
          :precond 
            (p4::instantiate-consed-literal '(p3))))
 
(setf (p4::nexus-children (find-node 2015))
  (list
    (p4::make-goal-node 
        :name 2176 
        :parent (find-node 2015) 
        :goal 
            (p4::instantiate-consed-literal '(g2)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2176))
  (list
    (p4::make-operator-node 
        :name 2177 
        :parent (find-node 2176) 
        :operator (p4::get-operator a2-2))))
 
(setf (p4::nexus-children (find-node 2177))
  (list
    (p4::make-binding-node 
        :name 2178 
        :parent (find-node 2177)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2178))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 2178)
          :precond 
            (p4::instantiate-consed-literal '(p2))))
 
(setf (p4::nexus-children (find-node 2178))
  (list
    (p4::make-goal-node 
        :name 2352 
        :parent (find-node 2178) 
        :goal 
            (p4::instantiate-consed-literal '(g1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2352))
  (list
    (p4::make-operator-node 
        :name 2353 
        :parent (find-node 2352) 
        :operator (p4::get-operator a2-1))))
 
(setf (p4::nexus-children (find-node 2353))
  (list
    (p4::make-binding-node 
        :name 2354 
        :parent (find-node 2353)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2354))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 2354)
          :precond 
            (p4::instantiate-consed-literal '(p1))))
 
(setf (p4::nexus-children (find-node 2354))
  (list
    (p4::make-goal-node 
        :name 2355 
        :parent (find-node 2354) 
        :goal 
            (p4::instantiate-consed-literal '(p1)) 
        :introducing-operators (list (find-node 2354) )))) 
 
(setf (p4::nexus-children (find-node 2355))
  (list
    (p4::make-operator-node 
        :name 2356 
        :parent (find-node 2355) 
        :operator (p4::get-operator a1-1))))
 
(setf (p4::nexus-children (find-node 2356))
  (list
    (p4::make-binding-node 
        :name 2357 
        :parent (find-node 2356)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2357))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 2357)
          :precond 
            (p4::instantiate-consed-literal '(i1))))
 
(setf (p4::nexus-children (find-node 2357))
  (list
    (p4::make-applied-op-node 
        :name 2358 
        :parent (find-node 2357)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2358))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 2357)
          :precond 
            (p4::instantiate-consed-literal '(i1))))

(setf (p4::a-or-b-node-applied (find-node 2358))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 2358))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 2358))
  (list
    (p4::make-goal-node 
        :name 2363 
        :parent (find-node 2358) 
        :goal 
            (p4::instantiate-consed-literal '(p2)) 
        :introducing-operators (list (find-node 2178) )))) 
 
(setf (p4::nexus-children (find-node 2363))
  (list
    (p4::make-operator-node 
        :name 2364 
        :parent (find-node 2363) 
        :operator (p4::get-operator a1-2))))
 
(setf (p4::nexus-children (find-node 2364))
  (list
    (p4::make-binding-node 
        :name 2365 
        :parent (find-node 2364)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2365))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 2365)
          :precond 
            (p4::instantiate-consed-literal '(i2))))
 
(setf (p4::nexus-children (find-node 2365))
  (list
    (p4::make-applied-op-node 
        :name 2366 
        :parent (find-node 2365)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2366))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 2365)
          :precond 
            (p4::instantiate-consed-literal '(i2))))

(setf (p4::a-or-b-node-applied (find-node 2366))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 2366))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))))))
 
(setf (p4::nexus-children (find-node 2366))
  (list
    (p4::make-goal-node 
        :name 2375 
        :parent (find-node 2366) 
        :goal 
            (p4::instantiate-consed-literal '(p3)) 
        :introducing-operators (list (find-node 2015) )))) 
 
(setf (p4::nexus-children (find-node 2375))
  (list
    (p4::make-operator-node 
        :name 2376 
        :parent (find-node 2375) 
        :operator (p4::get-operator a1-3))))
 
(setf (p4::nexus-children (find-node 2376))
  (list
    (p4::make-binding-node 
        :name 2377 
        :parent (find-node 2376)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2377))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 2377)
          :precond 
            (p4::instantiate-consed-literal '(i3))))
 
(setf (p4::nexus-children (find-node 2377))
  (list
    (p4::make-applied-op-node 
        :name 2378 
        :parent (find-node 2377)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2378))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 2377)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 2378))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 2378))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 2378))
  (list
    (p4::make-applied-op-node 
        :name 2379 
        :parent (find-node 2378)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2379))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 2354)
          :precond 
            (p4::instantiate-consed-literal '(p1))))

(setf (p4::a-or-b-node-applied (find-node 2379))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 2379))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 2379))
  (list
    (p4::make-applied-op-node 
        :name 2380 
        :parent (find-node 2379)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2380))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 2178)
          :precond 
            (p4::instantiate-consed-literal '(p2))))

(setf (p4::a-or-b-node-applied (find-node 2380))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 2380))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 2380))
  (list
    (p4::make-applied-op-node 
        :name 2381 
        :parent (find-node 2380)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2381))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 2015)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 2381))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 2381))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p2))))))
