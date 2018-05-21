(in-package #:cl-user)
(defpackage #:jackalope-disassembler
  (:use #:cl)
  (:shadowing-import-from #:jackalope-disassembler/disassembler/instructions
                          #:disassemble)
  (:shadowing-import-from #:jackalope-disassembler/disassembler/formatter
                          #:format)
  (:export #:disassemble
           #:format))
(in-package #:jackalope-disassembler)
