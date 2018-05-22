(in-package #:cl-user)
(defpackage #:jackalope
  (:nicknames #:jacka)
  (:use #:cl)
  (:shadowing-import-from #:jackalope-classfile
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
                          #:classfile-attributes

                          #:read-class-file)
  (:shadowing-import-from #:jackalope-disassemble
                          #:disassemble
                          #:format)
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
           #:classfile-attributes
           #:read-class-file

           #:disassemble
           #:format))
(in-package #:jackalope)
