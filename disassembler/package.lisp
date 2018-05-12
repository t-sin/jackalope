(in-package #:cl-user)
(defpackage #:jackalope-disassembler
  (:use #:cl)
  (:export #:disassemble-bytecodes))
(in-package #:jackalope-disassembler)


;;; ((#xOPECODE :mnemonic ((:name1 :u1) (:name2 :u2) (:name3 :u4) ...))
;;;  ...)
(defvar +opcode-spec+
  '((#x32 :aaload ())
    (#x53 :aastore ())
    (#x01 :aconst_null ())
    (#x19 :aload ((:index :u1)))
    (#x2a :aload-0 ())
    (#x2b :aload-1 ())
    (#x2c :aload-2 ())
    (#x2d :aload-3 ())
    (#xbd :anewarray ((:indexbyte1 :u1) (:indexbyte2 :u1)))
    (#xb0 :areturn ())
    (#xbe :arraylength ())
    (#x3a :astore (:index :u1))
    (#x4b :astore-0 ())
    (#x4c :astore-1 ())
    (#x4d :astore-2 ())
    (#x4e :astore-3 ())
    (#xbf :athrow ())
    (#x33 :baload ())
    (#x54 :bastre ())
    (#x10 :bipush ((:byte :u1)))
    (#x34 :caload ())
    (#x55 :castore ())
    (#xc0 :checkcast ((:indexbyte1 :u1) (:indexbyte2 :u1)))
    (#x90 :d2f ())
    (#x8e :d2i ())
    (#x8f :d2l ())
    (#x63 :dadd ())
    (#x31 :daload ())
    (#x52 :dastore ())
    (#x98 :dcmpg ())
    (#x97 :dcmpl ())
    (#x0e :d-const-0 ())
    (#x0f :d-const-1 ())
    (#x6f :ddiv ())
    (#x18 :dload ((:index u1)))
    (#x26 :dload-0 ())
    (#x27 :dload-1 ())
    (#x28 :dload-2 ())
    (#x29 :dload-3 ())
    (#x6b :dmul ())
    (#x77 :dneg ())
    (#x73 :drem ())
    (#xaf :dreturn ())
    (#x39 :dstore ((:index :u1)))
    (#x47 :dstore-0 ())
    (#x48 :dstore-1 ())
    (#x49 :dstore-2 ())
    (#x4a :dstore-3 ())
    (#x67 :dsub ())
    (#x59 :dup ())
    (#x5a :dup-x1 ())
    (#x5b :dup-x2 ())
    (#x5c :dup2 ())
    (#x5d :dup2-x1 ())
    (#x5e :dup2-x2 ())
    (#x8d :f2d ())
    (#x8b :f2i ())
    (#x8c :f2l ())
    (#x62 :fadd ())
    (#x30 :faloat ())
    (#x51 :fastore ())
    (#x96 :fcmpg ())
    (#x95 :fcmpl ())
    (#x0b :fconst-0 ())
    (#x0c :fconst-1 ())
    (#x0d :fconst-2 ())
    (#x6e :fdiv ())
    (#x17 :fload ())
    (#x22 :float-0 ())
    (#x23 :float-1 ())
    (#x24 :float-2 ())
    (#x25 :float-3 ())
    (#x6a :fmul ())
    (#x76 :fneg ())
    (#x72 :frem ())
    (#xae :freturn ())
    (#x38 :fstore ((:index :u1)))
    (#x43 :fstore-0 ())
    (#x44 :fstore-1 ())
    (#x45 :fstore-2 ())
    (#x46 :fstore-3 ())
    (#x66 :fsub ())
    (#xb4 :getfield ((:indexbyte1 :u1) (:indexbyte2 :u1)))
    (#xb2 :getstatic ((:indexbyte1 :u1) (:indexbyte2 :u1)))
    (#xa7 :goto ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#xa7 :goto-w ((:branchbyte1 :u1) (:branchbyte2 :u1) (:branchbyte3 :u1) (:branchbyte4 :u1)))
    (#x91 :i2b ())
    (#x92 :i2c ())
    (#x87 :i2d ())
    (#x86 :i2f ())
    (#x85 :i2l ())
    (#x93 :i2s ())
    (#x60 :iadd ())
    (#x2e :iaload ())
    (#x7e :iand ())
    (#x4f :iastre ())
    (#x02 :iconst-m1 ())
    (#x03 :iconst-0 ())
    (#x04 :iconst-1 ())
    (#x05 :iconst-2 ())
    (#x06 :iconst-3 ())
    (#x07 :iconst-4 ())
    (#x08 :iconst-5 ())
    (#x6c :idiv ())
    (#xa5 :if-acmpeq ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#xa6 :if-acmpne ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#x9f :if-icmpeq ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#xa0 :if-icmpne ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#xa1 :if-icmplt ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#xa2 :if-icmpge ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#xa3 :if-icmpgt ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#xa4 :if-icmple ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#x99 :ifeq ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#x9a :ifne ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#x9b :iflt ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#x9c :ifge ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#x9d :ifgt ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#x9e :ifle ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#xc7 :ifnonnull ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#x84 :iinc ((:index :u1) (:const :i1)))
    (#x15 :iload ((:index :u1)))
    (#x26 :iload-0 ())
    (#x27 :iload-1 ())
    (#x28 :iload-2 ())
    (#x29 :iload-3 ())
    (#x68 :imul ())
    (#x74 :ineg ())
    (#xc1 :instanceof ((:indexbyte1 :u1) (:indexbyte1 :u1)))
    (#xba :invokedynamic ((:indexbyte1 :u1) (:indexbyte1 :u1) 0 0))
    (#xb9 :invokeinterface ((:indexbyte1 :u1) (:indexbyte1 :u1) (:count :u1) 0))
    (#xb7 :invokespecial ((:indexbyte1 :u1) (:indexbyte1 :u1)))
    (#xb8 :invokestatic ((:indexbyte1 :u1) (:indexbyte1 :u1)))
    (#xb6 :invokevirtual ((:indexbyte1 :u1) (:indexbyte1 :u1)))
    (#x80 :ior ())
    (#x70 :irem ())
    (#xac :ireturn ())
    (#x78 :ishl ())
    (#x7a :ishr ())
    (#x36 :istore ((:index :u1)))
    (#x3b :istore-0 ())
    (#x3c :istore-1 ())
    (#x3d :istore-2 ())
    (#x3e :istore-3 ())
    (#x64 :isub ())
    (#x7c :iushr ())
    (#x82 :ixor ())
    (#xa8 :jsr ((:branchbyte1 :u1) (:branchbyte2 :u1)))
    (#xa9 :jsr-w ((:branchbyte1 :u1) (:branchbyte2 :u1) (:branchbyte3 :u1) (:branchbyte4 :u1)))
    (#x8a :l2d ())
    (#x89 :l2f ())
    (#x88 :l2i ())
    (#x61 :ladd ())
    (#x2f :laload ())
    (#x7f :land ())
    (#x50 :lastore ())
    (#x94 :lcmp ())
    (#x09 :lconst-0 ())
    (#x0a :lconst-1 ())
    (#x12 :ldc ((:index :u1)))
    (#x13 :ldc-w ((:indexbyte1 :u1) (:indexbyte2 :u1)))
    (#x14 :ldc2-w ((:indexbyte1 :u1) (:indexbyte2 :u1) (:indexbyte3 :u1) (:indexbyte4 :u1)))
    (#x6d :ldiv ())
    (#x16 :lload ((:index :u1)))
    (#x1e :lload-0 ())
    (#x1f :lload-1 ())
    (#x20 :lload-2 ())
    (#x21 :lload-3 ())
    (#x69 :lmul ())
    (#x75 :lneg ())
    (#xab :lookupswitch ())  ; TODO: operands
    (#x81 :lor ())
    (#x71 :lrem ())
    (#xad :lreturn ())
    (#x79 :lshl ())
    (#x7b :lshr ())
    (#x37 :lstore ((:index :u1)))
    (#x3f :lstore-0 ())
    (#x40 :lstore-1 ())
    (#x41 :lstore-2 ())
    (#x42 :lstore-3 ())
    (#x65 :lsub ())
    (#x7d :lushr ())
    (#x83 :lxor ())
    (#xc2 :monitorenter ())
    (#xc3 :monitorexit ())
    (#xc5 :multianewarray ((:indexbyte1 :u1) (:indexbyte2 :u1) (:dimentions :u1)))
    (#xbb :new ((:indexbyte1 :u1) (:indexbyte2 :u1)))
    (#xbc :newarray ((:atype :u1)))
    (#x00 :nop ())
    (#x57 :pop ())
    (#x48 :pop2 ())
    (#xb5 :putfield ((:indexbyte1 :u1) (:indexbyte2 :u1)))
    (#xb3 :putstatic ((:indexbyte1 :u1) (:indexbyte2 :u1)))
    (#xa9 :ret ((:index :u1)))
    (#xb1 :return ())
    (#x35 :saload ())
    (#x56 :sastore ())
    (#x11 :sipush ((:byte1 :u1) (:byte2 :u1)))
    (#x5f :swap ())
    (#xaa :tableswitch ())  ; TODO: operands
    (#xc4 :wide ((:opcode :u1) (:indexbyte1 :u1) (:indexbyte2 :u1)))))


(defun read-opcode (stream)
  (let ((opcode (trivial-gray-streams:stream-read-byte stream)))
    (if (eq opcode :eof)
        :eof
        (destructuring-bind (opc mni operands)
            (find opcode +opcode-spec+ :test #'= :key #'first)
          (let ((ins (list mni)))
            (dolist (opr operands (nreverse ins))
              (cond ((eql opr 0) (push 0 ins))
                    ((eql (second opr) :u1)
                     (push (trivial-gray-streams:stream-read-byte stream) ins))
                    ((eql (second opr) :i1)
                     (push (trivial-gray-streams:stream-read-byte stream) ins))  ; TODO: treats as a signed byte
                    (t (error (format nil "(~s ~s ~s): invalid operand" opc mni operands))))))))))


(defun disassemble-bytecodes (bytecodes)
  (flex:with-input-from-sequence (stream bytecodes)
    (loop
      :for i := (read-opcode stream)
      :until (eq i :eof)
      :collect i)))