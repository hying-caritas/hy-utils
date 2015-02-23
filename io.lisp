(in-package :hy-utils)

(defun read-stream-into-string (stream)
  (with-output-to-string (out)
    (copy-stream stream out)))

(defun read-stream-into-lines (stream)
  (iter (for line := (read-line stream nil nil nil))
	(while line)
	(collect line)))
