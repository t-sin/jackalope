(in-package #:cl-user)
(defpackage #:jackalope-classfile/classfile/parser
  (:use #:cl)
  (:shadowing-import-from #:jackalope-classfile/classfile/classfile
                          #:make-method
                          #:make-classfile)
  (:import-from #:jackalope-classfile/classfile/reader
                #:read-u2
                #:read-u4
                #:to-integer)
  (:export #:read-class-file))
(in-package #:jackalope-classfile/classfile/parser)


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


;;; TODO: implements parser for all constants
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


;;; TODO: implements parser for all attributes
(defun read-attribute* (stream attr-name constant-pool)
  (cond ((string= attr-name "Code")
         (list :max-stack (to-integer (read-u2 stream))
               :max-locals (to-integer (read-u2 stream))
               :code (let* ((len (to-integer (read-u4 stream)))
                            (buf (make-array len :element-type '(unsigned-byte 8))))
                       (read-sequence buf stream)
                       buf)
               :exception-table (let ((et nil))
                                  (dotimes (n (to-integer (read-u2 stream)) (nreverse et))
                                    (push (list :start-pc (to-integer (read-u2 stream))
                                                :end-pc (to-integer (read-u2 stream))
                                                :handler-pc (to-integer (read-u2 stream))
                                                :catch-type (to-integer (read-u2 stream)))
                                          et)))
               :attributes (let ((attrs nil))
                             (dotimes (n (to-integer (read-u2 stream)) (nreverse attrs))
                               (push (read-attribute stream constant-pool) attrs)))))
        ((string= attr-name "SourceFile")
         (list :soucefile (nth (1- (to-integer (read-u2 stream))) constant-pool)))
        ((string= attr-name "LineNumberTable")
         (list :line-number-table
               (let ((lnt nil))
                 (dotimes (n (to-integer (read-u2 stream)) (nreverse lnt))
                   (push (list :start-pc (to-integer (read-u2 stream))
                               :end-pc (to-integer (read-u2 stream)))
                         lnt)))))
        (t (error (format nil "'~s' is not implemented or invalid attr." attr-name)))))

(defun read-attribute (stream constant-pool)
  (let* ((name-index (to-integer (read-u2 stream)))
         (attr-name (nth (1- name-index) constant-pool))
         (len (to-integer (read-u4 stream))))
    (if (eq (first attr-name) :utf8)
        (append (list :name (second attr-name) :length len)
                (read-attribute* stream (second attr-name) constant-pool))
        (error (format nil "'~s' invalid attribute!" attr-name)))))



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
    (make-method :access-flags acc
                 :name (nth (1- name-index) constant-pool)
                 :descriptor (nth (1- desc-index) constant-pool)
                 :attributes (nreverse attributes))))

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
      (make-classfile :version version
                      :constant-pool (coerce constants 'vector)
                      :access-flags (coerce (read-access-flags stream) 'vector)
                      :this (read-this/super-class stream constants)
                      :super (read-this/super-class stream constants)
                      :interfaces (coerce (read-interfaces stream) 'vector)
                      :fields (coerce (read-fields stream constants) 'vector)
                      :methods (coerce (read-methods stream constants) 'vector)
                      :attributes (let ((attr-count (to-integer (read-u2 stream)))
                                        (attrs nil))
                                    (dotimes (n attr-count (coerce (nreverse attrs) 'vector))
                                      (push (read-attribute stream constants) attrs)))))))
