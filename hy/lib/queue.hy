#!/usr/bin/env hy

;; ----------------------------------------
;; Queue
;; ----------------------------------------

(defclass Queue []
  [queue []]

  (defn --init-- [self])

  (defn push [self x]
    (.append (. self queue) x))

  (defn pop [self]
    (try
      (.pop (. self queue) 0)
      (except [e Exception]
              None)))

  (defn empty? [self]
    (zero? (len (. self queue))))

  (defn --str-- [self]
    (.join " " (map str (. self queue))))
  )
