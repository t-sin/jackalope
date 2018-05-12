(in-package #:cl-user)
(defpackage #:jackalope-disassembler/disassembler/formatter
  (:use #:cl)
  (:export #:format-bytecode))
(in-package #:jackalope-disassembler/disassembler/formatter)


(defun format-bytecode (parsed-bytecodes)
  (format cl:*standard-output* "~s" parsed-bytecodes))
