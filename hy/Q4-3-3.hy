#!/usr/bin/env hy

;; ----------------------------------------
;; Housewife Wind
;; ----------------------------------------
(import [lib.matrix [transpose]])
(import [lib.rmq [init :as rmq-init query update]])
(import [lib.bit [add :as add-bit sum :as sum-bit set-n :as set-bit-n]])
(import [lib.operations [push safe-get]])

(defn convert-types [types]
  (setv result [])
  (for [t types]
    (setv type (if (= (first t) "A") 0 1))
    (setv values (list (map int (rest t))))
    (if (= type 0) ;; A
      (.append result [type (first values) 0])
      (.append result [type (first values) (second values)])))
  result)

(defn parameter1 []
  ;; Answer : 1 (1 => 2)
  ;;        : 3 (2 => 3)
  (setv n 3)
  (setv q 3) 
  (setv s 1)
  (setv (, a b w) (-> [[1 2 1]
                       [2 3 2]]
                      transpose))
  (setv (, types x t) (-> [["A" 2]
                           ["B" 2 3]
                           ["A" 3]]
                          convert-types
                          transpose))
  (, n q s a b w types x t))

(defclass Edge []
  (defn --init-- [self id to cost]
    (setv (. self id) id)
    (setv (. self to) to)
    (setv (. self cost) cost)))

(setv *g* {}) ;; グラフの隣接リスト表現
(setv *vs* {}) ;; DFSでの訪問順
(setv *id* {}) ;; 各頂点がeに初めて登場するインデックス
(setv *es* {}) ;; 辺のインデックス(i*2+(葉方向:0, 根方向:1))

(defn dfs [v p d k]
  (global *id*)
  (global *es*)
  ;;
  (assoc *id* v k)
  (assoc *vs* k v)
  (update k d)
  (+= k 1)
  (for [i (range (len (safe-get *g* v [])))]
    (setv e (get *g* v i))
    (when (!= (. e to) p)
      (add-bit k (. e cost))
      (assoc *es* (* (. e id) 2) k)
      (setv k (dfs (. e to) v (inc d) k))
      (assoc *vs* k v)
      (update k d)
      (+= k 1)
      (add-bit k (- (. e cost)))
      (assoc *es* (inc (* 2 (. e id))) k)))
  k)

;; 初期化
(defn init [root V]
  ;; BITを初期化する
  (setv bit-n (* (dec V) 2))
  (set-bit-n bit-n)
  ;; RQMを初期化する(最大値ではなく、最小値のインデックスを返すようにする)
  (rmq-init (dec (* V 2)))
  ;; vs, id, esを初期化する
  (dfs root -1 0 0))

;; uとvのLCAを求める
(defn lca [u v]
  (safe-get *vs* (query (min (get *id* u)
                             (get *id* v))
                        (inc (max (get *id* u)
                                  (get *id* v))))
            0))

(defn solve []
  ;; Parameters
  (setv (, n q s a b w types x t) (parameter1))

  ;; Main
  ;; 初期化
  (setv root (// n 2)) ;; 現在位置
  (for [i (range (dec n))]
    (assoc *g* (dec (get a i))
           (push (safe-get *g* (dec (get a i)) [])
                 (Edge i (dec (get b i)) (get w i))))
    (assoc *g* (dec (get b i))
           (push (safe-get *g* (dec (get b i)) [])
                 (Edge i (dec (get a i)) (get w i)))))
  (init root n)
  ;; クエリを処理
  (setv v (dec s)) ;; 現在位置
  (for [i (range q)]
    (if (zero? (get types i))
      (do
        ;; 現在位置からx[i]への移動
        (setv u (dec (get x i)))
        (setv p (lca v u))
        ;; p.vとp.uのコストの和、つまり区間(id[p], id[v]]と
        ;; (id[p], id[u]]の重みの和をBITで計算
        (print (+ (sum-bit (get *id* v))
                  (sum-bit (get *id* u))
                  (- (* (sum-bit (get *id* p)) 2))))
        (setv v u))
      (do
        ;; x[i]番の道路のコストをt[i]に変更
        (setv k (dec (get x i)))
        (add-bit (get *es* (* k 2)) (- (get t i) (get w k)))
        (add-bit (get *es* (inc (* k 2))) (- (get w k) (get t i)))
        (assoc w k (get t i))))))


(defmain
  [&rest args]
  (solve))
