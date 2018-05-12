#!/usr/bin/env hy

(import [lib.operations [safe-get]])
(require [hy.contrib.loop [loop]])

;; 1. 再帰関数(階乗)
(defn fact [n]
  (if (= n 0)
    1
    (* n (fact (dec n)))))

;; 2. 再帰関数(フィボナッチ)
(defn fib [n]
  (if (<= n 1)
    n
    (+ (fib (dec n)) (fib (dec (dec n))))))

;; 3.1. メモ化(フィボナッチ)
;; (*) データをソートする必要がなければ辞書でメモ化するとよい
(setv +memo+ {})
(defn fib-memo [n]
  ;; 大きい数だと再帰で爆発する
  (if (<= n 1)
    n
    (if (not (zero? (safe-get +memo+ n 0)))
      (get +memo+ n)
      (do
        (assoc +memo+ n (+ (fib-memo (- n 1))
                           (fib-memo (- n 2))))
        (get +memo+ n)))))

;; 3.2. メモ化(フィボナッチ)改良版
(setv +memo2+ {})
(defn fib-memo2 [x]
  ;; 0から算出するので再帰で爆発しない
  (loop [[n 0]
         [prev1 0]
         [prev2 1]]
    (if (= n x)
      (+ prev1 prev2)
      (if (<= n 1)
        (do
          (assoc +memo2+ n n)
          (recur (inc n) 0 1))
        (do
          (assoc +memo2+ n (+ prev1 prev2))
          (recur (inc n)
                 (get +memo2+ (- n 1))
                 (get +memo2+ (- n 2))))))))

;; 4. スタック
;(defn push [_stack x]
;  (.append _stack x))
;(defn pop [_stack]
;  (try
;    (.pop _stack)
;    (except [e Exception]
;            None)))
(import [lib.stack [Stack]])
(defn stack-test []
  (setv stack (Stack))
  (.push stack 1)
  (.push stack 2)
  (.push stack 3)
  (print "\t" (.pop stack))
  (print "\t" (.pop stack))
  (print "\t" (.pop stack))
  )

;; 5. キュー
(defn enqueue [_queue x]
  (.append _queue x))
(defn dequeue [_queue]
  (try
    (_queue.pop 0)
    (except [e Exception]
            None)))

(defn queue-test []
  (setv queue [])
  (enqueue queue 1)
  (enqueue queue 2)
  (enqueue queue 3)
  (print "\t" (dequeue queue))
  (print "\t" (dequeue queue))
  (print "\t" (dequeue queue)))

(defn solve []
  (print "1. 階乗")
  (print "\t 10! =" (fact 10))
  (print "2. フィボナッチ")
  (print "\t Fib(7) =" (fib 7))
  (print "3.1. フィボナッチ(メモ化; 単純再帰)")
  (print "\t Fib(7) =" (fib-memo 7))
  (print "3.2. フィボナッチ(メモ化; 算出順序考慮)")
  (print "\t Fib(7) =" (fib-memo2 7))
  (print "4. スタック")
  (stack-test)
  (print "5. キュー")
  (queue-test))

(defmain
  [&rest args]
  (solve))

