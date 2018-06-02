(ns clj.core)

;; repl reload用
;;  (clojure.tools.namespace.repl/refresh)
;;  (refresh)
(require '[clojure.tools.namespace.repl :refer (refresh)])
(require '[clojure.pprint :refer [pprint]])

(require '[clj.q1-1 :refer [solver] :rename {solver solver1-1}])
(require '[clj.q1-6-1 :refer [solver] :rename {solver solver1-6-1}])
(require '[clj.q1-6-2 :refer [solver] :rename {solver solver1-6-2}])
(require '[clj.q1-6-3 :refer [solver] :rename {solver solver1-6-3}])
(require '[clj.q1-6-4 :refer [solver] :rename {solver solver1-6-4}])
(require '[clj.q2-1-1 :refer [solver] :rename {solver solver2-1-1}])
(require '[clj.q2-1-2 :refer [solver] :rename {solver solver2-1-2}])
(require '[clj.q2-1-3 :refer [solver] :rename {solver solver2-1-3}])
(require '[clj.q2-1-4 :refer [solver] :rename {solver solver2-1-4}])
(require '[clj.lib.search :refer [binary-search]])
(require '[clj.lib.matrix :refer [init dump deep-aget deep-aset] :rename {init init-matrix}])

(defn check [n m graph]
  )
(defn -main
  []
  ;(solver1-1 3 10 [1 3 4])
  ;(solver1-6-1 5 [2 3 4 5 10])
  ;(solver1-6-2 10 3 [2 6 7])
  ;(solver1-6-3 3 10 [1 3 5])
  ;(solver1-6-4 3 9 [1 3 5])
  ;(solver2-1-1)
  ;(solver2-1-2 4 [1 2 4 7] 13)
  ;(solver2-1-3 10 12 ["W........WW."
  ;                    ".WWW.....WWW"
  ;                    "....WW...WW."
  ;                    ".........WW."
  ;                    ".........W.."
  ;                    "..W......W.."
  ;                    ".W.W.....WW."
  ;                    "W.W.W.....W."
  ;                    ".W.W......W."
  ;                    "..W.......W."])
  ;(solver2-1-4 10 10 [
  ;                    "#S######.#"
  ;                    "......#..#"
  ;                    ".#.##.##.#"
  ;                    ".#........"
  ;                    "##.##.####"
  ;                    "....#....#"
  ;                    ".#######.#"
  ;                    "....#....."
  ;                    ".####.###."
  ;                    "....#...G#"])
  ;;
  )


