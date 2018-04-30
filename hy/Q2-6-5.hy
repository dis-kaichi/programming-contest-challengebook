#!/usr/bin/env hy

;; ----------------------------------------
;; 区間内の素数の個数
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])
(import [math [floor sqrt pow]])

(setv data
  ["22 37"]
  ;["22801763489" "22801787297"]
  )

(setv +max-l+ 100)
(setv +max-sqrt-b+ 100)

(setv *is-prime-small* (* [False] +max-sqrt-b+))
(setv *is-prime* (* [False] +max-l+))

(defn segment-sieve [a b]
  (for [i (range (-> b sqrt floor))]
    (assoc *is-prime-small* i True))
  (for [i (range (- b a))]
    (assoc *is-prime* i True))
  ;;
  (for [i (range 2 (-> b sqrt floor))]
    (when (nth *is-prime-small* i)
      (for [j (range (* 2 i) (-> b sqrt floor) i)]
        (assoc *is-prime-small* j False))
      (for [j (range (* i (max 2 (floor (/ (+ a i -1) i)))) b i)]
        (assoc *is-prime* (- j a) False)))))
(defn true-2-one [x]
  (if x 1 0))

(defn solve []
  (setv (, a b) (-> data first (.split " ") ((partial map int))))
  (segment-sieve a b)
  ;; [a, b)の表から(- b a)個取得し、Trueの個数をカウントする
  (print (-> *is-prime*
             (->> (take (- b a)))
             list
             ((partial map (fn [x] (if x 1 0))))
             list
             sum)))

(defmain
  [&rest args]
  (solve))

