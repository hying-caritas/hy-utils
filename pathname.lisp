(in-package :hy-utils)

(defun to-pathname (stuff)
  (etypecase stuff
    (pathname (translate-logical-pathname stuff))
    (string (uiop:parse-unix-namestring stuff))
    (keyword
     (ecase stuff
       (:home (user-homedir-pathname))
       (:root (uiop:parse-unix-namestring "/"))))))

(defun unix-path (base &rest components)
  (let ((path (to-pathname base)))
    (iter (for comp :in components)
	  (setf path (uiop:subpathname* path (to-pathname comp))))
    path))

(defun unix-path-as-directory (base &rest components)
  (uiop:ensure-directory-pathname (apply #'unix-path base components)))

(defun unix-path-string (base &rest components)
  (uiop:unix-namestring (apply #'unix-path base components)))
