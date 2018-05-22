(in-package #:cl-user)
(defpackage #:jackalope-disassemble
  (:use #:cl)
  (:shadowing-import-from #:jackalope-disassemble/disassemble/instructions
                          #:disassemble)
  (:import-from #:jackalope-disassemble/disassemble/formatter
                #:format-bytecode)
  (:export #:disassemble
           #:format-bytecode))
(in-package #:jackalope-disassemble)
