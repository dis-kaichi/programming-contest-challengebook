#!/usr/bin/env hy

;; ----------------------------------------
;; ヒープ木
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(setv +n+ 10000)
(setv *heap* (* [0] +n+))
(setv *size* 0)

(defn push [x]
  (global *size*)
  (setv new-i
    (loop [[i *size*]]
      (if (<= i 0)
        i
        (do
          (setv p (int (/ (dec i) 2)))
          (if (<= (nth *heap* p) x)
            i
            (do
              (assoc *heap* i (nth *heap* p))
              (recur p)))))))
  (assoc *heap* new-i x)
  (setv *size* (inc *size*)))

(defn pop []
  (global *size*)
  (setv ret (nth *heap* 0))
  (setv *size* (dec *size*))
  (setv x (nth *heap* *size*))
  (setv new-i
    (loop [[i 0]]
      (if (>= (inc (* i 2)) *size*)
        i ;; Break
        (do
          (setv a (+ (* i 2) 1))
          (setv b (+ (* i 2) 2))
          (when (and (< b *size*)
                     (< (nth *heap* b) (nth *heap* a)))
            (setv a b))
          (if (>= (nth *heap* a) x)
            i ;; Break
            (do
              (assoc *heap* i (nth *heap* a))
              (recur a)))))))
  (assoc *heap* new-i x)
  ret)

(defn solve []
  ;; 利用例
  (push 20)
  (push 10)
  (push 5)
  (push 15)
  (print (pop)) ;; 5
  (print (pop)) ;; 10
  (print (pop)) ;; 15
  (print (pop))) ;; 20

(defmain
  [&rest args]
  (solve))

