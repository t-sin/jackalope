(in-package #:cl-user)
(defpackage #:jackalope-class-parser/class-parser/accessor
  (:use #:cl)
  (:export #:find-attribute
           #:find-field
           #:find-method*))
(in-package #:jackalope-class-parser/class-parser/accessor)


(defun find-attribute (name attributes)
  (find name attributes
        :test #'string=
        :key #'(lambda (a) (getf a :name))))

(defun find-field (name attributes))

(defun find-method* (name methods)
  (find name methods
        :test #'string=
        :key #'(lambda (m) (second (second m)))))
