(ns clj.q2-3-12-test
  (:require [clojure.test :refer :all]
            [clj.q2-3-12 :refer :all]))

(deftest test-solver1
  (testing "Failure."
    (is (= (solver 5 [4 2 3 1 5]) 3))))
