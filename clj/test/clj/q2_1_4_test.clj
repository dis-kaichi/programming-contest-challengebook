(ns clj.q2-1-4-test
  (:require [clojure.test :refer :all]
            [clj.q2-1-4 :refer :all]))

(deftest fact-solver
  (testing "Failure."
    (is (= (solver 10 10 [
                          "#S######.#"
                          "......#..#"
                          ".#.##.##.#"
                          ".#........"
                          "##.##.####"
                          "....#....#"
                          ".#######.#"
                          "....#....."
                          ".####.###."
                          "....#...G#"])
           22))))
