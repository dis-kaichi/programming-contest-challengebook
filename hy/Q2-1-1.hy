#!/usr/bin/env hy

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

;; 3. メモ化(フィボナッチ)
(def +MEMO+ (* [0] 1000))
(defn fib-memo [n]
  (if (<= n 1)
    n
    (if (not (= (nth +MEMO+ n) 0))
      (nth +MEMO+ n)
      (do
        (assoc +MEMO+ n (+ (fib (dec n)) (fib (dec (dec n)))))
        (nth +MEMO+ n)))))

;; 4. スタック
(defn push [_stack x]
  (.append _stack x))
(defn pop [_stack]
  (try
    (.pop _stack)
    (except [e Exception]
            None)))
(defn stack-test []
  (def stack [])
  (push stack 1)
  (push stack 2)
  (push stack 3)
  (print "\t" (pop stack))
  (print "\t" (pop stack))
  (print "\t" (pop stack))
  )

;; 5. キュー
(import [Queue [Queue]])
(defn enqueue [_queue x]
  (.append _queue x))
(defn dequeue [_queue]
  (try
    (_queue.pop 0)
    (except [e Exception]
            None)))

(defn queue-test []
  (def queue [])
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
  (print "3. フィボナッチ(メモ化)")
  (print "\t Fib(7) =" (fib-memo 7))
  (print "4. スタック")
  (stack-test)
  (print "5. キュー")
  (queue-test)
  )

(defmain
  [&rest args]
  (solve))

