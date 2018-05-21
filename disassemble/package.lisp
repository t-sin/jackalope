(in-package #:cl-user)
(defpackage #:jackalope-disassemble
  (:use #:cl)
  (:shadowing-import-from #:jackalope-disassemble/disassemble/instructions
                          #:disassemble)
  (:shadowing-import-from #:jackalope-disassemble/disassemble/formatter
                          #:format)
  (:export #:disassemble
           #:format))
(in-package #:jackalope-disassemble)
