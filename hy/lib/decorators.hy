#!/usr/bin/env hy

(defclass curried [object]
  ; Decorator that returns a function that keeps returning functions
  ; until all arguments are supplied; then the original function is
  ; evaluated.
  (defn --init-- [self func &rest a]
    (setv (. self func) func)
    (setv (. self args) a))

  (defn --call-- [self &rest a]
    (setv args (+ (. self args) a))
    (if (< (len args) (. self func --code-- co-argcount))
      (curried (. self func) #* args)
      ((. self func) #* args)))
  )

