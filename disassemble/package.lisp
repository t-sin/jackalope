(in-package #:cl-user)
(defpackage #:jackalope-disassemble
  (:use #:cl)
  (:shadowing-import-from #:jackalope-disassemble/disassemble/instructions
                          #:disassemble)
  (:import-from #:jackalope-disassemble/disassemble/format
                #:format-bytecode
                #:format-method
                #:format-classfile)
  (:export #:disassemble
           #:format-bytecode
           #:format-method
           #:format-classfile))
(in-package #:jackalope-disassemble)
