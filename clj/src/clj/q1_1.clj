(ns clj.q1-1)

;; ----------------------------------------
;; くじ引き
;; ----------------------------------------

(defn solver [n m k]
  (def loop-end (dec n))
  (loop [x1 0
         x2 0
         x3 0
         x4 0]
    (if (= (reduce + [(nth k x1)
                      (nth k x2)
                      (nth k x3)
                      (nth k x4)])
           m)
      "Yes"
      (do
        (if (= x4 loop-end)
          (recur x1 x2 (inc x3) 0)
          (if (= x3 loop-end)
            (recur x1 (inc x2) 0 0)
            (if (= x2 loop-end)
              (recur (inc x1) 0 0 0)
              (if (= x1 loop-end)
                "No"
                (recur x1 x2 x3 (inc x4))))))))))
