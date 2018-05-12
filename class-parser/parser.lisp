(in-package #:cl-user)
(defpackage #:jackalope-class-parser/class-parser/parser
  (:use #:cl)
  (:import-from #:jackalope-class-parser/class-parser/reader
                #:read-u2
                #:read-u4
                #:to-integer)
  (:export #:read-class-file))
(in-package #:jackalope-class-parser/class-parser/parser)


(defun read-magic (stream)
  (let ((bytes (read-u4 stream)))
    (values bytes (and (every (lambda (e) (typep e '(unsigned-byte 8))) bytes)
                       (loop
                         :for b1 :in bytes
                         :for b2 :in '(#xCA #xFE #xBA #xBE)
                         :always (= b1 b2))))))

(defun read-version (stream)
  (let ((minor-ver (to-integer (read-u2 stream)))
        (major-ver (to-integer (read-u2 stream))))
    (cons major-ver minor-ver)))


(defun read-constant (stream)
  (let ((tag (read-byte stream)))
    (ecase tag
      (7 (let ((name-index (to-integer (read-u2 stream))))
           (list :class name-index)))
      (9 (let ((class-index (to-integer (read-u2 stream)))
               (name-index (to-integer (read-u2 stream))))
           (list :field-ref class-index name-index)))
      (10 (let ((class-index (to-integer (read-u2 stream)))
                (name-index (to-integer (read-u2 stream))))
            (list :method-ref class-index name-index)))
      (11 (let ((class-index (to-integer (read-u2 stream)))
                (name-index (to-integer (read-u2 stream))))
            (list :interface-method-ref class-index name-index)))
      (8 (let ((str-index (to-integer (read-u2 stream))))
           (list :string str-index)))
      (3 (let ((num (to-integer (read-u4 stream))))
           (list :integer num)))
      (4 (let ((num (to-integer (read-u4 stream))))
           (list :float num)))
      (5 (let ((high (to-integer (read-u4 stream)))
               (low (to-integer (read-u4 stream))))
           (list :long high low)))
      (6 (let ((high (to-integer (read-u4 stream)))
               (low (to-integer (read-u4 stream))))
           (list :double high low)))
      (12 (let ((name-index (to-integer (read-u2 stream)))
                (discripter-index (to-integer (read-u2 stream))))
            (list :name-and-type name-index discripter-index)))
      (1 (let* ((len (to-integer (read-u2 stream)))
                (buf (make-array len :element-type '(unsigned-byte 8))))
           (read-sequence buf stream :end len)
           (list :utf8 (babel:octets-to-string buf :encoding :utf-8))))
      (15 :method-handle)
      (16 :medhot-type)
      (18 :invoke-dynamic))))

(defun read-constant-pool (stream)
  (let ((count (to-integer (read-u2 stream)))
        (constants nil))
    ;; entries of constant-pool are index like this: 0 < i < count
    (dotimes (n (1- count) (nreverse constants))
      (push (read-constant stream) constants))))

(defvar +access-flags+
  '((#x0001 . :public)
    (#x0010 . :final)
    (#x0020 . :super)
    (#x0200 . :interface)
    (#x0400 . :abstract)
    (#x1000 . :synthetic)
    (#x2000 . :annotation)
    (#x4000 . :enum)))

(defun read-access-flags (stream)
  (let ((flags (to-integer (read-u2 stream)))
        (flag-list))
    (dolist (f (mapcar #'car +access-flags+) (nreverse flag-list))
      (when (not (zerop (logand f flags)))
        (push (cdr (assoc f +access-flags+)) flag-list)))))

(defun read-this/super-class (stream constant-pool)
  (let ((index (to-integer (read-u2 stream))))
    (if constant-pool
        (list index (nth (1- index) constant-pool))
        index)))


(defun read-interface (stream)
  (to-integer (read-u2 stream)))

;;; interfaces implemented on `this` class
(defun read-interfaces (stream)
  (let ((count (to-integer (read-u2 stream)))
        (interfaces nil))
    (dotimes (n count (nreverse interfaces))
      (push (read-interface stream) interfaces))))


(defun read-attribute (stream constant-pool)
  (let ((name-index (to-integer (read-u2 stream)))
        (len (to-integer (read-u4 stream))))
    (let ((buffer (make-array len)))
      (read-sequence buffer stream)
      (list (if constant-pool
                (nth (1- name-index) constant-pool)
                name-index)
            buffer))))



(defun read-field (stream constant-pool)
  (let* ((acc (read-access-flags stream))
         (name-index (to-integer (read-u2 stream)))
         (desc-index (to-integer (read-u2 stream)))
         (attr-count (to-integer (read-u2 stream)))
         (attributes nil))
    (dotimes (n attr-count)
      (push (read-attribute stream constant-pool) attributes))
    (list acc
          (if constant-pool
              (nth (1- name-index) constant-pool)
              name-index)
          (if constant-pool
              (nth (1- desc-index) constant-pool)
              desc-index)
          (nreverse attributes))))

(defun read-fields (stream constant-pool)
  (let ((count (to-integer (read-u2 stream)))
        (fields nil))
    (dotimes (n count (nreverse fields))
      (push (read-field stream constant-pool) fields))))


(defun read-method (stream constant-pool)
  (let* ((acc (read-access-flags stream))
         (name-index (to-integer (read-u2 stream)))
         (desc-index (to-integer (read-u2 stream)))
         (attr-count (to-integer (read-u2 stream)))
         (attributes nil))
    (dotimes (n attr-count)
      (push (read-attribute stream constant-pool) attributes))
    (list acc
          (if constant-pool
              (nth (1- name-index) constant-pool)
              name-index)
          (if constant-pool
              (nth (1- desc-index) constant-pool)
              desc-index)
          (nreverse attributes))))

(defun read-methods (stream constant-pool)
  (let ((count (to-integer (read-u2 stream)))
        (methods nil))
    (dotimes (n count (nreverse methods))
      (push (read-method stream constant-pool) methods))))

(defun read-class-file (stream)
  (multiple-value-bind (magic correct?)
      (read-magic stream)
    (unless correct?
      (error "invalid magic!"))
    (let ((version (read-version stream))
          (constants (read-constant-pool stream)))
      (list :magic magic
            :version version
            :constant-pool constants
            :access-flags (read-access-flags stream)
            :this-class (read-this/super-class stream constants)
            :super-class (read-this/super-class stream constants)
            :interfaces (read-interfaces stream)
            :fields (read-fields stream constants)
            :methods (read-methods stream constants)
            :attributes (let ((attr-count (to-integer (read-u2 stream)))
                              (attrs nil))
                          (dotimes (n attr-count (nreverse attrs))
                            (push (read-attribute stream constants) attrs)))))))
