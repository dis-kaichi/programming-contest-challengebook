#!/usr/bin/env hy

;; ----------------------------------------
;; No Cheating
;; ----------------------------------------

(import [lib.bipartite [bipartite-matching add-edge]])

(defn seats-to-values [seats]
  (list (map list seats)))

(defn parameter1 []
  ;; Answer : 4
  ;;          以下の様に座れば良い
  ;;          o.o
  ;;          o.o
  (setv (, M N) (, 2 3))
  (setv seat (-> ["..."
                  "..."]
                 seats-to-values))
  (, M N seat))

(defn parameter2 []
  ;; Answer : 1
  (setv (, M N) (, 2 3))
  (setv seat (-> ["x.x"
                  "xxx"]
                 seats-to-values))
  (, M N seat))

(defn parameter3 []
  ;; Answer : 1
  (setv (, M N) (, 2 3))
  (setv seat (-> ["x.x"
                  "x.x"]
                 seats-to-values))
  (, M N seat))

(defn solve []
  ;; Parameters
  (setv (, M N seat) (parameter1))

  ;; Main
  (setv dx [-1 -1 1 1])
  (setv dy [-1 0 -1 0])

  (setv num 0)
  (setv V (* M N))
  (for [y (range M)]
    (for [x (range N)]
      (when (= (get seat y x) ".")
        (+= num 1)
        (for [k (range 4)]
          (setv x2 (+ x (get dx k)))
          (setv y2 (+ y (get dy k)))
          (when (and (<= 0 x2)
                     (< x2 N)
                     (<= 0 y2)
                     (< y2 M)
                     (= (get seat y2 x2) "."))
            (add-edge (+ (* x M) y) (+ (* x2 M) y2)))))))
  (print (- num (bipartite-matching V))))

(defmain
  [&rest args]
  (solve))

