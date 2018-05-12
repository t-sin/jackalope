(in-package #:cl-user)
(defpackage #:jackalope-disassembler
  (:use #:cl)
  (:import-from #:jackalope-disassembler/disassembler/instructions
                #:disassemble-bytecode)
  (:import-from #:jackalope-disassembler/disassembler/formatter
                #:format-bytecode)
  (:export #:disassemble-bytecode
           #:format-bytecode))
(in-package #:jackalope-disassembler)
