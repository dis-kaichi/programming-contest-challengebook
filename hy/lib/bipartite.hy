#!/usr/bin/env hy

;; ----------------------------------------
;; 二部マッチング
;; ----------------------------------------
(import [operations [safe-get]])

(setv G {})      ;; グラフの隣接リスト表現
(setv match {})  ;; マッチングのペア
(setv used {})   ;; DFSで既に調べたかのフラグ

(defn push [-list element]
  (.append -list element)
  -list)

;; uとvを結ぶ辺をグラフに追加する
(defn add-edge [u v]
  (global G)
  (assoc G u (push (safe-get G u []) v))
  (assoc G v (push (safe-get G v []) u)))

(defn get-match [x]
  (global match)
  (safe-get match x -1))

(defn get-used [x]
  (global used)
  (safe-get used x False))

;; 増加パスをDFSで探す
(defn dfs [v]
  (global used)
  (global match)
  (setv flag False)
  (assoc used v True)
  (for [i (range (len (safe-get G v [])))]
    (setv u (get G v i))
    (setv w (get-match u))
    (when (or (< w 0)
              (and (not (get-used w))
                   (dfs w)))
      (assoc match v u)
      (assoc match u v)
      (setv flag True)
      (break)))
  flag)

;; 二部グラフの最大マッチングを求める
(defn bipartite-matching [V]
  (global used)
  (global match)
  (setv res 0)
  (setv match {})
  (for [v (range V)]
    (when (< (get-match v) 0)
      (setv used {})
      (when (dfs v)
        (+= res 1)))
    )
  res)

;; クリア
(defn clear-graph []
  (global G)
  (setv G {}))

(defn clear-match []
  (global match)
  (setv match {}))

(defn clear-used []
  (global used)
  (setv used {}))
