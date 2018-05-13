#!/usr/bin/env hy

;; ----------------------------------------
;; Sequence
;; ----------------------------------------
(import [lib.suffixarray [construct-sa-list :as construct-sa]])

(defn parameter1 []
  ;; Answer : 1 10 2 4 3 ({10,1}, {2}, {4, 3})
  (setv N 5)
  (setv A [10 1 2 3 4])
  (, N A))

(defn my-reversed [xs]
  (if (<= (len xs) 1)
    xs
    (reversed xs)))

(defn solve []
  ;; Parameters
  (setv (, N A) (parameter1))

  ;; Main

  ;; Aを逆転したものを作り、その接尾辞配列を構成
  (setv sa [])
  (setv rev (-> A my-reversed list))
  (construct-sa rev sa)
  (setv sa (-> sa reversed list)) ;; ???

  ;; 最初に区切る場所を見つける
  (setv p1 0)
  (for [i (range N)]
    (setv p1 (- N (get sa i)))
    (when (and (>= p1 1)
               (>= (- N p1) 2))
      (break)))

  ;; p1以降の文字列を逆転して二回繰り返したものと、その接尾辞配列を構成
  (setv m (- N p1))
  (setv rev (-> A (cut p1) my-reversed list))
  (setv rev (* rev 2))
  (setv sa [])
  (construct-sa rev sa)
  (setv sa (-> sa reversed list))

  ;; 2回目に区切る場所を見つける
  (setv p2 0)
  (for [i (range (* 2 m))]
    (setv p2 (+ p1 m (- (get sa i))))
    (when (and (>= (- p2 p1) 1)
               (>= (- N p2) 1))
      (break)))

  (setv result (-> A
                   (->> (take p1))
                   list
                   my-reversed
                   list))
  (.extend result (-> A
                     list
                     (cut p1)
                     (->> (take (- p2 p1)))
                     list
                      my-reversed
                      list))
  (.extend result (-> A
                      (cut p2)
                      (->> (take (- N p2)))
                      list
                      my-reversed
                      list))
  (print result))

(defmain
  [&rest args]
  (solve))
