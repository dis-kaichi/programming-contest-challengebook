#!/usr/bin/env hy

;; ----------------------------------------
;; 再長回文
;; ----------------------------------------
(import sys)
(import [lib.suffixarray [init :as init-sa construct-sa construct-lcp get-rank set-rank dump-rank]])
(import [lib.rmq [init :as init-rmq update :as update-rmq query :as query-rmq dump-dat]])

(defn parameter1 []
  ;; Answer : 7 (ississi)
  (setv S "mississippi")
  (, S))

(defn my-reversed [xs]
  (if (<= (len xs) 1)
    xs
    (reversed xs)))

(defn join-to-str [xs]
  (.join "" xs))

(defn solve []
  ;; Parameters
  (setv (, S) (parameter1))

  ;; Main

  (setv n (len S))
  (setv T (-> S my-reversed join-to-str))
  (setv S (+ S "$" T))

  (init-sa)
  (setv sa [])
  (construct-sa S sa)
  (setv lcp (* [0] (len sa)))
  (construct-lcp S sa lcp)

  (for [i (range (inc (len S)))]
    (set-rank (get sa i) i))

  (init-rmq (inc (len S)))
  (for [i (range (inc (len S)))]
    (update-rmq i (get lcp i)))

  (setv ans 0)

  ;; 文字列iを中心とする奇数長の回文
  (for [i (range n)]
    (setv j (- (* n 2) i))
    (setv l (query-rmq (min (get-rank i)
                            (get-rank j))
                       (max (get-rank i)
                            (get-rank j))))
    (setv ans (max ans (dec (* 2 l)))))

  ;; 文字i-1と文字iを中心とする偶数長の回文
  (for [i (range n)]
    (setv j (+ (* n 2) (- i) 1))
    (setv l (query-rmq (min (get-rank i)
                            (get-rank j))
                       (max (get-rank i)
                            (get-rank j))))
    (setv ans (max ans (* 2 l))))
  (print ans))

(defmain
  [&rest args]
  (solve))
