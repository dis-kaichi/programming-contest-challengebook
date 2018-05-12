#!/usr/bin/env hy

;; ----------------------------------------
;; バブルソートの交換回数
;; ----------------------------------------

(defn parameter1 []
  ;; Answer : 3
  (setv n 4)
  (setv A [3 1 4 2])
  (, n A))

(defn merge-count [a]
  (setv n (len a))
  (if (<= n 1)
    0
    (do
      (setv cnt 0)
      (setv b (-> a
                  (->> (take (// n 2)))
                  list))
      (setv c (-> a
                  (cut (// n 2))
                  list))
      (+= cnt (merge-count b)) ;; (1)
      (+= cnt (merge-count c)) ;; (2)
      ;; この時点でbとcはそれぞれソートされている

      ;; (3)
      (setv (, ai bi ci) (, 0 0 0))
      (while (< ai n)
        (if (and (< bi (len b))
                 (or (= ci (len c))
                     (<= (get b bi) (get c ci))))
          (do
            (assoc a ai (get b bi))
            (+= ai 1)
            (+= bi 1))
          (do
            (+= cnt (- (// n 2) bi))
            (assoc a ai (get c ci))
            (+= ai 1)
            (+= ci 1))))
      cnt)))

(defn solve []
  ;; Parameters
  (setv (, n A) (parameter1))

  ;; Main
  (print (merge-count A))
  )


(defmain
  [&rest args]
  (solve))

