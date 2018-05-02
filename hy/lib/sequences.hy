#!/usr/bin/env hy

;; ----------------------------------------
;; Utilities
;; ----------------------------------------

;; 区間最小値を求める
(defn min-element [xs &optional [start 0] [end -1]]
  (when (= end -1)
    (setv end (len xs)))
  (min (cut xs start (inc end))))

;; 区間最大値を求める
(defn max-element [xs &optional [start 0] [end -1]]
  (when (= end -1)
    (setv end (len xs)))
  (max (cut xs start (inc end))))
