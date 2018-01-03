#!/usr/bin/env hy

;; ----------------------------------------
;; Utility for inputs
;; ----------------------------------------

;; Functions
(defn split-with-space [x]
  (.split x " "))

(defn map-int [x]
  (list (map int x)))

;; Macros
