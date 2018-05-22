(in-package #:cl-user)
(defpackage #:jackalope-classfile
  (:use #:cl)
  (:import-from #:jackalope-classfile/classfile/classfile
                #:make-classfile
                #:classfile-version
                #:classfile-constant-pool
                #:classfile-access-flags
                #:classfile-this
                #:classfile-super
                #:classfile-interfaces
                #:classfile-fields
                #:classfile-methods
                #:classfile-attributes)
  (:import-from #:jackalope-classfile/classfile/parser
                #:read-class-file)
  (:shadowing-import-from #:jackalope-classfile/classfile/accessor
                          #:find-attribute
                          #:find-field
                          #:find-method)
  (:export #:make-classfile
           #:classfile-version
           #:classfile-constant-pool
           #:classfile-access-flags
           #:classfile-this
           #:classfile-super
           #:classfile-interfaces
           #:classfile-fields
           #:classfile-methods
           #:classfile-attributes

           #:read-class-file

           #:find-attribute
           #:find-field
           #:find-methods))
(in-package #:jackalope-classfile)

