(ns clj.q2-1-3)
;; ----------------------------------------
;; Lake Counting
;; ----------------------------------------
(require '[clojure.string :as string])
(require '[clj.lib.graph :refer [convert-graph dump-graph]])
(require '[clj.lib.matrix :refer [deep-set deep-get]])

(defn dfs
  ([n m x y graph] (dfs n m x y graph -1 -1))
  ([n m x y graph dx dy]
   (do
     (def new-graph (deep-set graph x y "."))
     (if (> dx 1)
       new-graph
       (if (> dy 1)
         (dfs n m x y new-graph (inc dx) -1)
         (do
           (def nx (+ x dx))
           (def ny (+ y dy))
           (if (and (<= 0 nx)
                    (< nx n)
                    (<= 0 ny)
                    (< ny m)
                    (= (deep-get new-graph nx ny) "W"))
             (dfs n m nx ny new-graph)
             (dfs n m x y new-graph dx (inc dy)))))))))

(defn solver [n m field]
  (def graph (convert-graph field))
  (loop [i 0
         j 0
         res 0
         graph graph]
    (if (> i n)
      (do
        ;(dump-graph graph)
        ;(println res)
        res
        )
      (if (> j m)
        (recur (inc i) 0 res graph)
        (if (= (deep-get graph i j) "W")
          (do
            ;(dump-graph graph)
            (recur i (inc j) (inc res) (dfs n m i j graph)))
          (recur i (inc j) res graph))))))

