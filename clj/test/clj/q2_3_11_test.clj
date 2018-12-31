(ns clj.q2-3-11-test
  (:require [clojure.test :refer :all]
            [clj.q2-3-11 :refer :all]))

(deftest test-solver1
  (testing "Failure."
    (is (= (solver 3 17 [3 5 8] [3 2 2])) "Yes")))
