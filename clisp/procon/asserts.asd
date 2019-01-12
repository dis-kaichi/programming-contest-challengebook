(in-package :cl-user)
(defpackage asserts-asd
  (:use :cl :asdf))
(in-package :asserts-asd)

(defsystem asserts
  :description "Assert Library"
  :version "0.1"
  :author "xiezhi"
  :license ""
  :components ((:file "package")
               (:module "procon/lib"
                :components
                ((:file "asserts")))))
