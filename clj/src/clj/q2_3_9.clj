(ns clj.q2-3-9)
;; ----------------------------------------
;; 01ナップサック問題その2
;; ----------------------------------------

(require '[clj.lib.matrix :refer [deep-get deep-set]])

(def +inf+ Integer/MAX_VALUE)

(defn find-max-weight [dp size n W]
  (loop [i 0
         res 0]
    (if (> i size)
      res
      (if (<= (deep-get dp n i +inf+) W)
        (recur (inc i) i)
        (recur (inc i) res)))))

(defn solver [n W ws vs]
  (def size (* n W))
  (loop [i 0
           j 0
           dp (deep-set {} 0 0 0)]
    (if (>= i n)
      (find-max-weight dp size n W)
      (if (> j size)
        (recur (inc i) 0 dp)
        (if (< j (nth vs i))
          (recur i (inc j) (deep-set dp (int i) j (deep-get dp i j +inf+)))
          (recur i (inc j) (deep-set dp (inc i) j
                                     (min (deep-get dp i j +inf+)
                                          (+ (deep-get dp i (- j (nth vs i)) +inf+)
                                             (nth ws i)))))))))
  )

