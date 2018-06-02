(ns clj.q2-1-4)
;; ----------------------------------------
;; 迷路の最短路
;; ----------------------------------------
(require '[clojure.string :as string])
(require '[clj.lib.queue :refer [+empty-queue+]])
(require '[clj.lib.matrix :refer [deep-set deep-get]])
(require '[clj.lib.graph :refer [convert-graph split-line-with-index dump-graph count-row count-column]])

(defn find-start-and-goal [graph]
  (def row (count-row graph))
  (def col (count-column graph))
  (loop [i 0
         j 0
         s nil
         g nil]
    (if (< i row)
      (if (< j col)
        (do
          (def value (-> graph (get i) (get j)))
          (if (= value "S")
            (recur i (inc j) [i j] g)
            (if (= value "G")
              (recur i (inc j) s [i j])
              (recur i (inc j) s g))))
        (recur (inc i) 0 s g))
      [s g])))

(def +inf+ (. Integer MAX_VALUE))
(def +dx+ [1 0 -1 0])
(def +dy+ [0 1 0 -1])

(defn loop-round [n m graph p que dist]
  (loop [i 0
         que que
         dist dist]
    (if (> i 3)
      [que dist]
      (do
        (def nx (+ (first p) (get +dx+ i)))
        (def ny (+ (second p) (get +dy+ i)))
        (if (and (<= 0 nx)
                 (< nx n)
                 (<= 0 ny)
                 (< ny m)
                 (not= "#" (str (deep-get graph nx ny)))
                 (= +inf+ (deep-get dist nx ny)))
          (do
            (recur (inc i)
                   (conj que [nx ny])
                   (deep-set dist nx ny
                         (inc (deep-get dist (first p) (second p))))))
          (recur (inc i) que dist))))))

(defn create-distance-graph [n m]
  (loop [i 0
         j 0
         dist {}]
    (if (> i n)
      dist
      (if (> j m)
        (recur (inc i) 0 dist)
        (recur i (inc j) (deep-set dist i j +inf+))))))

(defn bfs [n m graph]
  (def sg (find-start-and-goal graph))
  (def start (first sg))
  (def goal (second sg))
  (def sx (first start))
  (def sy (second start))
  (def gx (first goal))
  (def gy (second goal))
  (loop [
         ;que (conj +empty-queue+ [sx sy])
         que [[sx sy]]
         dist (deep-set
                (create-distance-graph n m)
                sx sy 0)
         ]
    (if (not (empty? que))
      (do
        (def p (peek que))
        (if (and (= gx (first p))
                 (= gy (second p)))
          (deep-get dist gx gy)
          (do
            (def res (loop-round n m graph p (pop que) dist))
            (recur (first res)(second res)))))
      nil)))

(defn solver [n m maze]
  (bfs n m (convert-graph maze)))

