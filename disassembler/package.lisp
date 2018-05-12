(in-package #:cl-user)
(defpackage #:jackalope-disassembler
  (:use #:cl)
  (:import-from #:jackalope-disassembler/disassembler/instructions
                #:disassemble-bytecodes)
  (:export #:disassemble-bytecodes))
(in-package #:jackalope-disassembler)
