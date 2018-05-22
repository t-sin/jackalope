(in-package #:cl-user)
(defpackage #:jackalope-disassemble/disassemble/formatter
  (:use #:cl)
  (:shadowing-import-from #:jackalope-classfile
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
(in-package #:jackalope-disassemble/disassemble/formatter)

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
  (format-bytecode (disassemble (getf (find-attribute "Code" (method-attributes method)) :code))))

(defun format-classfile (classfile)
  )
