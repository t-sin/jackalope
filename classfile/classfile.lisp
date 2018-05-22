(in-package #:cl-user)
(defpackage #:jackalope-classfile/classfile/classfile
  (:use #:cl)
  (:shadow #:method
           #:make-method)
  (:export #:method
           #:make-method
           #:method-access-flags
           #:method-name
           #:method-descriptor
           #:method-attributes

           #:classfile
           #:make-classfile
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

(defstruct method
  access-flags
  name
  descriptor
  attributes)

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
