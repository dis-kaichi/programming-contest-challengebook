#!/usr/bin/env hy

;; ----------------------------------------
;; Matrix Power Series
;; ----------------------------------------

(require [hy.contrib.loop [loop]])
(require[hy.extra.anaphoric [ap-pipe]])

(def data
  ["2 2 4"
   "0 1"
   "1 1"
   ])

(def +m+ 10007)

(defn create-matrix [n m &optional [default 0]]
  (ap-pipe (* [default] (* n m))
           (partition it m)
           (map list it)
           (list it)))

;; A * B
(defn mul [A B]
  (setv C (create-matrix (len A) (len (nth B 0)) 0))
  (for [i (range (len A))]
    (for [k (range (len B))]
      (for [j (range (len (nth B 0)))]
        (setv (get C i j) (% (+ (get C i j)
                                (* (get A i k) (get B k j)))
                             +m+)))))
  C)

;; A^n
(defn pow [A n]
  (setv order (len A))
  (setv B (create-matrix order order 0))
  (for [i (range order)]
    (setv (get B i i) 1))
  (while (> n 0)
    (when (& n 1)
      (setv B (mul B A)))
    (setv A (mul A A))
    (setv n (>> n 1)))
  B)

(defn convert-matrix [lines]
  (setv matrix [])
  (for [line lines]
    (.append matrix (-> line (.split " ") ((fn [x] (map int x))) list)))
  matrix)

(defmacro += [variable value]
  `(setv ~variable (+ ~variable ~value)))

(defn solve []
  ;; Parameters
  (setv (, n k M) (-> data first (.split " ") ((fn [x] (map int x)))))
  (setv A (-> data rest convert-matrix))
  ;; Main
  (setv B (create-matrix (* 2 n) (* 2 n) 0))
  (for [i (range n)]
    (for [j (range n)]
      (setv (get B i j) (get A i j)))
    (setv (get B (+ n i) i) 1)
    (setv (get B (+ n i) (+ n i)) 1))
  (setv B (pow B (+ k 1))) ;; I+A+A^2+...+A^k
  (for [i (range n)]
    (for [j (range n)]
      (setv a (% (get B (+ n i) j) +m+))
      ;; Iを引く
      (when (= i j)
        (setv a (% (+ a +m+ -1) +m+)))
      (apply print
             [(.format "{0}{1}" a (if (= (inc j) n) "\n" " "))]
             {:end ""}))))

(defmain
  [&rest args]
  (solve))

