#!/usr/bin/env hy

;; 三角形

(def data
  ["5"
   "2 3 4 5 10"])
;(def data
;  ["4"
;   "4 5 10 20"])

(def +N+ (int (nth data 0)))
(def +A+ (list (map int (.split (nth data 1)))))

(defn solve []
  (def ans 0)
  ;;
  (for [i (range +N+)]
    (for [j (range (inc i) +N+)]
      (for [k (range (inc j) +N+)]
        (def ai (nth +A+ i))
        (def aj (nth +A+ j))
        (def ak (nth +A+ k))
        (def len (sum [ai aj ak]))
        (def ma (max [ai aj ak]))
        (def res (- len ma))
        (when (< ma res)
          (def ans (max ans len))))))
  (print ans))

(defmain
  [&rest args]
  (solve))

