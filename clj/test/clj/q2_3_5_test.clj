(ns clj.q2-3-5-test
  (:require [clojure.test :refer :all]
            [clj.q2-3-5 :refer :all]))

(deftest test-solver1
  (testing "Failure."
    (is (= (solver 4 5 [2 1 3 2] [3 2 4 2]) 10))))
