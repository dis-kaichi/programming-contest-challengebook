(ns clj.q2-1-1-test
  (:require [clojure.test :refer :all]
            [clj.q2-1-1 :refer :all]))

(deftest fact-test
  (testing "Failure."
    (is (= (fact 10) 3628800))))

(deftest fib-test
  (testing "Failure."
    (is (= (fib 5) 5))))

(deftest fib-memo-test
  (testing "Failure."
    (binding [fib-memo (memoize fib-memo)]
      (is (= (fib-memo 10) 89)))))
