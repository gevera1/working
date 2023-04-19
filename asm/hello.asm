section .text
  global _start

section .rodata
  msg: db "Hello, world!", 0xa
  msglen: equ $ - msg

section .text
_start:
  mov rax, 1
  mov rdi, 1
  mov rsi, msg
  mov rdx, msglen
  syscall

  mov rax, 60
  mov rdi, 0
  syscall
