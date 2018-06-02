(ns clj.lib.queue)
;; ----------------------------------------
;; Queue
;; ----------------------------------------

(def +empty-queue+
  clojure.lang.PersistentQueue/EMPTY)

;; Queueの各操作について
;;   enqueue => conj
;;   dequeue => peek & pop
;;              atomを利用しない場合は、引数のQueueに対して
;;              破壊的操作ができないので、peekとpopで代用する
