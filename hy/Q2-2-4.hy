#!/usr/bin/env hy

;; ----------------------------------------
;; Saruman's Army
;; ----------------------------------------
(require [hy.contrib.loop [loop]])

(setv data
  ["6"
   "10"
   "1 7 15 20 30 50"])

(setv +N+ (-> (nth data 0) int))
(setv +R+ (-> (nth data 1) int))
(setv +X+ (-> (nth data 2)
             (.split " ")
             ((fn [x] (map int x)))
             list))

(defn search-r-index [xs s i]
  (loop [[new-i i]]
    (if (and (< new-i +N+)
             (<= (nth xs new-i) (+ s +R+)))
      (recur (inc new-i))
      new-i)))

(defn solve []
  (setv +sorted-x+ (-> +X+ sorted))
  (loop [[i 0]
         [ans 0]]
    (if (>= i +N+)
      (print ans)
      (do
        (setv s (nth +sorted-x+ i))
        (setv new-i (search-r-index +sorted-x+ s (inc i)))
        (setv p (nth +sorted-x+ (dec new-i)))
        (setv new-i (search-r-index +sorted-x+ p new-i))
        (recur new-i (inc ans))))))

(defmain
  [&rest args]
  (solve)
  )

