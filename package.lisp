(in-package #:cl-user)
(defpackage #:jackalope
  (:use #:cl)
  (:import-from #:jackalope-classfile
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
  (:shadowing-import-from #:jackalope-disassembler
                          #:disassemble
                          #:format-bytecode)
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

           #:disassemble
           #:format-bytecode))
(in-package #:jackalope)
