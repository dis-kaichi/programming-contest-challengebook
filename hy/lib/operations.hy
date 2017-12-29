#!/usr/bin/env hy

;; ----------------------------------------
;; Operations
;; ----------------------------------------

;; Functions
(defn safe-get [dictionary key &optional [default -1]]
  (try
    (get dictionary key)
    (except [e KeyError]
            default)))

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

