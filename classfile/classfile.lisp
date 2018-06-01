(in-package #:cl-user)
(defpackage #:jackalope-classfile/classfile/classfile
  (:use #:cl)
  (:shadow #:method
           #:make-method)
  (:export #:attribute
           #:attribute-name
           #:constant-value
           #:constant-value-index
           #:code
           #:code-max-stack
           #:code-max-locals
           #:code-code
           #:code-exception-table
           #:code-attrs
           #:stack-map-table
           #:stack-map-table-frame
           #:exception
           #:exception-table
           #:inner-class
           #:inner-class-classes
           #:enclosing-method
           #:enclosing-method-class-idx
           #:enclosing-method-method-idx
           #:synthetic
           #:signature
           #:signature-index
           #:source-file
           #:source-file-index
           #:source-debug-extension
           #:source-debug-extensions
           #:line-number-table
           #:line-number-table-table

           #:method
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

;;; attributes
(defclass attribute ()
  ((name :initarg :name :accessor attribute-name)))

(defclass constant-value (attribute)
  ((index :initarg :index :accessor constant-value-index)))

(defclass code (attribute)
  ((max-stack :initarg :max-stack :accessor code-max-stack)
   (max-locals :initarg :max-locals :accessor code-max-locals)
   (code :initarg :code :accessor code-code)
   (exception-table :initarg :exception-table :accessor code-exception-table)
   (attrs :initarg :attrs :accessor code-attrs)))

;; TODO: what...????? https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.7.4
(defclass stack-map-table (attribute)
  ((frames :initarg :frames :accessor stack-map-table-frames)))

(defclass exception (attribute)
  ((table :initarg :table :accessor exeptions-table)))

(defclass inner-class (attribute)
  ((classes :initarg :classes :accessor inner-class-classes)))

(defclass enclosing-method (attribute)
  ((class-idx :initarg :class-idx :accessor enclosing-method-class-idx)
   (method-idx :initarg :method-idx :accessor enclosing-method-method-idx)))

(defclass synthetic (attribute) ())

(defclass signature (attribute)
  ((index :initarg :index :accessor signature-index)))

(defclass source-file (attribute)
  ((index :initarg :index :accessor source-file-index)))

(defclass source-debug-extension (attribute)
  ((extentions :initarg :extentions :accessor source-debug-extensions)))

(defclass line-number-table (attribute)
  ((table :initarg :table :accessor line-number-table-table)))

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
