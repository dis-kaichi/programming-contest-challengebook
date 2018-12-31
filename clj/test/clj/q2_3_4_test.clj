(ns clj.q2-3-4-test
  (:require [clojure.test :refer :all]
            [clj.q2-3-4 :refer :all]))

(deftest test-solver1
  (testing "Failure."
    (is (= (solver 4 4 "abcd" "becd") 3))))

