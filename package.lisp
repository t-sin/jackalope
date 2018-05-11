(in-package #:cl-user)
(defpackage #:jackalope
  (:use #:cl)
  (:import-from #:jackalope-class-parser
                #:read-class-file)
  (:export #:read-class-file))
(in-package #:jackalope)
