#!/usr/bin/env hy

;; ----------------------------------------
;; Dining
;; ----------------------------------------
(import [lib.dinic [add-edge max-flow]])

(defn int-to-bool [x]
  (if (zero? x)
    False
    True))

(defn ints-to-bools [elms]
  (list (map int-to-bool elms)))

(defn convert-likes [likes]
  (list (map ints-to-bools likes)))

(defn parameter1 []
  (setv (, N F D) (, 4 3 3))
  (setv likeF (-> [[1 1 0]
                   [0 1 1]
                   [1 0 1]
                   [1 0 1]]
                  convert-likes))
  (setv likeD (-> [[1 0 1]
                   [1 1 0]
                   [1 1 0]
                   [0 0 1]]
                  convert-likes))
  (setv answer 3)
  (, (, N F D likeF likeD) answer))

(defn solve []
  ;; Paramters
  (setv (, (, N F D likeF likeD) answer) (parameter1))

  ;; Main

  ;; 0~N-1          : 食べ物側の牛
  ;; N~2N-1         : 飲み物側の牛
  ;; 2N~2N+F-1      : 食べ物
  ;; 2N+F~2N+F+D-1  : 飲み物
  (setv s (+ (* N 2) F D))
  (setv t (inc s))

  ;; sと食べ物を結ぶ
  (for [i (range F)]
    (add-edge s (+ (* N 2) i) 1))

  ;; 飲み物とtを結ぶ
  (for [i (range D)]
    (add-edge (+ (* N 2) F i) t 1))

  (for [i (range N)]
    ;; 食べ物側の牛と飲み物側の牛を結ぶ
    (add-edge i (+ N i) 1)

    ;; 牛と好きな食べ物、飲み物を結ぶ
    (for [j (range F)]
      (when (get likeF i j)
        (add-edge (+ (* N 2) j) i 1)))
    (for [j (range D)]
      (when (get likeD i j)
        (add-edge (+ N i) (+ (* N 2) F j) 1))))

  (print (max-flow s t)))

(defmain
  [&rest args]
  (solve))

