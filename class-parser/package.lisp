(in-package #:cl-user)
(defpackage #:jackalope-class-parser
  (:use #:cl)
  (:import-from #:jackalope-class-parser/class-parser/parser
                #:read-class-file)
  (:export #:read-class-file))
(in-package #:jackalope-class-parser)

