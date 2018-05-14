(in-package #:cl-user)
(defpackage #:jackalope-class-parser/class-parser/classfile
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
(in-package #:jackalope-class-parser/class-parser/classfile)

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
