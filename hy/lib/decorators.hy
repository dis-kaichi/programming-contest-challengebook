#!/usr/bin/env hy

(import collections)
(import functools)

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

(defclass memoized [object]
  ; Decorator. Caches a function's return value each time it is called.
  ; If called later with the same arguments, the cached value is returned
  ; (not reevaluated).
  (defn --init-- [self func]
    (setv (. self func) func)
    (setv (. self cache) {}))

  (defn --call-- [self &rest args]
    (if (not (isinstance args (. collections Hashable)))
      ; uncacheable. a list, for instance.
      ; better to not cache than blow up.
      ((. self func) #* args)
      (if (in args (. self cache))
        (get (. self cache) args)
        (do
          (setv value ((. self func) #* args))
          (assoc (. self cache) args value)
          value))))

  (defn --repr-- [self]
    ; Return the function's docstring
    (. self func --doc--))

  (defn --get-- [self obj objtype]
    ; Support instance methods
    (.partial functools (. self --call--) obj)))

