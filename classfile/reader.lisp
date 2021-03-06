(in-package #:cl-user)
(defpackage #:jackalope-classfile/classfile/reader
  (:use #:cl)
  (:export #:read-u2
           #:read-u4
           #:to-integer))
(in-package #:jackalope-classfile/classfile/reader)


(defun read-u2 (stream)
  (let (bytes)
    (dotimes (n 2)
      (push (read-byte stream nil :eof) bytes))
    (nreverse bytes)))

(defun read-u4 (stream)
  (let (bytes)
    (dotimes (n 4)
      (push (read-byte stream nil :eof) bytes))
    (nreverse bytes)))

(defun to-integer (bytes)
  (let ((i 0))
    (dotimes (n (length bytes) i)
      (let ((offset (* n 8)))
        (setf (ldb (byte 8 offset) i) (nth (- (length bytes) n 1) bytes))))))
