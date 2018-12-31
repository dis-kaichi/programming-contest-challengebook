(ns clj.q2-3-10)
;; ----------------------------------------
;; 個数制限付き部分和問題
;; ----------------------------------------

(require '[clj.lib.matrix :refer [deep-get deep-set]])

(defn my-deep-get [matrix x y]
  (deep-get matrix x y false))

(defn yes-or-no [x]
  (if x "Yes" "No"))

(defn solver [n K as ms]
  (loop [i 0
         j 0
         k 0
         dp (deep-set {} 0 0 true)]
    (if (>= i n)
      (yes-or-no (my-deep-get dp n K))
      (if (> j K)
        (recur (inc i) 0 0 dp)
        (if (and (<= k (nth ms i))
                 (<= (* k (nth as i) j)))
          (recur i j (inc k) (deep-set dp (inc i) j
                                       (or (my-deep-get dp (inc i) j)
                                           (my-deep-get dp i (- j (* k (nth as i)))))))
          (recur i (inc j) 0 dp))))))

