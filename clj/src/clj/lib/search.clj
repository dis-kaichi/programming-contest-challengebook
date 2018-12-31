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

(defn lower-bound [xs value & {:keys [lower upper]
                               :or {lower 0 upper -1}}]
  (if (empty? xs)
    0
    (loop [lower lower
           upper (if (= upper -1) (count xs) upper)]
      (if (> (- upper lower) 1)
        (let [mid (quot (+ lower upper) 2)]
          (if (< (nth xs mid) value)
            (recur mid upper)
            (recur lower mid)))
        (if (< (nth xs lower) value)
          upper
          lower)))))

(defn upper-bound [xs value & {:keys [lower upper]
                      :or {lower 0 upper -1}}]
  (if (empty? xs)
    0
    (loop [lower lower
                 upper (if (= upper -1) (count xs) upper)]
      (if (> (- upper lower) 1)
        (let [mid (quot (+ lower upper) 2)]
          (if (<= (nth xs mid) value)
            (recur mid upper)
            (recur lower mid)))
        (if (<= (nth xs lower) value)
          upper
          lower)))))

