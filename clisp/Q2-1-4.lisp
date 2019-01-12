
;; ----------------------------------------
;; 迷路の最短路
;; ----------------------------------------

(ql:quickload "asserts")
(ql:quickload "queue")

(defun parameter1 ()
  (let ((n 10)
        (m 10)
        (maze '("#S######.#"
                "......#..#"
                ".#.##.##.#"
                ".#........"
                "##.##.####"
                "....#....#"
                ".#######.#"
                "....#....."
                ".####.###."
                "....#...G#"
                 ))
        (answer 22))
    (values n m maze answer)))

(defstruct point (x nil) (y nil))
(defconstant +inf+ 100000000)
(defvar *maze* (make-hash-table :test #'equal))
(defparameter *dx* '(1 0 -1 0))
(defparameter *dy* '(0 1 0 -1))
(defvar *d* (make-hash-table :test #'equal))

(defun find-start-and-goal (n m)
  (let ((sx 0)
        (sy 0)
        (gx 0)
        (gy 0))
    (loop for key being each hash-key of *maze*
          using (hash-value value)
          do (cond ((char= value #\S)
                    (progn
                      (setf sx (first key))
                      (setf sy (second key))))
                   ((char= value #\G)
                    (progn
                      (setf gx (first key))
                      (setf gy (second key))))))
    (values sx sy gx gy)))

(defun clear-distance ()
  (setf *d* (make-hash-table :test #'equal)))

(defun set-distance (x y distance)
  (setf (gethash (list x y)  *d*) distance))

(defun get-distance (x y)
  (let ((distance (gethash (list x y) *d*)))
    (if (null distance)
        +inf+
        distance)))

(defun get-maze (x y)
  (gethash (list x y) *maze*))

(defun bfs (n m)
  (multiple-value-bind (sx sy gx gy) (find-start-and-goal n m)
    (let ((qs (queue:make-queue :buffer (make-array 1000))))
      (queue:enqueue qs (make-point :x sx :y sy))
      (set-distance sx sy 0)
      (loop
        (if (queue:qemptyp qs)
            (return nil)
            (let ((p (queue:dequeue qs)))
              (if (and (= gx (point-x p))
                       (= gy (point-y p)))
                  (return (get-distance gx gy))
                  (dotimes (i 4)
                    (let ((nx (+ (point-x p) (nth i *dx*)))
                          (ny (+ (point-y p) (nth i *dy*))))
                      (when (and (<= 0 nx)
                                 (< nx n)
                                 (<= 0 ny)
                                 (< ny m)
                                 (char/= #\# (get-maze nx ny))
                                 (= +inf+ (get-distance nx ny)))
                        (queue:enqueue qs (make-point :x nx :y ny))
                        (set-distance nx ny (1+ (get-distance (point-x p)
                                                              (point-y p))))))))))))))

(defun copy-to-global-maze (n m maze)
  (dotimes (i n)
    (let ((line (nth i maze)))
      (dotimes (j m)
        (setf (gethash (list i j) *maze*)
              (schar line j))))))

(defun solver (n m maze)
  (clear-distance)
  (copy-to-global-maze n m maze)
  (bfs n m))

(defun solve ()
  (multiple-value-bind (n m maze answer) (parameter1)
    (asserts:assert-solve answer (solver n m maze) "Test1")))

(defun main (&rest args)
  (solve))

(main)
