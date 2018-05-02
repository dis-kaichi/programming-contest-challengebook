#!/usr/bin/env hy

;; ----------------------------------------
;; Matrix Power Series
;; ----------------------------------------

(import [lib.matrix [mod-pow set-mod create-matrix]])

(setv data
  ["2 2 4"
   "0 1"
   "1 1"
   ])

(setv +m+ 10007)

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
  (set-mod +m+)
  (setv B (create-matrix (* 2 n) (* 2 n) 0))
  (for [i (range n)]
    (for [j (range n)]
      (setv (get B i j) (get A i j)))
    (setv (get B (+ n i) i) 1)
    (setv (get B (+ n i) (+ n i)) 1))
  (setv B (mod-pow B (+ k 1))) ;; I+A+A^2+...+A^k
  (for [i (range n)]
    (for [j (range n)]
      (setv a (% (get B (+ n i) j) +m+))
      ;; Iを引く
      (when (= i j)
        (setv a (% (+ a +m+ -1) +m+)))
      (print #* [(.format "{0}{1}" a (if (= (inc j) n) "\n" " "))]
             #** {"end" ""}))))

(defmain
  [&rest args]
  (solve))

