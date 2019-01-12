(in-package :cl-user)
(defpackage search-asd
  (:use :cl :asdf))
(in-package :search-asd)

(defsystem search
  :description "Search Library"
  :version "0.1"
  :author "xiezhi"
  :license ""
  :components ((:file "package")
               (:module "procon/lib"
                :components
                ((:file "search")))))
