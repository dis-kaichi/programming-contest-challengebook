#!/usr/bin/env hy

;; ----------------------------------------
;; 文字列関連
;; ----------------------------------------

;; 部分文字列
;;  s[start:stop:step]のラッパー
(defn substring [s start &optional stop step]
  (get s (slice start stop step)))

(defmain
  [&rest args]
  (print "OK"))

