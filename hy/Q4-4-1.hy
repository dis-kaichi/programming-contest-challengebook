#!/usr/bin/env hy

;; ----------------------------------------
;; Largest Rectangle in Histogram
;; ----------------------------------------

(defn parameter1 []
  ;; Answer : 8
  (setv n 7)
  (setv h [2 1 4 5 1 3 3])
  (, n h))

(defn solve []
  ;; Parameters
  (setv (, n h) (parameter1))

  ;; Main
  (setv L {})
  (setv R {})
  (setv st {})
  ;; Lの計算
  (setv t 0) ;; スタックのサイズ
  (for [i (range n)]
    (while (and (pos? t)
                (>= (get h (get st (dec t))) (get h i)))
      (-= t 1))
    (assoc L i (if (zero? t)
                 0
                 (inc (get st (dec t)))))
    (assoc st t i)
    (+= t 1))

  ;; Rの計算
  (setv t 0)
  (for [i (range (dec n) -1 -1)]
    (while (and (pos? t)
                (>= (get h (get st (dec t))) (get h i)))
      (-= t 1))
    (assoc R i (if (zero? t)
                 n
                 (get st (dec t))))
    (assoc st t i)
    (+= t 1))

  (setv res 0) ;; オーバーフローに注意
  (for [i (range n)]
    (setv res (max res (* (get h i) (- (get R i) (get L i))))))
  (print res))


(defmain
  [&rest args]
  (solve))
