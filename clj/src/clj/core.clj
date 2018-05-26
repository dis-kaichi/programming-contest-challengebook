(ns clj.core)

;; repl reload用
;;  (clojure.tools.namespace.repl/refresh)
;;  (refresh)
(use '[clojure.tools.namespace.repl :only (refresh)])

;(use '[clj.q1-1 :only [solver]])
(use '[clj.q1-1-6 :only [solver]])

(defn -main
  []
  ;(solver 3 10 [1 3 4])
  (solver 5 [2 3 4 5 10])
  )

(defn check
  []
  )
