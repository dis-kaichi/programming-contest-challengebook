#!/usr/bin/env hy

;; ----------------------------------------
;; 共通部分文字列
;; ----------------------------------------
(import sys)
(import [lib.suffixarray [init :as init-sa construct-sa construct-lcp]])

(defn parameter1 []
  ;; Answer : 5 (ADABR)
  (setv S "ABRACADABRA")
  (setv T "ECADADABRBCRDAR")
  (, S T))

(defn solve []
  ;; Parameters
  (setv (, S T) (parameter1))

  ;; Main

  (setv sl (len S))
  (setv S (+ S "\0" T))

  (init-sa)
  (setv sa [])
  (construct-sa S sa)
  (setv lcp (* [0] (len sa)))
  (construct-lcp S sa lcp)

  (setv ans 0)
  (for [i (range (len S))]
    (when (!= (< (-> sa (get i)) sl)
              (< (-> sa (get (inc i))) sl))
      (setv ans (max ans (-> lcp (get i))))))

  (print ans))

(defmain
  [&rest args]
  (solve))
