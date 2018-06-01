(in-package #:cl-user)
(defpackage #:jackalope-classfile/classfile/accessor
  (:use #:cl)
  (:shadow #:find-method)
  (:import-from #:jackalope-classfile/classfile/classfile
                #:attribute-name
                #:method-name)
  (:export #:find-attribute
           #:find-field
           #:find-method))
(in-package #:jackalope-classfile/classfile/accessor)


(defun find-attribute (name attributes)
  (find name attributes
        :test #'string=
        :key #'attribute-name))

(defun find-field (name attributes))

(defun find-method (name methods)
  (find name methods
        :test #'string=
        :key #'(lambda (m) (method-name m))))
