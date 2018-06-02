(ns clj.lib.matrix)

;(def *matrix* (make-array Long/TYPE 1000 1000))
(def ^:dynamic *matrix* (atom []))

;; value-type : Integer/TYPE
;;            : Long/TYPE
;;            : Double/TYPE
;(defn init [row col & {:keys [value-type] :or {value-type Integer/TYPE}}]
(defn init [row col value-type]
  (reset! *matrix* (make-array value-type row col)))

(defn create-matrix [row col value-type]
  (make-array value-type row col))

;; http://clj-me.cgrand.net/2009/10/15/multidim-arrays/
(defmacro deep-aget
  ([hint array idx]
   `(aget ~(vary-meta array assoc :tag hint) ~idx))
  ([hint array idx & idxs]
   `(let [a# (aget ~(vary-meta array assoc :tag 'objects) ~idx)]
      (deep-aget ~hint a# ~@idxs))))

(defmacro deep-aset [hint array & idxsv]
  (let [hints '{doubles double ints int} ; writing a comprehensive map is left as an exercise to the reader
              [v idx & sxdi] (reverse idxsv)
              idxs (reverse sxdi)
              v (if-let [h (hints hint)] (list h v) v)
              nested-array (if (seq idxs)
                             `(deep-aget ~'objects ~array ~@idxs)
                             array)
              a-sym (with-meta (gensym "a") {:tag hint})]
    `(let [~a-sym ~nested-array]
       (aset ~a-sym ~idx ~v))))

;; 取得に失敗したらdefaultを返す
(defn safe-get
  ([m x] (safe-get m x {}))
  ([m x default]
   (if (nil? (get m x))
     default
     (get m x))))

(defn deep-set [matrix x y v]
  (assoc matrix x (-> matrix (safe-get x) (assoc y v))))

(defn deep-get
  ([matrix x y] (deep-get matrix x y {}))
  ([matrix x y default]
   (-> matrix (safe-get x) (safe-get y default))))

(defn dump []
  (clojure.pprint/pprint *matrix*))
