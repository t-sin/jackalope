(in-package #:cl-user)
(defpackage #:jackalope-classfile/classfile/classfile
  (:use #:cl)
  (:export #:make-classfile
           #:classfile-version
           #:classfile-constant-pool
           #:classfile-access-flags
           #:classfile-this
           #:classfile-super
           #:classfile-interfaces
           #:classfile-fields
           #:classfile-methods
           #:classfile-attributes))
(in-package #:jackalope-classfile/classfile/classfile)

(defstruct classfile
  version
  constant-pool
  access-flags
  this
  super
  interfaces
  fields
  methods
  attributes)
