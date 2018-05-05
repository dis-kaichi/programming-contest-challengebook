#!/usr/bin/env hy

;; ----------------------------------------
;; 素数判定
;; ----------------------------------------
(import [lib.algebra [prime-factor divisor prime?]])

(defn solve []
  (print (prime? 53))       ;; True
  (print (prime? 295927))   ;; False
  (print (divisor 295927))
  (print (prime-factor 295927)))

(defmain
  [&rest args]
  (solve))
