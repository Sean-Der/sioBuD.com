;;;; siobud.asd

(asdf:defsystem #:siobud
  :serial t
  :description "My Website hosted at sioBuD.com"
  :author "Sean DuBois <sean@siobud.com>"
  :license "MIT"
  :depends-on (#:swank
               #:hunchentoot
               #:cl-who)
  :components ((:file "package")
               (:file "template")
               (:file "siobud")))
