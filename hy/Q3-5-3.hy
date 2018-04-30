#!/usr/bin/env hy

;; ----------------------------------------
;; 仕事の割り当て１
;; ----------------------------------------

(require [hy.contrib.loop [loop]])
(import [lib.inpututils [split-with-space map-int]])
(import [lib.operations [safe-get conj]])
(import [lib.dinic [max-flow add-edge]])

(setv data
  ["3 3" ;; N K
   "1 1 0"
   "1 0 1"
   "0 1 0"])

(defn number-2-bool [x]
  (if (zero? x)
    False
    True))

(defn solve []
  ;; Parameters
  (setv (, N K) (-> data first split-with-space map-int))
  (setv matrix (-> data
                   rest
                   ((fn [x] (map (comp map-int split-with-space) x)))
                   list))

  ;; Main
  (setv can
        (loop [[lines matrix]
               [result []]]
          (if (empty? lines)
            result
            (do
              (recur (-> lines rest list)
                     (conj result
                           (-> lines
                               first
                               ((fn [x] (map number-2-bool x)))
                               list)))))))
  ;; 0〜N-1   : コンピュータに対する頂点
  ;; N〜N+K-1 : 仕事に対応する頂点
  (setv s (+ N K))
  (setv t (+ s 1))

  ;; sとコンピュータを結ぶ
  (for [i (range K)]
    (add-edge s i 1))

  ;; 仕事とtを結ぶ
  (for [i (range K)]
    (add-edge (+ N i) t 1))

  ;; コンピュータと仕事を結ぶ
  (for [i (range N)]
    (for [j (range K)]
      (when (get can i j)
        (add-edge i (+ N j) 1))))

  (print (max-flow s t)))

(defmain
  [&rest args]
  (solve))
