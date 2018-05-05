#!/usr/bin/env hy

;; ----------------------------------------
;; Cutting Game
;; ----------------------------------------
(import [lib.sequences [max-element]])

(defn parameter1 []
  ;; Answer : LOSE
  (setv (, w h) (, 2 2))
  (, w h))

(defn parameter2 []
  ;; Answer : WIN
  (setv (, w h) (, 4 2))
  (, w h))


;; メモ化用
(setv *mem* {})

(defn grundy [w h]
  (if (in (, w h) *mem*)
    (get *mem* (, w h))
    (do
      (setv s (set))
      (setv i 2)
      (while (>= (- w i) 2)
        (.add s (^ (grundy i h) (grundy (- w i) h)))
        (+= i 1))
      (setv i 2)
      (while (>= (- h i) 2)
        (.add s (^ (grundy w i) (grundy w (- h i))))
        (+= i 1))

      (setv res 0)
      (while (in res s)
        (+= res 1))
      (assoc *mem* (, w h) res)
      res)))

(defn solve []
  ;; Parameters
  (setv (, w h) (parameter2))

  ;; Main
  (if (!= (grundy w h) 0)
    (print "WIN")
    (print "LOSE")))

(defmain
  [&rest args]
  (solve))
