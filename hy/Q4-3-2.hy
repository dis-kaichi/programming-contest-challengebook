#!/usr/bin/env hy

;; ----------------------------------------
;; Priest John's Busiest Day
;; ----------------------------------------
(import [lib.matrix [transpose]])
(import [lib.operations [cmap]])
(import [lib.scc [scc add-edge nth-cmp]])

(defn time-to-minutes [t]
  (setv (, h m) (-> t
                    (.split ":")
                    ((cmap int))))
  (+ (* h 60) m))

(defn parameter1 []
  ;; Answer : YES
  ;;        : 08:00 08:30
  ;;        : 08:40 09:00
  (setv N 2)
  (setv (, S T D) (-> [["08:00" "09:00" 30]
                       ["08:15" "09:00" 20]]
                      transpose))
  (setv S (-> S ((cmap time-to-minutes)) list))
  (setv T (-> T ((cmap time-to-minutes)) list))
  (, N S T D))

(defn solve []
  ;; Parameters
  (setv (, N S T D) (parameter1))

  ;; Main

  ;; 0~N-1      : x_i
  ;; N~2N-1     : not x_i
  (setv V (* 2 N))
  (for [i (range N)]
    (for [j (range i)]
      (when (> (min (+ (get S i) (get D i))
                    (+ (get S j) (get D j)))
               (max (get S i)
                    (get S j)))
        ;; x_i => not x_j
        ;; x_j => not x_i
        (add-edge i (+ N j))
        (add-edge j (+ N i)))
      (when (> (min (+ (get S i) (get D i))
                    (get T j))
               (max (get S i)
                    (- (get T j) (get D j))))
        ;; x_i      => x_j
        ;; not x_j  => not x_i
        (add-edge i j)
        (add-edge (+ N j) (+ N i)))
      (when (> (min (get T i)
                    (+ (get S j) (get D j)))
               (max (- (get T i) (get D i))
                    (get S j)))
        ;; not x_i  => not x_j
        ;; x_j      => x_i
        (add-edge (+ N i) (+ N j))
        (add-edge (j i)))
      (when (> (min (get T i)
                    (get T j))
               (max (- (get T i) (get D i))
                    (- (get T j) (get D j))))
        ;; not x_i => x_j
        ;; not x_j => x_i
        (add-edge (+ N i) j)
        (add-edge (+ N j) i))))
  (scc V)

  (try
    ;; 可能かどうかを判定
    (for [i (range N)]
      (when (= (nth-cmp i) (nth-cmp (+ N i)))
        (print "NO")
        (raise EndLoop)))
    ;; 可能な場合に解を復元
    (print "YES")
    (for [i (range N)]
      (if (> (nth-cmp i) (nth-cmp (+ N i)))
        ;; x_iが真、つまり結婚式の最初に行う
        (print (.format "{0:02}:{1:02} {2:02}:{3:02}"
                        (// (get S i) 60)
                        (% (get S i) 60)
                        (// (+ (get S i) (get D i)) 60)
                        (% (+ (get S i) (get D i)) 60)))
        ;; x_iが偽、つまり結婚式の最後に行う
        (print (.format "{0:02}:{1:02} {2:02}:{3:02}"
                        (// (- (get T i) (get D i)) 60)
                        (% (- (get T i) (get D i)) 60)
                        (// (get T i) 60)
                        (% (get T i ) 60)))))
    (except [e EndLoop]))
  )

(defmain
  [&rest args]
  (solve))
