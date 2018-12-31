(ns clj.q2-3-11)
;; ----------------------------------------
;; 個数制限付き部分和問題(Ver2)
;; ----------------------------------------

(require '[clj.lib.matrix :refer [deep-get deep-set]])

(defn yes-or-no [x]
  (if (>= x 0) "Yes" "No"))

(defn solver [n K as ms]
  (loop [i 0
         j 0
         dp {0 0}]
    (if (>= i n)
      (yes-or-no (get dp K))
      (if (> j K)
        (recur (inc i) 0 dp)
        (if (>= (get dp j -1) 0)
          (recur i (inc j) (assoc dp j (nth ms i)))
          (if (or (< j (nth as i))
                  (<= (get dp (- j (nth as i))) 0))
            (recur i (inc j) (assoc dp j -1))
            (recur i (inc j) (assoc dp j (- (get dp (- j (nth as i))) 1)))))))))

