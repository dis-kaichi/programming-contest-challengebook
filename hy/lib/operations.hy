#!/usr/bin/env hy

;; ----------------------------------------
;; Operations
;; ----------------------------------------

(import [decorators [curried]])

;; Constants

;; Classes
(defclass LoopEnd [RuntimeError])


;; Functions
(defn safe-get [dictionary key &optional [default -1]]
  (try
    (get dictionary key)
    (except [e KeyError]
            default)))

(defn conj [coll x]
  (+ coll [x]))

(defn push [-list element]
  (.append -list element)
  -list)

(defn unique [xs]
  (list (set xs)))

#@(curried
    (defn cmap [f xs]
      (map f xs)))


;; Macros
(defmacro +=!  [dic-or-list key value]
  `(common=! + ~dic-or-list ~key ~value))

(defmacro -=!  [dic-or-list key value]
  `(common=! - ~dic-or-list ~key ~value))

(defmacro *=!  [dic-or-list key value]
  `(common=! * ~dic-or-list ~key ~value))

(defmacro /=!  [dic-or-list key value]
  `(common=! / ~dic-or-list ~key ~value))

(defmacro common=! [operation dic-or-list key value]
  `(assoc ~dic-or-list ~key (~operation (get ~dic-or-list ~key) ~value)))

