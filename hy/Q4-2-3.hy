#!/usr/bin/env hy

;; ----------------------------------------
;; Euclid's Game
;; ----------------------------------------

(defn parameter1 []
  ;; Answer : Stan wins
  (setv (, a b) (, 34 12))
  (, a b))

(defn parameter2 []
  ;; Answer : Ollie wins
  (setv (, a b) (, 15 24))
  (, a b))

(defn solve []
  ;; Parameters
  (setv (, a b) (parameter1))

  ;; Main
  (setv f True)

  (while True
    (when (> a b)
      (setv (, a b) (, b a)))

    ;; bがaの倍数であれば勝ち
    (when (zero? (% b a))
      (break))

    ;; 解説の2の場合であれば勝ち
    (when (> (- b a) a)
      (break))

    (-= b a)
    (setv f (not f)))

  (if f
    (print "Stan wins")
    (print "Ollie wins")))

(defmain
  [&rest args]
  (solve))
