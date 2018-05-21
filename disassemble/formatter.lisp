(in-package #:cl-user)
(defpackage #:jackalope-disassemble/disassemble/formatter
  (:use #:cl)
  (:shadow #:format)
  (:export #:format))
(in-package #:jackalope-disassemble/disassemble/formatter)


(defun format (parsed-bytecodes)
  (format cl:*standard-output* "~s" parsed-bytecodes))
