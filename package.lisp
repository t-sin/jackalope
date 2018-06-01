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

                          #:read-class-file

                          #:find-attribute
                          #:find-field
                          #:find-method)
  (:shadowing-import-from #:jackalope-disassemble
                          #:disassemble
                          #:format-bytecode
                          #:format-method)
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

           #:find-attribute
           #:find-field
           #:find-method

           #:disassemble
           #:format-bytecode
           #:format-method))
(in-package #:jackalope)
