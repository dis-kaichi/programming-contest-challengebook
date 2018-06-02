(ns clj.q2-1-2-test
  (:require [clojure.test :refer :all]
            [clj.q2-1-2 :refer :all]))

(deftest solver-test1
  (testing "Failure."
    (is (= (solver 4 [1 2 4 7] 13) "Yes"))))

(deftest solver-test2
  (testing "Failure."
    (is (= (solver 4 [1 2 4 7] 15) "No"))))
