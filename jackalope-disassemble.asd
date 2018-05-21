(defsystem :jackalope-disassemble
  :class :package-inferred-system
  :description "Jackalope bytecode disassembler"
  :version "0.1"
  :author "TANAKA Shinichi"
  :depends-on ("flexi-streams"
               "jackalope-disassemble/disassemble/package"))
