(ns clj.q2-2-4-test
  (:require [clojure.test :refer :all]
            [clj.q2-2-4 :refer :all]))

(deftest fact-solver
  (testing "Failure."
    (is (= (solver 6 10 [1 7 15 20 30 50]) 3))))
