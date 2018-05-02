#!/usr/bin/env hy

;; ----------------------------------------
;; Utility for points
;; ----------------------------------------

;; Constants
(setv +eps+ (** 10 -10))

;; Classes
(defclass Point []
  (defn --init-- [self x y]
    (setv (. self x) x)
    (setv (. self y) y))

  (defn --add-- [self other]
    (Point (double-add (. self x) (. other x))
           (double-add (. self y) (. other y))))

  (defn --sub-- [self other]
    (Point (double-add (. self x) (- (. other x)))
           (double-add (. self y) (- (. other y)))))

  (defn --mul-- [self value]
    (Point (* (. self x) value)
           (* (. self y) value)))

  (defn --eq-- [self other]
    (if (isinstance other Point)
      (and (= (. self x) (. other x))
           (= (. self y) (. other y)))
      False))

  (defn --hash-- [self]
    (hash (, (. self x) (. self y))))

  (defn --str-- [self]
    (.format "({0}, {1})" (. self x) (. self y)))

  (defn --lt-- [self other]
    (if (!= (. self x) (. other x))
      (< (. self x) (. other x))
      (< (. self y) (. other y))))

  (defn --le-- [self other]
    (if (!= (. self x) (. other x))
      (<= (. self x) (. other x))
      (<= (. self y) (. other y))))

  (defn --gt-- [self other]
    (if (!= (. self x) (. other x))
      (> (. self x) (. other x))
      (> (. self y) (. other y))))

  (defn --ge-- [self other]
    (if (!= (. self x) (. other x))
      (>= (. self x) (. other x))
      (>= (. self y) (. other y))))

  ;; Methods
  ;; 内積
  (defn dot [self other]
    (double-add (* (. self x) (. other x))
                (* (. self y) (. other y))))

  ;; 外積
  (defn det [self other]
    (double-add (* (. self x) (. other y))
                (- (* (. self y) (. other x)))))
  )

;; Functions

;; 倍精度を考慮した足し算
;;  (EPS以下の精度は保証しない)
(defn double-add [x y]
  (if (< (abs (+ x y)) (* +eps+ (+ (abs x) (abs y))))
    0
    (+ x y)))

;; 線分p1-p2上に、点qが存在するかどうか判定する
;;  True/False : 存在する/しない
(defn on-segment? [p1 p2 q]
  (and (zero? (.det (- p1 q) (- p2 q)))
       (<= (.dot (- p1 q) (- p2 q)) 0)))

;; 直線p1-p2とq1-q2の交点
(defn intersection [p1 p2 q1 q2]
  (+ p1
     (* (- p2 p1)
        (/ (.det (- q2 q1)
                 (- q1 p1))
           (.det (- q2 q1)
                 (- p2 p1))))))

