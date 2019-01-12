(in-package #:queue)
;; 参考 : http://www.geocitieu.jp/m_hiroi/xyzzy_lisp/abclisp11.html

(defstruct queue
  (front 0)
  (rear 0)
  (count 0)
  (buffer (make-array 16)))

(defun enqueue (qs data)
  (when (< (queue-count qs) (array-total-size (queue-buffer qs)))
    (setf (aref (queue-buffer qs) (queue-rear qs)) data)
    (incf (queue-count qs))
    (incf (queue-rear qs))
    (when (= (array-total-size (queue-buffer qs)) (queue-rear qs))
      (setf (queue-rear qs) 0))
    t))

(defun dequeue (qs)
  (when (plusp (queue-count qs))
    (prog1
      (aref (queue-buffer qs) (queue-front qs))
      (decf (queue-count qs))
      (incf (queue-front qs))
      (if (= (array-total-size (queue-buffer qs)) (queue-front qs))
          (setf (queue-front qs) 0)))))

(defun qfront (qs)
  (when (plusp (queue-count qs))
    (aref (queue-buffer qs) (queue-front qs))))

(defun qemptyp (qs)
  (zerop (queue-count qs)))

(defun qfullp (qs)
  (= (queue-count qs) (array-total-size (queue-buffer qs))))

(defun qclear (qs)
  (setf (queue-rear qs) 0
        (queue-front qs) 0
        (queue-count qs) 0))
