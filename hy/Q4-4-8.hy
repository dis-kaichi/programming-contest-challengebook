#!/usr/bin/env hy

;; ----------------------------------------
;; 巡回スケジューリング(v3)
;; ----------------------------------------
(import [lib.matrix [transpose]])
(import [lib.operations [safe-get]])

(setv +max-log-n+ 100)

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
  (setv ps (* [0] (* 4 N)))
  (setv next {})

  (setv res 0)

  ;; ループを扱いやすくするために、二周分に増やす
  (for [i (range N)]
    (when (< (get t i) (get s i))
      (assoc t i (+ (get t i) M)))
    (.append s (+ (get s i) M))
    (.append t (+ (get t i) M)))

  ;; 区間の端点をソート
  (for [i (range (* N 2))]
    (assoc ps i (, (get t i) i))
    (assoc ps (+ (* N 2) i) (, (get s i) (+ (* 2 N) i))))
  (.sort ps)

  ;; next[0]の計算
  (setv last -1)
  (for [i (range (dec (* 4 N)) -1 -1)]
    (setv id (get ps i 1))
    (if (< id (* 2 N))
      (do
        ;; 区間の末尾
        (assoc next (, 0 id) last))
      (do
        ;; 区間の先頭
        (-= id (* N 2))
        (when (or (neg? last)
                  (> (get t last)
                     (get t id)))
          (setv last id)))))

  ;; nextの計算
  (for [k (range (dec +max-log-n+))]
    (for [i (range (* N 2))]
      (if (neg? (get next (, k i)))
        (assoc next (, (inc k) i) -1)
        (assoc next (, (inc k) i) (get next (, k (get next (, k i))))))))

  ;; 最初に使う区間を固定
  (for [i (range N)]
    ;; 二分探索を行う
    (setv tmp 0)
    (setv j i)
    (for [k (range (dec +max-log-n+) -1 -1)]
      (setv j2 (get next (, k j)))
      (when (and (>= j2 0)
                 (<= (get t j2)
                     (+ (get s i) M)))
        (setv j j2)
        (|= tmp (<< 1 k))))
    (setv res (max res (inc tmp))))

  (print res))

(defmain
  [&rest args]
  (solve))

