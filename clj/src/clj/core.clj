(ns clj.core)

;; repl reloadp用
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
(require '[clj.q2-2-1 :refer [solver] :rename {solver solver2-2-1}])
(require '[clj.q2-2-2 :refer [solver] :rename {solver solver2-2-2}])
(require '[clj.q2-2-3 :refer [solver] :rename {solver solver2-2-3}])
(require '[clj.q2-2-4 :refer [solver] :rename {solver solver2-2-4}])
(require '[clj.q2-2-5 :refer [solver] :rename {solver solver2-2-5}])
(require '[clj.q2-3-1 :refer [solver] :rename {solver solver2-3-1}])
(require '[clj.q2-3-2 :refer [solver] :rename {solver solver2-3-2}])
(require '[clj.q2-3-3 :refer [solver] :rename {solver solver2-3-3}])
(require '[clj.q2-3-4 :refer [solver] :rename {solver solver2-3-4}])
(require '[clj.q2-3-5 :refer [solver] :rename {solver solver2-3-5}])
(require '[clj.q2-3-6 :refer [solver] :rename {solver solver2-3-6}])
(require '[clj.q2-3-7 :refer [solver] :rename {solver solver2-3-7}])
(require '[clj.q2-3-8 :refer [solver] :rename {solver solver2-3-8}])
(require '[clj.q2-3-9 :refer [solver] :rename {solver solver2-3-9}])
(require '[clj.q2-3-10 :refer [solver] :rename {solver solver2-3-10}])
(require '[clj.q2-3-11 :refer [solver] :rename {solver solver2-3-11}])
(require '[clj.q2-3-12 :refer [solver] :rename {solver solver2-3-12}])
(require '[clj.q2-3-15 :refer [solver] :rename {solver solver2-3-15}])
(require '[clj.lib.search :refer [binary-search lower-bound]])
(require '[clj.lib.matrix :refer [init dump deep-aget deep-aset deep-get deep-set deep-set!] :rename {init init-matrix}])

(defn -main
  []
  ;(lower-bound [10] 200 300)
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
  ;(solver2-2-1 [3 2 1 3 0 2] 620)
  ;(solver2-2-2 5 [1 2 4 6 8] [3 5 7 9 10])
  ;(solver2-2-3 6 "ACDBCB")
  ;(solver2-2-4 6 10 [1 7 15 20 30 50])
  ;(solver2-2-5 3 [8 5 8])
  ;(solver2-2-5 4 [8 5 9 10])
  ;(solver2-3-1 4 5 [2 1 3 2] [3 2 4 2])
  ;(solver2-3-2 4 5 [2 1 3 2] [3 2 4 2])
  ;(solver2-3-3 4 5 [2 1 3 2] [3 2 4 2])
  ;(solver2-3-4 4 4 "abcd" "becd")
  ;(solver2-3-5 4 5 [2 1 3 2] [3 2 4 2])
  ;(solver2-3-6 4 5 [2 1 3 2] [3 2 4 2])
  ;(solver2-3-7 4 5 [2 1 3 2] [3 2 4 2])
  ;(solver2-3-8 4 5 [2 1 3 2] [3 2 4 2])
  ;(solver2-3-9 4 5 [2 1 3 2] [3 2 4 2])
  ;(solver2-3-10 3 17 [3 5 8] [3 2 2])
  ;(solver2-3-11 3 17 [3 5 8] [3 2 2])
  ;(solver2-3-12 5 [4 2 3 1 5])
  (solver2-3-15 5 [4 2 3 1 5])
  ;;
  )


