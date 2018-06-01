(in-package #:cl-user)
(defpackage #:jackalope-disassemble
  (:use #:cl)
  (:shadowing-import-from #:jackalope-disassemble/disassemble/instructions
                          #:disassemble)
  (:import-from #:jackalope-disassemble/disassemble/format
                #:format-bytecode
                #:format-method)
  (:export #:disassemble
           #:format-bytecode
           #:format-method))
(in-package #:jackalope-disassemble)
