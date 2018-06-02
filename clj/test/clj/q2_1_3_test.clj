(ns clj.q2-1-3-test
  (:require [clojure.test :refer :all]
            [clj.q2-1-3 :refer :all]))

(deftest fact-solver
  (testing "Failure."
    (is (= (solver 10 12 ["W........WW."
                          ".WWW.....WWW"
                          "....WW...WW."
                          ".........WW."
                          ".........W.."
                          "..W......W.."
                          ".W.W.....WW."
                          "W.W.W.....W."
                          ".W.W......W."
                          "..W.......W."])
           3))))
