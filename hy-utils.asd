(defsystem #:hy-utils
  :version "0.1"
  :description "Huang Ying's Common Lisp Utilities"
  :depends-on (#:alexandria #:iterate #:uiop)
  :components
  ((:file "package")
   (:file "string" :depends-on ("package"))
   (:file "function" :depends-on ("package"))
   (:file "pathname" :depends-on ("package"))
   (:file "io" :depends-on ("package"))
   (:file "sequence" :depends-on ("package"))))
