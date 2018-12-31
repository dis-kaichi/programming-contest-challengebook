(ns clj.q2-2-2-test
  (:require [clojure.test :refer :all]
            [clj.q2-2-2 :refer :all]))

(deftest fact-solver
  (testing "Failure."
    (is (= (solver 5 [1 2 4 6 8] [3 5 7 9 10]) 3))))
