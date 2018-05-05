#!/usr/bin/env hy

;; ----------------------------------------
;; Strongly Connected Component (強連結成分)
;; ----------------------------------------
(import [operations [safe-get push]])

(setv *g* {}) ;; グラフの隣接リスト表現
(setv *rg* {}) ;; 辺の向きを逆にしたグラフ
(setv *vs* [])    ;; 帰りがけ準の並び
(setv *used* {})  ;; 既に調べたか
(setv *cmp* {})   ;; 属する強連結成分

(defn used? [v]
  (global *used*)
  (safe-get *used* v False))

(defn nth-cmp [n]
  (global *cmp*)
  (safe-get *cmp* n None))

(defn add-edge [from to]
  (global *g*)
  (global *rg*)
  (assoc *g* from (push (safe-get *g* from []) to))
  (assoc *rg* to (push (safe-get *rg* to []) from)))

(defn dfs [v]
  (global *used*)
  (global *vs*)
  (global *g*)
  (assoc *used* v True)
  (for [i (range (len (safe-get *g* v [])))]
    (when (not (used? (get *g* v i)))
      (dfs (get *g* v i))))
  (.append *vs* v))

(defn rdfs [v k]
  (global *used*)
  (global *rg*)
  (global *cmp*)
  (assoc *used* v True)
  (assoc *cmp* v k)
  (for [i (range (len (safe-get *rg* v [])))]
    (when (not (used? (get *rg* v i)))
      (rdfs (get *rg* v i) k))))

(defn scc [V]
  (global *used*)
  (global *vs*)
  (setv *used* {}) ;; Clear
  (setv *vs* [])   ;; Clear
  (for [v (range V)]
    (when (not (used? v))
      (dfs v)))
  (setv *used* {}) ;; Clear
  (setv k 0)
  (for [i (range (dec (len *vs*)) -1 -1)]
    (when (not (used? (get *vs* i)))
      (rdfs (get *vs* i) k)
      (+= k 1)))
  k)

