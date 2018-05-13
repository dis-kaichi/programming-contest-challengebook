#!/usr/bin/env hy

;; ----------------------------------------
;; 接尾辞配列
;; ----------------------------------------
(import [functools [partial cmp-to-key]])
(setv *rank* {})
(setv *tmp* {})
(setv *n* 0)
(setv *k* 0)

(defn init []
  (global *rank*)
  (global *tmp*)
  (global *n*)
  (global *k*)
  ;;
  (setv *rank* {})
  (setv *tmp* {})
  (setv *n* 0)
  (setv *k* 0))


;; (rank_i, rank_(i+k))と(rank_j, rank_(j+k))を比較
(defn compare-sa [i j]
  (global *rank*)
  (if (!= (get *rank* i) (get *rank* j))
    (- (get *rank* j) (get *rank* i))
    (do
      (setv ri (if (<= (+ i *k*) *n*)
                 (get *rank* (+ i *k*))
                 -1))
      (setv rj (if (<= (+ j *k*) *n*)
                 (get *rank* (+ j *k*))
                 -1))
      (- rj ri))))

;; 文字列Sの接尾辞配列を構築
(defn construct-sa [S sa]
  (global *rank*)
  (global *tmp*)
  (global *n*)
  (global *k*)
  ;;
  (setv *n* (len S))

  ;; 最初は1文字、ランクは文字コードにすればよい
  (for [i (range (inc *n*))]
    (.append sa i)
    (assoc *rank* i (if (< i *n*) (ord (get S i)) -1)))

  ;; k文字についてソートされているところから、2k文字でソートする
  (setv *k* 1)
  (while (<= *k* *n*)
    (.sort sa #** {"key" (cmp-to-key compare-sa)})

    ;; 一旦tmpに次のランクを計算し、それからrankに移す
    (assoc *tmp* (get sa 0) 0)
    (for [i (range 1 (inc *n*))]
      (assoc *tmp* (get sa i)
             (+ (get *tmp* (get sa (dec i)))
                (if (compare-sa (get sa (dec i)) (get sa i))
                  1
                  0))))
    (for [i (range (inc *n*))]
      (assoc *rank* i (get *tmp* i)))
    (*= *k* 2)))

;; 文字列ではなくリスト指定(xs)
(defn construct-sa-list [xs sa]
  (global *rank*)
  (global *tmp*)
  (global *n*)
  (global *k*)
  ;;
  (setv *n* (len xs))

  (for [i (range (inc *n*))]
    (.append sa i)
    (assoc *rank* i (if (< i *n*) (get xs i) -1)))

  (setv *k* 1)
  (while (<= *k* *n*)
    (.sort sa #** {"key" (cmp-to-key compare-sa)})

    (assoc *tmp* (get sa 0) 0)
    (for [i (range 1 (inc *n*))]
      (assoc *tmp* (get sa i)
             (+ (get *tmp* (get sa (dec i)))
                (if (compare-sa (get sa (dec i)) (get sa i))
                  1
                  0))))
    (for [i (range (inc *n*))]
      (assoc *rank* i (get *tmp* i)))
    (*= *k* 2)))

;; 文字列Sとその接尾辞配列saを受け取り、高さ配列をlcpに計算
(defn construct-lcp [S sa lcp]
  (setv n (len S))
  (for [i (range (inc *n*))]
    (assoc *rank* (get sa i) i))

  (setv h 0)
  (assoc lcp 0 0)
  (for [i (range n)]
    ;; 文字列中での位置iの接尾辞と、接尾辞配列中でその１つ前の接尾辞のLCPを求める
    (setv j (-> sa
                (get (-> *rank*
                         (get i)
                         dec))))

    ;; hを先頭の分1減らし、後ろが一致しているだけ増やす
    (when (pos? h)
      (-= h 1))
    (while (and (< (+ j h) *n*)
                (< (+ i h) *n*))
      (when (!= (-> S (get (+ j h)))
                (-> S (get (+ i h))))
        (break))
      (+= h 1))
    (assoc lcp (-> *rank*
                   (get i)
                   dec)
           h))
  ;(print *rank*)
)

(defn get-rank [x]
  (get *rank* x))

(defn set-rank [x v]
  (assoc *rank* x v))

(defn dump-rank []
  (print *rank*))

;(setv sa [])
;(construct-sa "abracadabra" sa)
;(setv lcp (* [0] (len sa)))
;(construct-lcp "abracadabra" sa lcp)
;(print sa)
;(print lcp) ;; P339の状態であれば良い
;(print *tmp*)
;(print *n*)
;; => 11 10 7 0 3 5 8 1 4 6 9 2
