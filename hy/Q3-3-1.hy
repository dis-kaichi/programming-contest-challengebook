#!/usr/bin/env hy

;; ----------------------------------------
;; セグメント木
;; ----------------------------------------
(import [sys])
(import [lib.rmq [init :as init-rmq update query]])

(defn solve []
  (init-rmq 8)
  ;; p153の状態
  (update 0 5)
  (update 1 3)
  (update 2 7)
  (update 3 9)
  (update 4 6)
  (update 5 4)
  (update 6 1)
  (update 7 2)
  ;; a0...a7の最小値 : 1 (a6)
  (print (query 0 8))
  ;; a0...a5の最小値 : 3 (a1)
  (print (query 0 5))
  )

(defmain
  [&rest args]
  (solve))

