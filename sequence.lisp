(in-package :hy-utils)

(defun strip-suffix-subseq (suffix sequence &key (test #'eql))
  (if (ends-with-subseq suffix sequence :test test)
      (subseq sequence 0 (- (length sequence) (length suffix)))
      sequence))
