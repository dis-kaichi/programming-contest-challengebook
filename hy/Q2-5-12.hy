#!/usr/bin/env hy

;; ----------------------------------------
;; Layout
;; ----------------------------------------
(require [hy.contrib.loop [loop]])
(import [functools [partial]])

(setv data
  ["4 2 1" ;; N ML MD
   "1 3 10" ;; (AL, BL, DL)
   "2 4 20" ;; (AL, BL, DL)
   "2 3 3"]);; (AD, BD, DD)

(setv (, +N+ +ML+ +MD+) (-> data
                           first
                           (.split " ")
                           ((partial map int))))

;; Init like/dislike list
(setv *AL* [])
(setv *BL* [])
(setv *DL* [])
(setv *AD* [])
(setv *BD* [])
(setv *DD* [])
;; like-list
(defn init-like-list [values]
  (for [value values]
    (setv (, a b d) (-> value (.split " ") ((partial map int)) list))
    (.append *AL* a)
    (.append *BL* b)
    (.append *DL* d)))
(-> data
    (cut 1)
    (->> (take +ML+))
    list
    init-like-list)
(defn init-dislike-list [values]
  (for [value values]
    (setv (, a b d) (-> value (.split " ") ((partial map int)) list))
    (.append *AD* a)
    (.append *BD* b)
    (.append *DD* d)))
(-> data
    (cut (inc +ML+))
    (->> (take +MD+))
    list
    init-dislike-list)
;;(print *AL* *BL* *DL*)
;;

(setv *d* (* [0] +N+)) ;; shortest-path

(setv +inf+ 100000)

(defn check-result [res]
  (if (< (nth *d* 0) 0)
    -1
    (if (= res +inf+)
      -2
      res)))
(defn solve []
  ;; ベルマンフォード法
  (for [i (range +N+)]
    (assoc *d* i +inf+))
  (assoc *d* 0 0)

  (for [k (range +N+)]
    (for [i (range (dec +N+))]
      (when (< (-> *d* (nth (inc i))) +inf+)
        (assoc *d* i (min (nth *d* i) (nth *d* (inc i))))))
    (for [i (range +ML+)]
      (when (< (-> *d* ((dec (nth *AL* i)))))
        (assoc *d* (dec (nth *BL* i))
               (min (nth *d* (dec (nth *BL* i)))
                    (+ (nth *d* (dec (nth *AL* i)))
                       (nth *DL* i))))))
    (for [i (range +MD+)]
      (when (< (nth *d* (dec (nth *BD* i))) +inf+)
        (assoc *d* (dec (nth *AD* i))
               (min (nth *d* (dec (nth *AD* i)))
                    (- (nth *d* (dec (nth *BD* i)))
                       (nth *DD* i))))))
    )
  (print (-> *d*
             (nth (dec +N+))
             check-result)))

(defmain
  [&rest args]
  (solve))


