(in-package #:hy-utils)

(defmacro values-reverse (&body body)
  `(values-list (nreverse (multiple-value-list (progn ,@body)))))
