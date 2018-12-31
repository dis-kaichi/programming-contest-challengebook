(ns clj.lib-search-test
  (:require [clojure.test :refer :all]
            [clj.lib.search :refer :all]))

(def xs [0 0 0 1 1 1 4 4 4])

(deftest test-upper-bound1
  (testing "Failure."
    (is (= (upper-bound xs 2) 6))))

(deftest test-upper-bound2
  (testing "Failure."
    (is (= (upper-bound xs 1) 6))))

(deftest test-upper-bound3
  (testing "Failure."
    (is (= (upper-bound xs 5) 9))))

(deftest test-upper-bound4
  (testing "Failure."
    (is (= (upper-bound xs -1) 0))))

(deftest test-lower-bound1
  (testing "Failure."
    (is (= (lower-bound xs 2) 6))))

(deftest test-lower-bound2
  (testing "Failure."
    (is (= (lower-bound xs 1) 3))))

(deftest test-lower-bound3
  (testing "Failure."
    (is (= (lower-bound xs 5) 9))))

(deftest test-lower-bound4
  (testing "Failure."
    (is (= (lower-bound xs -1) 0))))
