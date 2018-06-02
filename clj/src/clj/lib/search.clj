(ns clj.lib.search)

(defn binary-search [xs x]
  (loop [l 0
         r (count xs)]
    (if (< (- r l) 1)
      false
      (do
        (def i (quot (+ l r) 2))
        (if (= x (nth xs i))
          true
          (if (< (nth xs i) x)
            (recur (inc i) r)
            (recur l i)))))))
