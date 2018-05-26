(ns clj.q1-6-1)

;; ----------------------------------------
;; 三角形
;; ----------------------------------------

(defn calculate [n a]
  (for [i (range n)
        j (range n)
        k (range n)
        :when (and (< i j)
                   (< j k))]
    (do
      (def ai (nth a i))
      (def aj (nth a j))
      (def ak (nth a k))
      (def len (reduce + [ai aj ak]))
      (def ma (max ai aj ak))
      (def res (- len ma))
      (if (< ma res)
        len
        0))))

(defn solver [n a]
  (apply max (calculate n a)))
