(ns clj.q1-6-1-test
  (:require [clojure.test :refer :all]
            [clj.q1-6-1 :refer :all]))

(deftest solver-test1
  (testing "Failure."
    (is (= (solver 5 [2 3 4 5 10]) 12))))

(deftest solver-test2
  (testing "Failure."
    (is (= (solver 4 [4 5 10 20]) 0))))
