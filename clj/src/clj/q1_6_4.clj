(ns clj.q1-6-4)

;; ----------------------------------------
;; くじびき : O(n^2 logn) version
;; ----------------------------------------
(require '[clj.lib.search :refer [binary-search]])

(defn create-kk [n m k]
  (loop [c 0
         d 0
         xs []]
    (if (< c n)
      (if (< d n)
        (do
          (recur c
                 (inc d)
                 (assoc xs (+ (* c n) d) (+ (nth k c) (nth k d)))))
        (recur (inc c) 0 xs))
      xs)))

(defn check-elements [n m k kk]
  (for [a (range n)
        b (range n)]
    (binary-search kk (- m (nth k a) (nth k b)))))

(defn to-result [x]
  (if x
    "Yes"
    "No"))

(defn debug [x]
  (println x)
  x)

(defn sort-reverse [xs]
  (sort #(compare %2 %1) xs))

(defn solver [n m k]
  (def kk (-> (create-kk n m k)
              sort-reverse))
  (def fs (check-elements n m k kk))
  (-> (some true? fs)
      to-result))

;(defn solver [n m k]
;  (-> [n m k]
;      (->> (apply create-kk)
;           sort
;           (into [])
;           list
;           (concat [n m k])
;           (into [])
;           (apply check-elements)
;           (into []))
;      ((partial some true?))
;      to-result))
