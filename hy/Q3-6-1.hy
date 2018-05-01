#!/usr/bin/env hy

;; ----------------------------------------
;; Jack Straws
;; ----------------------------------------

(import [lib.matrix [transpose create-matrix]])
(import [lib.point [Point on-segment? intersection]])

(defn list-to-point [xs]
  (Point #* xs))

(defn lists-to-points [xs]
  (list (map list-to-point xs)))

(defn parameter1 []
  ;; Answer : CONNECTED
  ;;        : NOT CONNECTED
  ;;        : CONNECTED
  ;;        : NOT CONNECTED
  (setv n 4)
  (setv p (-> [[0 4]
               [0 1]
               [1 2]
               [1 0]]
              lists-to-points))
  (setv q (-> [[4 1]
               [2 3]
               [3 4]
               [2 1]]
              lists-to-points))
  (setv m 4)
  (setv (, a b) (-> [[1 2]
                     [1 4]
                     [2 3]
                     [2 4]]
                    transpose))
  (, n p q m a b))

(defn solve []
  ;; Parameters
  (setv (, n p q m a b) (parameter1))

  ;; Main
  (setv g (create-matrix n n False))

  (for [i (range n)]
    (assoc (get g i) i True)
    (for [j (range i)]
      ;; 棒iと棒jが共有点を持つか判定
      (if (zero? (.det (- (get p i) (get q i))
                       (- (get p j) (get q j))))
        (do
          ;; 並行な場合
          (setv flag (or (on-segment? (get p i) (get q i) (get p j))
                         (on-segment? (get p i) (get q i) (get q j))
                         (on-segment? (get p j) (get q j) (get p i))
                         (on-segment? (get p j) (get q j) (get q i))))
          (assoc (get g i) j flag)
          (assoc (get g j) i flag))
        (do
          ;; 並行でない場合
          (setv r (intersection (get p i) (get q i) (get p j) (get q j)))
          (setv flag (and (on-segment? (get p i) (get q i) r)
                          (on-segment? (get p j) (get q j) r)))
          (assoc (get g i) j flag)
          (assoc (get g j) i flag)))))
  ;; ワーシャルフロイド法で全点間の連結判定をする
  (for [k (range n)]
    (for [i (range n)]
      (for [j (range n)]
        (setv flag (and (get g i k) (get g k j)))
        (assoc (get g i) j (or (get g i j) flag)))))

  (for [i (range m)]
    (print (if (get g
                    (dec (get a i))
                    (dec (get b i)))
             "CONNECTED"
             "NOT CONNECTED"))))

(defmain
  [&rest args]
  (solve))

