#!/usr/bin/env hy

(defclass Stack []
  (defn --init-- [self]
    (setv (. self stack) []))

  (defn push [self x]
    (.append (. self stack) x))

  (defn pop [self]
    (try
      (.pop (. self stack))
      (except [e Exception]
              None))))
