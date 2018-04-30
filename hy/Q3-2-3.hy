#!/usr/bin/env hy

;; ----------------------------------------
;; Jessica's Reading Problem
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])
(import [collections [defaultdict]])

(setv data
  ["5"
   "1 8 8 8 1"]) ;; 2(1,2ページ目を読む)

(setv data
  ["7"
   "1 5 3 1 1 4 1"]) ;; 5 (2-6ページ目を読む)

(defn solve []
  ;; Parameters
  (setv P (-> data first int))
  (setv a (-> data second (.split " ") ((partial map int)) list))
  ;; Main
  (setv all (set))
  (for [i (range P)]
    (.add all (nth a i)))
  (setv n (len all))
  (setv count (defaultdict int))
  (loop [[s 0]
         [t 0]
         [num 0]
         [res P]]
    (if (and (< t P) (< num n))
      (do
        (setv tmp (get count (nth a t)))
        (assoc count (nth a t) (inc tmp))
        (if (zero? tmp)
          (recur s (inc t) (inc num) res)
          (recur s (inc t) num res)))
      (if (< num n)
        (print res)
        (do
          (setv tmp (dec (get count (nth a s))))
          (assoc count (nth a s) tmp)
          (if (zero? tmp)
            (recur (inc s) t (dec num) (min res (- t s)))
            (recur (inc s) t num (min res (- t s)))))))))

(defmain
  [&rest args]
  (solve))

