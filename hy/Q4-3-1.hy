#!/usr/bin/env hy

;; ----------------------------------------
;; Popular Cows
;; ----------------------------------------
(import [lib.matrix [transpose]])
(import [lib.scc [scc used? add-edge nth-cmp dfs rdfs]])

(defn parameter1 []
  ;; Answer : 1 (3rd cow)
  (setv N 3)
  (setv M 3)
  (setv (, A B) (-> [[1 2]
                     [2 1]
                     [2 3]]
                    transpose))
  (, N M A B))

(defn solve []
  ;; Parameters
  (setv (, N M A B) (parameter1))

  ;; Main
  (setv V N)
  (for [i (range M)]
    (add-edge (dec (get A i)) (dec (get B i))))
  (setv n (scc V))

  ;; 候補となる点の数を調べる
  (setv (, u num) (, 0 0))
  (for [v (range V)]
    (when (= (nth-cmp v) (dec n))
      (setv u v)
      (+= num 1)))

  ;; すべての点から到達可能か調べる
  (rdfs u 0) ;; 強連結成分分解コードを再利用
  (for [v (range V)]
    (when (not (used? v))
      ;; この点から到達不能
      (setv num 0)
      (break)))

  (print num))

(defmain
  [&rest args]
  (solve))
