(ns clj.lib.vector)
;; ----------------------------------------
;; ベクトル関連
;; ----------------------------------------

(defn zip [list1 list2]
  (map vector list1 list2))
