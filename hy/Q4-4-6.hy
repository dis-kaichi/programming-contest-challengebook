#!/usr/bin/env hy

;; ----------------------------------------
;; 巡回スケジューリング
;; ----------------------------------------
(import [lib.matrix [transpose]])

(defn parameter1 []
  ;; Answer : 3 (All)
  (setv N 3)
  (setv M 10)
  (setv (, s t) (-> [[0 3]
                     [3 7]
                     [7 0]]
                    transpose))
  (, N M s t))

(defn parameter2 []
  ;; Answer : 2 (1, 3)
  (setv N 3)
  (setv M 10)
  (setv (, s t) (-> [[0 5]
                     [2 7]
                     [6 9]]
                    transpose))
  (, N M s t))

(defn solve []
  ;; Parameters
  (setv (, N M s t) (parameter1))

  ;; Main
  (setv ps [])

  (setv res 0)

  ;; ループを扱いやすくするために、二周分に増やす
  (for [i (range N)]
    (when (< (get t i) (get s i))
      (assoc t i (+ (get t i) M)))
    (.append s (+ (get s i) M))
    (.append t (+ (get t i) M)))

  ;; 終了時間でソート
  (for [i (range (* N 2))]
    (.append ps (, (get t i) (get s i))))
  (.sort ps)

  ;; 最初に使う区間を固定
  (for [i (range N)]
    ;; 残りは貪欲に選ぶ
    (setv (, tmp last) (, 0 0))
    (setv j i)
    (while (<= (get ps j 0)
               (+ (get ps i 1) M))
      (when (<= last (get ps j 1))
        (+= tmp 1)
        (setv last (get ps j 0)))
      (setv res (max res tmp))
      (+= j 1)))
  (print res))

(defmain
  [&rest args]
  (solve))

