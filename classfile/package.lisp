(in-package #:cl-user)
(defpackage #:jackalope-classfile
  (:use #:cl)
  (:shadowing-import-from #:jackalope-classfile/classfile/classfile
                          #:method
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
                          #:classfile-attributes)
  (:import-from #:jackalope-classfile/classfile/parser
                #:read-class-file)
  (:shadowing-import-from #:jackalope-classfile/classfile/accessor
                          #:find-attribute
                          #:find-field
                          #:find-method)
  (:export #:method
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
           #:classfile-attributes

           #:read-class-file

           #:find-attribute
           #:find-field
           #:find-method))
(in-package #:jackalope-classfile)

