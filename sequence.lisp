(in-package :hy-utils)

(defun strip-suffix-subseq (suffix sequence &key (test #'eql))
  (if (ends-with-subseq suffix sequence :test test)
      (subseq sequence 0 (- (length sequence) (length suffix)))
      sequence))

(declaim (inline subseq-displaced))
(defun subseq-displaced (sequence start &optional end)
  (if (typep sequence 'array)
      (make-array (- (or end (length sequence)) start) :element-type (array-element-type sequence)
		  :displaced-to sequence :displaced-index-offset start
		  :adjustable nil)
      (subseq sequence start end)))

(defun search-replace (type sequence1 sequence2 sequence3
		       &key count from-end test key
			 (start1 0) (start2 0) (start3 0)
			 (end1 (length sequence1)) (end2 (length sequence2)) end3)
  (let ((result-list nil)
	(real-length2 (- end2 start2))
	(real-sequence3 (subseq-displaced sequence3 start3 end3))
	(search-arguments (list :from-end from-end :start1 start2 :end1 end2)))
    (when test
      (push test search-arguments)
      (push :test search-arguments))
    (when key
      (push key search-arguments)
      (push :key search-arguments))
    (iter (for n :upfrom 1)
	  (for pos := (apply #'search sequence2 sequence1
			     :start2 start1 :end2 end1 search-arguments))
	  (while pos)
	  (for send := (+ pos real-length2))
	  (if from-end
	      (progn
		(when (< send end1)
		  (push (subseq-displaced sequence1 send end1) result-list))
		(setf end1 pos))
	      (progn
		(when (< start1 pos)
		  (push (subseq-displaced sequence1 start1 pos) result-list))
		(setf start1 send)))
	  (push real-sequence3 result-list)
	  (when (and count (>= n count))
	    (finish)))
    (when (< start1 end1)
      (push (subseq-displaced sequence1 start1 end1) result-list))
    (unless from-end
      (nreversef result-list))
    (apply #'concatenate type result-list)))
