(ns clj.q2-1-1)

;; ----------------------------------------
;; 色々
;; ----------------------------------------

(require '[clj.lib.queue :refer [+empty-queue+]])

;; 再帰関数
;;; 階乗
(defn fact [n]
  (if (= n 0)
    1
    (* n (fact (dec n)))))

;;; フィボナッチ
(defn fib [n]
  (if (<= n 1)
    n
    (+ (fib (- n 1)) (fib (- n 2)))))

;; メモ化
;;; https://qiita.com/athos/items/f7eee78e64bf9fb35334
(defn ^:dynamic fib-memo [n]
  (if (<= n 1)
    1
    (+ (#'fib-memo (- n 1)) (#'fib-memo (- n 2)))))

;; スタック
;;; push : conjとして通常のベクタ操作で良い

;; キュー
;;; enque : conj
;;; deque : peek & popとしてJavaのクラスを使う

(defn solver []
  (println "10! = " (fact 10))
  (println "fib(5) = " (fib 5))
  (binding [fib-memo (memoize fib-memo)]
    (println "fib(10) = " (fib-memo 10)))
  (def stack (-> []
                 (conj 1 2 3)))
  (println "--- stack ---")
  (loop [s stack]
    (when (not (empty? s))
      (println (peek s))
      (recur (pop s))))
  (println "--- queue ---")
  (def que (-> +empty-queue+
               (conj 1)
               (conj 2)
               (conj 3)))
  (loop [q que]
    (when (not (empty? q))
      (println (peek q))
      (recur (pop q)))))
