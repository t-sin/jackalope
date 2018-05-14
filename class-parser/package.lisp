(in-package #:cl-user)
(defpackage #:jackalope-class-parser
  (:use #:cl)
  (:import-from #:jackalope-class-parser/class-parser/classfile
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
  (:import-from #:jackalope-class-parser/class-parser/parser
                #:read-class-file)
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

           #:read-class-file))
(in-package #:jackalope-class-parser)

