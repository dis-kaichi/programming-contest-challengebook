#!/usr/bin/env hy

;; ----------------------------------------
;; くじびき
;; ----------------------------------------
(import [lib.inpututils [split-with-space map-int]])

(defn solver [data]
  (setv n (-> data first int))
  (setv m (-> data second int))
  (setv k (-> data (nth 2) split-with-space map-int))
  (setv f False)
  (for [x1 (range n)]
    (for [x2 (range n)]
      (for [x3 (range n)]
        (for [x4 (range n)]
          (when (= (sum [(nth k x1)
                         (nth k x2)
                         (nth k x3)
                         (nth k x4)
                         ])
                   m)
            (setv f True))))))
  (if f
    "Yes"
    "No"))

(defn solve []
  ;; Data
  (setv data1
        ["3"
         "10"
         "1 3 5"]) ;; Yes
  (setv data2
        ["3"
         "9"
         "1 3 5"]) ;; No
  ;; Example1
  (print "Example1 : " (solver data1))

  ;; Example2
  (print "Example2 : " (solver data2)))

(defmain
  [&rest args]
  (solve))

