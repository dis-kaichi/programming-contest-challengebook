#!/usr/bin/env hy

;; ----------------------------------------
;; Bribe the Prisoners
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(setv data
  ["8 1"
   "3"]) ;; 7

(setv data
  ["20 3"
   "3 6 14"]) ;; 35

(defn create-matrix [n m &optional default]
  (list (map list (partition (* [default] (* n m)) m))))

(defn setm! [matrix  row col value]
  (setv x (nth matrix row))
  (assoc x col value))

(defn nthm [matrix row col]
  (-> matrix
      (nth row)
      (nth col)))

(setv +max-q+ 5) ;; Small
(setv +int-max+ 100000) ;; 適当

(setv *dp* (create-matrix (+ 1 +max-q+)
                         (+ 2 +max-q+)))

(defn solve []
  (setv (, P Q) (-> data
                    first
                    (.split " ")
                    ((partial map int))))
  (setv A (-> data
              second
              (.split " ")
              ((partial map int))
              list
              ((fn [x] (+ [0] x [0])))))
  ;; Solve Main
  (assoc A 0 0)
  (assoc A (inc Q) (inc P))
  ;; initialize
  (for [q (range (inc Q))]
    (setm! *dp* q (inc q) 0))
  ;;
  (for [w (range 2 (+ Q 2))]
    (for [i (range (+ Q 2 (- w)))]
      (setv j (+ i w))
      (setv t +int-max+)
      (for [k (range (inc i) j)]
        (setv t (min t (+ (nthm *dp* i k)
                          (nthm *dp* k j)))))
      (setm! *dp* i j (+ t
                         (nth A j)
                         (- (nth A i))
                         (- 2)))))
  (print (nthm *dp* 0 (inc Q))))

(defmain
  [&rest args]
  (solve))

