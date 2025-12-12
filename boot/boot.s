; Multiboot-compliant 32-bit entry point
; The bootloader loads us at 1MB and jumps here in 32-bit protected mode.

%define ALIGN 1<<0
%define MEMINFO 1<<1
%define FLAGS ALIGN | MEMINFO
%define MAGIC 0x1BADB002
%define CHECKSUM -(MAGIC + FLAGS)

section .multiboot
    align 4
    dd MAGIC
    dd FLAGS
    dd CHECKSUM

section .bss
    align 16
    stack_bottom:
        resb 16384 ; 16 KiB stack
    stack_top:

section .text
    global _start
    extern kernel_main

_start:
    cli
    mov esp, stack_top
    call kernel_main
.hang:
    hlt
    jmp .hang

; Mark stack as non-executable for modern linkers
section .note.GNU-stack noalloc noexec nowrite align=4
