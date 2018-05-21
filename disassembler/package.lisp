(in-package #:cl-user)
(defpackage #:jackalope-disassembler
  (:use #:cl)
  (:shadowing-import-from #:jackalope-disassembler/disassembler/instructions
                          #:disassemble)
  (:import-from #:jackalope-disassembler/disassembler/formatter
                #:format-bytecode)
  (:export #:disassemble
           #:format-bytecode))
(in-package #:jackalope-disassembler)
