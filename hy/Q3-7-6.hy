
;; ----------------------------------------
;; Wi-fi Towers
;; ----------------------------------------

(import sys)
;(import [lib.dinic [max-flow clear-graph add-edge]])
(import [lib.fordfullkerson [max-flow clear-graph add-edge]])

(setv +inf+ (. sys maxsize))

(defn parameter1 []
  ;; Answer : 5
  ;; (Memo) yの値が間違っていた(第2版)
  ;;        正しい値は公式HPを参照した
  ;;        https://code.google.com/codejam/contest/311101/dashboard#s=p3&a=3
  (setv n 5)
  (setv x [0 0 5 10 15])
  (setv y [1 -1 0 0 1])
  (setv r [7 7 1 6 2])
  (setv s [10 10 -15 10 -20])
  (, n x y r s))

(defn solve []
  ;; Parameters
  (setv (, n x y r s) (parameter1))

  ;; Main
  ;; nをsource、n+1をsinkとしn+2頂点のネットワーク
  (clear-graph)

  (setv ans 0)
  (for [i (range n)]
    (if (neg? (get s i))
      (add-edge n i (- (get s i)))
      (do
        (+= ans (get s i))
        (add-edge i (inc n) (get s i))))

    (for [j (range n)]
      (when (= i j)
        (continue))

      (when (<= (+ (pow (- (get x i) (get x j)) 2)
                   (pow (- (get y i) (get y j)) 2))
                (pow (get r i) 2))
        (add-edge j i +inf+))))

  (-= ans (max-flow n (+ n 1)))
  (print ans))

(defmain
  [&rest args]
  (solve))

