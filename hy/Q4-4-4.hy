#!/usr/bin/env hy

;; ----------------------------------------
;; 個数制限付きナップサック
;; ----------------------------------------
(import [lib.matrix [transpose]])
(import [lib.operations [safe-get]])

(defn parameter1 []
  ;; Answer : 11 (1: 2, 2: 1, 3: 1)
  (setv n 3)
  (setv (, w v m) (-> [[3 2 5]
                       [2 4 1]
                       [4 3 3]]
                      transpose))
  (setv W 12)
  (, n w v m W))

(defn solve []
  ;; Parameters
  (setv (, n w v m W) (parameter1))

  ;; Main
  (setv dp {})   ; DPテーブル

  (for [i (range n)]
    (setv num (get m i))
    (setv k 1)
    (while (pos? num)
      (setv mul (min k num))
      (setv j W)
      (while (>= j (* (get w i) mul))
        (assoc dp j (max (safe-get dp j 0)
                         (+ (safe-get dp (- j (* (get w i) mul)) 0)
                            (* (get v i) mul))))
        (-= j 1))
      (-= num mul)
      (<<= k 1)))
  (print (get dp W)))

(defmain
  [&rest args]
  (solve))
