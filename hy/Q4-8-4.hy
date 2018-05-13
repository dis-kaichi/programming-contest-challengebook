#!/usr/bin/env hy

;; ----------------------------------------
;; Endless Knight
;; ----------------------------------------
(import [lib.algebra [mod-comb init-fact]])

(defn parameter1 []
  ;; Answer : 2((1,1)->(2,3)->(4,4)
  ;;            (1,1)->(3,2)->(4,4))
  (setv H 4)
  (setv W 4)
  (setv R 1)
  (setv ps [[2 1]])
  (, H W R ps))

(setv +mod+ 100007)

;; 縦方向と横方向に移動するように座標を変える
(defn normarize [x y]
  (-= x 1)
  (-= y 1)
  (setv xx (- (* y 2) x))
  (setv yy (- (* x 2) y))
  (if (or (neg? xx)
          (neg? yy)
          (!= (% xx 3) 0)
          (!= (% yy 3) 0))
    (, x y False)
    (do
      (setv x (// xx 3))
      (setv y (// yy 3))
      (, x y True))))

(defn count-bit [a]
  (setv res 0)
  (while (pos? a)
    (+= res (& a 1))
    (>>= a 1))
  res)

(defn setm! [matrix x y value]
  (assoc (get matrix x) y value))

(defn solve []
  ;; Parameters
  (setv (, H W R ps) (parameter1))

  ;; Main
  (setv pn 0)
  ;; 石の座標を変え、到達不可能な所は予め除いておく
  (for [i (range R)]
    (setv (, x y flag) (normarize (get ps i 0) (get ps i 1)))
    (setm! ps i 0 x)
    (setm! ps i 1 y)
    (when flag
      (assoc ps pn (get ps i))
      (+= pn 1)))

  ;; ゴールが到達不可能なら0通り
  (assoc ps pn [H W])
  (setv (, x y flag) (normarize (get ps pn 0) (get ps pn 1)))
  (setm! ps pn 0 x)
  (setm! ps pn 1 y)
  (when (not flag)
    (print 0)
    (return))

  (setv res 0)
  (.sort ps)

  (init-fact (+ W H) +mod+)
  (for [i (range (<< 1 pn))]
    (setv add 1)
    (setv prevx 0)
    (setv prevy 0)
    (for [j (range (-> pn inc))]
      (when (or (odd? (>> i j))
                (= j pn))
        (setv mx (- (get ps j 0) prevx))
        (setv my (- (get ps j 1) prevy))
        (setv add (% (* add (mod-comb (+ mx my) mx +mod+)) +mod+))
        (setv prevx (get ps j 0))
        (setv prevy (get ps j 1))))
    (if (even? (count-bit i))
      (setv res (% (+ res add) +mod+))
      (setv res (% (+ res (- add) +mod+) +mod+))))
  (print res))

(defmain
  [&rest args]
  (solve))
