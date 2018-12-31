(ns clj.q2-2-1)
;; ----------------------------------------
;; 硬貨の問題
;; ----------------------------------------
(def +v+ [1 5 10 50 100 500])

(defn solver [c a]
  (loop [i 5
         ans 0
         a a]
    (if (>= i 0)
      (do
        (def t (min (Math/floor (/ a (get +v+ i)))
                    (get c i)))
        (recur (dec i) (+ ans t) (- a (* t (get +v+ i)))))
      (int ans))))

