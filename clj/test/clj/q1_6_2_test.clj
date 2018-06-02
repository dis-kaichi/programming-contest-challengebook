(ns clj.q1-6-2-test
  (:require [clojure.test :refer :all]
            [clj.q1-6-2 :refer :all]))

(deftest solver-test1
  (testing "Failure."
    (is (= (solver 10 3 [2 6 7]) [4 8]))))
