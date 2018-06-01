(in-package #:cl-user)
(defpackage #:jackalope-classfile
  (:use #:cl)
  (:shadowing-import-from #:jackalope-classfile/classfile/classfile
                          #:attribute
                          #:attribute-name
                          #:constant-value
                          #:constant-value-index
                          #:code
                          #:code-max-stack
                          #:code-max-locals
                          #:code-code
                          #:code-exception-table
                          #:code-attrs
                          #:stack-map-table
                          #:stack-map-table-frame
                          #:exception
                          #:exception-table
                          #:inner-class
                          #:inner-class-classes
                          #:enclosing-method
                          #:enclosing-method-class-idx
                          #:enclosing-method-method-idx
                          #:synthetic
                          #:signature
                          #:signature-index
                          #:source-file
                          #:source-file-index
                          #:source-debug-extension
                          #:source-debug-extensions
                          #:line-number-table
                          #:line-number-table-table

                          #:method
                          #:make-method
                          #:method-access-flags
                          #:method-name
                          #:method-descriptor
                          #:method-attributes

                          #:classfile
                          #:make-classfile
                          #:classfile-version
                          #:classfile-constant-pool
                          #:classfile-access-flags
                          #:classfile-this
                          #:classfile-super
                          #:classfile-interfaces
                          #:classfile-fields
                          #:classfile-methods
                          #:classfile-attributes)
  (:import-from #:jackalope-classfile/classfile/parser
                #:read-classfile)
  (:shadowing-import-from #:jackalope-classfile/classfile/accessor
                          #:find-attribute
                          #:find-field
                          #:find-method)
  (:export #:attribute
           #:attribute-name
           #:constant-value
           #:constant-value-index
           #:code
           #:code-max-stack
           #:code-max-locals
           #:code-code
           #:code-exception-table
           #:code-attrs
           #:stack-map-table
           #:stack-map-table-frame
           #:exception
           #:exception-table
           #:inner-class
           #:inner-class-classes
           #:enclosing-method
           #:enclosing-method-class-idx
           #:enclosing-method-method-idx
           #:synthetic
           #:signature
           #:signature-index
           #:source-file
           #:source-file-index
           #:source-debug-extension
           #:source-debug-extensions
           #:line-number-table
           #:line-number-table-table

           #:method
           #:make-method
           #:method-access-flags
           #:method-name
           #:method-descriptor
           #:method-attributes

           #:classfile
           #:make-classfile
           #:classfile-version
           #:classfile-constant-pool
           #:classfile-access-flags
           #:classfile-this
           #:classfile-super
           #:classfile-interfaces
           #:classfile-fields
           #:classfile-methods
           #:classfile-attributes

           #:read-classfile

           #:find-attribute
           #:find-field
           #:find-method))
(in-package #:jackalope-classfile)

