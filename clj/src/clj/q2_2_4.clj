(ns clj.q2-2-4)
;; ----------------------------------------
;; Saruman's Army
;; ----------------------------------------
(defn search-r-index [N R xs s i]
  (loop [ii i]
    (if (and (< ii N)
             (<= (nth xs ii) (+ s R)))
      (recur (inc ii))
      ii)))

(defn solver [N R xs]
  (def sorted-xs (-> xs sort))
  (loop [i 0
         ans 0]
    (if (>= i N)
      ans
      (do
        ;; sはカバーされていない一番左の位置
        (def s (nth sorted-xs i))
        ;; sから距離Rを超える点まで進む
        (def i2 (search-r-index N R sorted-xs s (inc i)))
        ;; pは新しく印をつける点の位置
        (def p (nth sorted-xs (dec i2)))
        ;; pから距離Rを超える点まで進む
        (def i3 (search-r-index N R sorted-xs p i2))
        (recur i3 (inc ans))))))
