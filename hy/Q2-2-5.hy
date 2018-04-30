#!/usr/bin/env hy

;; ----------------------------------------
;; Fence Repair
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(setv data
  ["3"
   "8 5 8"])

(setv data
  ["4"
   "8 5 9 10"])

(setv +N+ (-> (nth data 0) int))
(setv *L* (-> (nth data 1)
             (.split " ")
             ((fn [x] (map int x)))
             list))

(defn solve []
  (loop [[n +N+]
         [ans 0]]
    (if (<= n 1)
      (print ans)
      (do
        (setv (, mii1 mii2) (, 0 1))
        (when (> (nth *L* mii1) (nth *L* mii2))
          (setv (, mii1 mii2) (, mii2 mii1))) ; swap
        (for [i (range 2 n)]
          (if (< (nth *L* i) (nth *L* mii1))
            (setv (, mii1 mii2) (, i mii1))
            (when (< (nth *L* i) (nth *L* mii2))
              (setv mii2 i))))
        (setv t (+ (nth *L* mii1) (nth *L* mii2)))
        (when (= mii1 (dec n))
          (setv (, mii1 mii2) (, mii2 mii1))) ; swap
        (assoc *L* mii1 t)
        (assoc *L* mii2 (nth *L* (dec n)))
        (recur (dec n) (+ ans t))))))

(defmain
  [&rest args]
  (solve))

