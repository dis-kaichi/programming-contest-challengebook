#!/usr/bin/env hy

;; ----------------------------------------
;; Tree
;; ----------------------------------------
(import [lib.operations [safe-get push]])
(import sys)

(setv +int-max+ (. sys maxsize))

(defn parameter1 []
  ;; Answer : 8
  (setv (, n k) (, 5 4))
  (setv a [1 1 1 3])
  (setv b [2 3 4 5])
  (setv l [3 1 2 1])
  (, n k a b l))

(defclass Edge []
  (defn --init-- [self to length]
    (setv (. self to) to)
    (setv (. self length) length)))

(setv *g* {})
(setv *centroid* {}) ;; その頂点が既に分割に用いられているか
(setv *subtree-size* {}) ;; その頂点を根とする部分木のサイズ（重心を探すときに使用）
(setv *ans* 0)

(defn get-centroid [x]
  (global *centroid*)
  (safe-get *centroid* x False))

(defn add-edge [from to length]
  (assoc *g* from (push (safe-get *g* from []) (Edge to length)))
  (assoc *g* to (push (safe-get *g* to []) (Edge from length))))

;; 部分木のサイズ(subtree-size)を計算する再帰関数
(defn compute-subtree-size [v p]
  (global *subtree-size*)
  (setv c 1)
  (for [i (range (len (safe-get *g* v [])))]
    (setv w (. (get *g* v i) to))
    (when (or (= w p)
              (get-centroid w))
      (continue))
    (+= c (compute-subtree-size (. (get *g* v i) to) v)))
  (assoc *subtree-size* v c)
  c)

;; 重心となる頂点を探す再帰関数。tは連結成分全体の大きさ
;; v以下で、削除により残る最大の部分木の頂点が最小となる頂点の
;; (残る最大の部分木の頂点数, 頂点番号)のペアを返す
(defn search-centroid [v p t]
  (setv res [+int-max+ -1])
  (setv (, s m) (, 1 0))
  (for [i (range (len (safe-get *g* v [])))]
    (setv w (. (get *g* v i) to))
    (when (or (= w p)
              (get-centroid w))
      (continue))
    (setv res (min res (search-centroid w v t)))
    (setv m (max m (get *subtree-size* w)))
    (+= s (get *subtree-size* w)))
  (setv m (max m (- t s)))
  (setv res (min res [m v]))
  res)

;; 部分木に含まれる全頂点の重心までの距離を列挙する再帰関数
(defn enumerate-paths [v p d ds]
  (.append ds d)
  (for [i (range (len (safe-get *g* v [])))]
    (setv w (. (get *g* v i) to))
    (when (or (= w p)
              (get-centroid w))
      (continue))
    (enumerate-paths w v (+ d (. (get *g* v i) length)) ds)))

;; 和がK以下となる組の数を求める
(defn count-pairs [ds K]
  (setv res 0)
  (.sort ds)
  (setv j (len ds))
  (for [i (range (len ds))]
    (while (and (pos? j)
                (> (+ (get ds i) (get ds (- j 1))) K))
      (-= j 1))
    (+= res (- j (if (> j i) 1 0))) ;; 自分自身とのペアは除く
    )
  (// res 2))

;; 頂点vが属する部分木に関して、重心を探し木を分割し問題を解く再帰関数
(defn solve-subproblem [v K]
  (global *centroid*)
  (global *ans*)
  ;; 重心となる頂点sを探す
  (compute-subtree-size v -1)
  (setv s (second (search-centroid v -1 (get *subtree-size* v))))
  (assoc *centroid* s True)

  ;; (1) 頂点sにより分割した部分木の中に関して数える
  (for [i (range (len (safe-get *g* s [])))]
    (when (get-centroid (. (get *g* s i) to))
      (continue))
    (solve-subproblem (. (get *g* s i) to) K))

  ;; (2) (3) 頂点sを通る頂点の組に関して数える
  (setv ds [])
  (.append ds 0) ;; 頂点sの分
  (for [i (range (len (safe-get *g* s [])))]
    (when (get-centroid (. (get *g* s i) to))
      (continue))

    (setv tds [])
    (enumerate-paths (. (get *g* s i) to)
                     s
                     (. (get *g* s i) length)
                     tds)
    (-= *ans* (count-pairs tds K)) ;; 重複してしまう分を予め引いておく
    (.extend ds tds))
  (+= *ans* (count-pairs ds K))
  (assoc *centroid* s False))

(defn solve []
  (global *ans*)
  ;; Parameters
  (setv (, N K A B L) (parameter1))
  (for [i (range (len A))]
    (add-edge (dec (get A i)) (dec (get B i)) (get L i)))

  ;; Main
  (setv *ans* 0)
  (solve-subproblem 0 K)
  (print *ans*))


(defmain
  [&rest args]
  (solve))

