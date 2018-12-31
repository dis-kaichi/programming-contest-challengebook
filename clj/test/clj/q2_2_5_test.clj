(ns clj.q2-2-5-test
  (:require [clojure.test :refer :all]
            [clj.q2-2-5 :refer :all]))

(deftest fact-solver1
  (testing "Failure."
    (is (= (solver 3 [8 5 8]) 34))))

(deftest fact-solver2
  (testing "Failure."
    (is (= (solver 4 [8 5 9 10 ]) 64))))
