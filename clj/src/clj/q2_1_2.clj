(ns clj.q2-1-2)
;; ----------------------------------------
;; 部分和問題
;; ----------------------------------------

(defn dfs [n a k i ss]
  (if (= i n)
    (= ss k)
    (if (dfs n a k (inc i) ss)
      true
      (if (dfs n a k (inc i) (+ ss (nth a i)))
        true
        false))))

(defn solver [n a k]
  (if (dfs n a k 0 0)
    "Yes"
    "No"))
