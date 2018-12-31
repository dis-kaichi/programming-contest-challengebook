(ns clj.q2-2-3-test
  (:require [clojure.test :refer :all]
            [clj.q2-2-3 :refer :all]))

(deftest fact-solver
  (testing "Failure."
    (is (= (solver 6 "ACDBCB") "ABCBCD"))))
