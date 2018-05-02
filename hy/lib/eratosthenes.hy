#!/usr/bin/env hy

;; ----------------------------------------
;; 素数 (エラトステネスの篩)
;; ----------------------------------------

(import [operations [safe-get]])

(setv *prime* {})     ;; 素数値
(setv *is-prime* {})  ;; 素数判定用

(defn sieve [n]
  (setv p 0)
  (assoc *is-prime* 0 False)
  (assoc *is-prime* 1 False)
  (for [i (range 2 (inc n))]
    (when (safe-get *is-prime* i True)
      (assoc *prime* p i)
      (+= p 1)
      (for [j (range (* 2 i) (inc n) i)]
        (assoc *is-prime* j False))))
  p)

;; x番目の素数を取得
;;  引数未指定の場合は素数のリストを取得
(defn get-prime [&optional [x -1]]
  (if (neg? x)
    *prime*
    (get *prime* x)))
