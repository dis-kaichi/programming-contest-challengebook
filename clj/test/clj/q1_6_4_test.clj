(ns clj.q1-6-4-test
  (:require [clojure.test :refer :all]
            [clj.q1-6-4 :refer :all]))

(deftest solver-test1
  (testing "Failure."
    (is (= (solver 3 10 [1 3 5]) "Yes"))))

(deftest solver-test2
  (testing "Failure."
    (is (= (solver 3 9 [1 3 5]) "No"))))
