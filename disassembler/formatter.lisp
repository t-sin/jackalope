(in-package #:cl-user)
(defpackage #:jackalope-disassembler/disassembler/formatter
  (:use #:cl)
  (:shadow #:format)
  (:export #:format))
(in-package #:jackalope-disassembler/disassembler/formatter)


(defun format (parsed-bytecodes)
  (format cl:*standard-output* "~s" parsed-bytecodes))
