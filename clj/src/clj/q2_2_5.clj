(ns clj.q2-2-5)
;; ----------------------------------------
;; Fence Repair
;; ----------------------------------------

(defn third [xs]
  (nth xs 2))

(defn swap-short-bar1 [ls]
  (if (> (nth ls 0) (nth ls 1))
    [1 0]
    [0 1]))

(defn calc-t [ls mii1 mii2]
  (+ (nth ls mii1)
     (nth ls mii2)))

(defn swap-short-bar2 [n ls mii1 mii2]
  (if (= mii1 (dec n))
    [mii2 mii1]
    [mii1 mii2]))


(defn calc-short-bar [n ls]
  (def miis (if (> (first ls) (second ls))
              [1 0]
              [0 1]))
  (loop [mii1 (first miis)
              mii2 (second miis)
              i 2]
    (if (>= i n)
      (do
        (def t (calc-t ls mii1 mii2))
        (def miis (swap-short-bar2 n ls mii1 mii2))
        [(first miis) (second miis) t]) ;; [mii1 mii2 t]
      (if (< (nth ls i) (nth ls mii1))
        (if (< (nth ls i) (nth ls mii2))
          (recur mii1 i (inc i))
          (recur i mii1 (inc i)))
        (recur mii1 mii2 (inc i))))))

(defn solver [N L]
  (loop [n N
         ls L
         ans 0]
    (if (<= n 1)
      ans
      (do
        (def miis (calc-short-bar n ls))
        (recur (dec n)
               (-> ls
                   (assoc (first miis) (third miis))
                   (assoc (second miis) (nth ls (dec n))))
               (+ ans (third miis)))))
    ))
