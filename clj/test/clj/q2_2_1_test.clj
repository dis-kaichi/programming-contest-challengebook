(ns clj.q2-2-1-test
  (:require [clojure.test :refer :all]
            [clj.q2-2-1 :refer :all]))

(deftest fact-solver
  (testing "Failure."
    (is (= (solver [3 2 1 3 0 2] 620) 6))))
