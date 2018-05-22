(in-package #:cl-user)
(defpackage #:jackalope-disassemble/disassemble/formatter
  (:use #:cl)
  (:import-from #:jackalope-disassemble/disassemble/instructions
                #:+opcode-spec+)
  (:export #:format-bytecode))
(in-package #:jackalope-disassemble/disassemble/formatter)

(defun format-bytecode (parsed-bytecodes)
  (loop
    :for bytecode :in parsed-bytecodes
    :do (format cl:*standard-output* "    ~s~%" bytecode)))
