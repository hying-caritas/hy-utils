(in-package :hy-utils)

(define-constant +space-character-list+ '(#\Space #\Tab #\Linefeed #\Return #\Page) :test #'equal)

(defun join-strings (sep-in strings)
  (declare (type string-designator sep-in)
	   (type list strings))
  (let ((sep (string sep-in)))
   (if (null strings)
       nil
       (let* ((sep-len (length sep))
	      (result (make-string (+ (apply #'+ (mapcar #'length strings))
				      (* sep-len (1- (length strings)))))))
	 (replace result (car strings))
	 (iter (for pos :first (length (car strings))
		    :then (+ pos sep-len (length str)))
	       (for str :in (cdr strings))
	       (replace result sep :start1 pos)
	       (replace result str :start1 (+ pos sep-len)))
	 result))))
