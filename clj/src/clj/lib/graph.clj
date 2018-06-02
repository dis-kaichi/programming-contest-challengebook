(ns clj.lib.graph)

;; ----------------------------------------
;; グラフ系
;; ----------------------------------------

(defn split-line-with-index [line]
  (-> line
      (clojure.string/split #"")
      (->> (map-indexed (fn [k v] [k v]))
           (into (sorted-map)))))

(defn convert-graph [data]
  (-> data
      (#(map split-line-with-index %1))
      (#(map-indexed (fn [k v] [k v]) %1))
      (#(into (sorted-map) %1))))

(defn count-row [graph]
  (count graph))

(defn count-column [graph]
  (if (pos? (count-row graph))
    (-> graph (get 0) count)
    0))

(defn dump-graph [graph]
  (def row (count-row graph))
  (def col (count-column graph))
  (loop [i 0
         j 0]
    (when (< i row)
      (if (< j col)
        (do
          (print (-> graph (get i) (get j)))
          (recur i (inc j)))
        (do
          (println "")
          (recur (inc i) 0)))))
  (println ""))
