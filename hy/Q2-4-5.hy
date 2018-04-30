#!/usr/bin/env hy

;; ----------------------------------------
;; 二分探索木
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(defclass Node [object]
  [_value 0
   _left None
   _right None
   value (property #* [] #** {"doc" "value property"})
   right (property #* [] #** {"doc" "right property"})
   left (property #* [] #** {"doc" "left property"})
   ]
  #@(value.setter
  (defn value [self value]
    (setv (. self _value) value)))
  #@(value.getter
  (defn value [self]
    (. self _value)))
  #@(right.setter
  (defn right [self right]
    (setv (. self _right) right)))
  #@(right.getter
  (defn right [self]
    (. self _right)))
  #@(left.setter
  (defn left [self left]
    (setv (. self _left) left)))
  #@(left.getter
  (defn left [self]
    (. self _left)))
  (defn --str-- [self]
    (str (. self _value)))
  )

(defn insert [p x]
  (if (none? p)
    (do
      (setv q (Node))
      (setv (. q value) x)
      q)
    (do
      (if (< x (. p value))
        (do
          (setv (. p left) (insert (. p left) x))
          p)
        (do
          (setv (. p right) (insert (. p right) x))
          p)))))

(defn find [p x]
  (if (none? p)
    False
    (if (= x (. p value))
      True
      (if (< x (. p value))
        (find (. p left) x)
        (find (. p right) x)))))

(defn remove [p x]
  (if (none? p)
    None
    (if (< x (. p value))
      (do
        (setv (. p left) (remove (. p right) x))
        p)
      (if (> x (. p value))
        (do
          (setv (. p right) (remove (. p right) x))
          p)
        (if (none? (. p left))
          (do
            (setv q (. p right))
            (del p)
            q)
          (if (none? (. p left right))
            (do
              (setv q (. p right))
              (setv (. q right) (. p right))
              (del p)
              q)
            (do
              (loop [[q (. p left)]]
                (if (not (none? (. q right right)))
                  (recur (. q right))
                  (do
                    (setv r (. q right))
                    (setv (. q right) (. r left))
                    (setv (. r left) (. p left))
                    (setv (. r right) (. p right))
                    (del p)
                    r))))))))))

(defn solve []
  (-> None
      (insert 10)
      (insert 5)
      (insert 12)
      (find 10)   ;; Found!
      print)
  (-> None
      (insert 10)
      (insert 5)
      (insert 12)
      (remove 10)
      (find 10)   ;; Not Found!
      print))

(defmain
  [&rest args]
  (solve))

