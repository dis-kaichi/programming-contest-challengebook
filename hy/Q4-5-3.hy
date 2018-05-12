#!/usr/bin/env hy

;; ----------------------------------------
;; Square Destroyer(v2)
;; ----------------------------------------

(import sys)
(import copy)

(setv +inf+ (. sys maxsize))

(defn int-to-bool [x]
  (if (zero? x)
    False
    True))

(defn convert-to-bools [xs-list]
  (setv result [])
  (for [xs xs-list]
    (.append result (list (map int-to-bool xs))))
  result)

;; とりあえず、下のような感じにすればいいようである
;; パラメータから以下の状態に変換する処理は、そのうち作るか？
(defn parameter1 []
  ;; Answer : 3
  (setv (, M S) (, 12 5))
  ;;            1 2 3 4 5
  (setv m (-> [[1 0 0 0 1] ; 1
               [0 1 0 0 1] ; 2
               [1 0 0 0 1] ; 3
               [1 1 0 0 0] ; 4
               [0 1 0 0 1] ; 5
               [1 0 1 0 0] ; 6
               [0 1 0 1 0] ; 7
               [0 0 1 0 1] ; 8
               [0 0 1 1 0] ; 9
               [0 0 0 1 1] ; 10
               [0 0 1 0 1] ; 11
               [0 0 0 1 1] ; 12
               ]
              convert-to-bools))
  (setv mmax [5 6 10 11 11]) ;; 0-indexに直す
  (, M S m mmax))

(defn parameter2 [] ;; 3x3 (Removes 12 17 23)
  ;; Answer : 3 
  (setv (, M S) (, 21 5))
  ;;            1 2 3 4 5 6 7 8 9 10 11 12 13 14
  (setv m (-> [[1 0 0 0 0 0 0 0 0  1  0  0  0  1] ; 1
               [0 1 0 0 0 0 0 0 0  1  1  0  0  1] ; 2
               [0 0 1 0 0 0 0 0 0  0  1  0  0  1] ; 3
               [1 0 0 0 0 0 0 0 0  1  0  0  0  1] ; 4
               [1 1 0 0 0 0 0 0 0  0  1  0  0  0] ; 5
               [0 1 1 0 0 0 0 0 0  1  0  0  0  0] ; 6
               [0 0 1 0 0 0 0 0 0  0  1  0  0  1] ; 7
               [1 0 0 1 0 0 0 0 0  0  0  1  0  0] ; 8
               [0 1 0 0 1 0 0 0 0  0  0  1  1  0] ; 9
               [0 0 1 0 0 1 0 0 0  0  0  0  1  0] ; 10
               [0 0 0 1 0 0 0 0 0  1  0  1  0  1] ; 11
               [0 0 0 0 0 0 0 0 0  0  0  0  0  0] ; 12
               [0 0 0 0 1 1 0 0 0  1  0  1  0  0] ; 13
               [0 0 0 0 0 1 0 0 0  0  1  0  1  1] ; 14
               [0 0 0 1 0 0 1 0 0  1  0  0  0  0] ; 15
               [0 0 0 0 1 0 0 1 0  1  1  0  0  0] ; 16
               [0 0 0 0 0 0 0 0 0  0  0  0  0  0] ; 17
               [0 0 0 0 0 0 1 0 0  0  0  1  0  1] ; 18
               [0 0 0 0 0 0 1 1 0  0  0  0  1  0] ; 19
               [0 0 0 0 0 0 0 1 1  0  0  1  0  0] ; 20
               [0 0 0 0 0 0 0 0 1  0  0  0  1  1] ; 21
               [0 0 0 0 0 0 1 0 0  0  0  1  0  1] ; 22
               [0 0 0 0 0 0 0 0 0  0  0  0  0  0] ; 23
               [0 0 0 0 0 0 0 0 1  0  0  0  1  1] ; 24
               ]
              convert-to-bools))
  (setv mmax [7, 8, 9, 14, 15, 13, 21, 19, 23, 15, 15, 21, 23, 23])
  (, M S m mmax))

(defn parameter3 [] ;; 3x3 No removes.
  ;; Answer : 6
  (setv (, M S) (, 24 14))
  ;;            1 2 3 4 5 6 7 8 9 10 11 12 13 14
  (setv m (-> [[1 0 0 0 0 0 0 0 0  1  0  0  0  1] ; 1
               [0 1 0 0 0 0 0 0 0  1  1  0  0  1] ; 2
               [0 0 1 0 0 0 0 0 0  0  1  0  0  1] ; 3
               [1 0 0 0 0 0 0 0 0  1  0  0  0  1] ; 4
               [1 1 0 0 0 0 0 0 0  0  1  0  0  0] ; 5
               [0 1 1 0 0 0 0 0 0  1  0  0  0  0] ; 6
               [0 0 1 0 0 0 0 0 0  0  1  0  0  1] ; 7
               [1 0 0 1 0 0 0 0 0  0  0  1  0  0] ; 8
               [0 1 0 0 1 0 0 0 0  0  0  1  1  0] ; 9
               [0 0 1 0 0 1 0 0 0  0  0  0  1  0] ; 10
               [0 0 0 1 0 0 0 0 0  1  0  1  0  1] ; 11
               [0 0 0 1 1 0 0 0 0  0  1  0  1  0] ; 12
               [0 0 0 0 1 1 0 0 0  1  0  1  0  0] ; 13
               [0 0 0 0 0 1 0 0 0  0  1  0  1  1] ; 14
               [0 0 0 1 0 0 1 0 0  1  0  0  0  0] ; 15
               [0 0 0 0 1 0 0 1 0  1  1  0  0  0] ; 16
               [0 0 0 0 0 1 0 0 1  0  1  0  0  0] ; 17
               [0 0 0 0 0 0 1 0 0  0  0  1  0  1] ; 18
               [0 0 0 0 0 0 1 1 0  0  0  0  1  0] ; 19
               [0 0 0 0 0 0 0 1 1  0  0  1  0  0] ; 20
               [0 0 0 0 0 0 0 0 1  0  0  0  1  1] ; 21
               [0 0 0 0 0 0 1 0 0  0  0  1  0  1] ; 22
               [0 0 0 0 0 0 0 1 0  0  0  1  1  1] ; 23
               [0 0 0 0 0 0 0 0 1  0  0  0  1  1] ; 24
               ]
              convert-to-bools))
  (setv mmax [7, 8, 9, 14, 15, 16, 21, 22, 23, 15, 16, 22, 23, 23])
  (, M S m mmax))

(defn dcopy [xs]
  (.deepcopy copy xs))

;; mmax[i] = 正方形iを壊せるマッチの番号の最大値
(setv *mmax* [])
;; m[i][j] == True : マッチiが正方形jに含まれる
(setv *match* [])

;; 見つけた解の最小値
(setv *min-res* +inf+)

;; pは今見ているマッチのID、numはそれまでに除いたマッチの本数
(defn dfs [p num M S state]
  (global *min-res*)
  ;; マッチをすべて見終わっていれば正方形はすべて壊されている
  (if (= p M)
    (do
      (setv *min-res* num)
      num)
    (if (>= num *min-res*)
      +inf+
      (do
        ;; マッチpを必ず除く場合は use == True
        ;; マッチpを必ず除かない場合は notuse == True
        (setv use False)
        (setv notuse True)
        (for [i (range S)]
          ;; マッチpで正方形iを壊せるので除いても良い
          (when (and (get state i)
                     (get *match* p i))
            (setv notuse False))

          ;; マッチpで正方形iを壊さないといけないので必ず除く
          (when (and (get state i)
                     (= (get *mmax* i) p))
            (setv use True)))

        (setv res +inf+)
        ;; マッチpを除かない場合
        (when (not use)
          (setv res (min res (dfs (inc p) num M S (dcopy state)))))

        ;; マッチpを除く場合
        (for [i (range S)]
          (when (get *match* p i)
            (assoc state i False)))

        (when (not notuse)
          (setv res (min res (dfs (inc p) (inc num) M S (dcopy state)))))
        res))))

(defn solve []
  (global *mmax*)
  (global *match*)
  ;; Parameters
  (setv (, M S m mmax) (parameter3))

  ;; Main
  (setv *mmax* mmax)
  (setv *match* m)
  ;; state[i] == True : 正方形iが残っている
  (setv state (* [True] S))
  (print (dfs 0 0 M S (dcopy state)))
  )

(defmain
  [&rest args]
  (solve))

