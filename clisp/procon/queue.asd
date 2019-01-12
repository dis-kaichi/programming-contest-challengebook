(in-package :cl-user)
(defpackage queue-asd
  (:use :cl :asdf))
(in-package :queue-asd)

(defsystem queue
  :description "Queue Library"
  :version "0.1"
  :author "xiezhi"
  :license ""
  :components ((:file "package")
               (:module "procon/lib"
                :components
                ((:file "queue")))))
