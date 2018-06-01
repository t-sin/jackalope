(in-package #:cl-user)
(defpackage #:jackalope-disassemble/disassemble/format
  (:use #:cl)
  (:shadowing-import-from #:jackalope-classfile
                          #:code-code
                          #:method-access-flags
                          #:method-name
                          #:method-descriptor
                          #:method-attributes
                          #:find-attribute)
  (:shadowing-import-from #:jackalope-disassemble/disassemble/instructions
                          #:+opcode-spec+
                          #:disassemble)
  (:export #:format-bytecode
           #:format-methods))
(in-package #:jackalope-disassemble/disassemble/format)


(defun format-bytecode (parsed-bytecodes)
  (loop
    :for bytecode :in parsed-bytecodes
    :do (format cl:*standard-output* "        ~a" (symbol-name (car bytecode)))
    :do (loop
          :for byte :in (cdr bytecode)
          :do (format cl:*standard-output* " ~s" byte)
          :finally (format cl:*standard-output* "~%"))))

(defun format-method (method)
  (format cl:*standard-output* ".~a~%" (method-name method))
  (format cl:*standard-output* "  ~a~%" (method-descriptor method))
  (format cl:*standard-output* "  ~{~a~^ ~}~%" (method-access-flags method))
  (format-bytecode (disassemble (code-code (find-attribute "Code" (method-attributes method))))))

(defun format-classfile (classfile)
  )
