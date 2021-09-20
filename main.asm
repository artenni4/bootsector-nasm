; Small program written if NASM for x86 systems that prints out values that is stored in registers
; Program should be written in bootsector (first 512 bytes of storage)
; Accessible registers for 16 bits
; 
; Author: Artenni
; artenni4@gmail.com
;
; General registers:
; AX, BX, CX, DX
; 
; Segment registers:
; CS, DS, ES, FS, GS, SS
;
; Index and Pointers:
; SI, DI, SP, BP, IP
;
; Sample output:
; AX: 0x00000000
; BX: 0x00000000
; ...


bits 16
org 0x7c00 ; initally BIOS throws us here..

; push all registers to store their initial value
push DI
push SI
push BP
push SP
push DX 
push CX
push BX 
push AX

mov CX, 8 ; set conter
mov SI, AX_label ; set first label to print
xor BX, BX
main_loop:
call print_string ; print string
push SI ; save SI
mov SI, hex_prefix ; set pointer to next label to print
call print_string
pop SI
pop DX ; get word to print
call print_hex ; print that word

; go to new line
call print_newline

;inc SI ; move to next lable (end of prev label is start of next)
dec CX
jnz main_loop 
hlt

print_newline:
    push AX
    push BX
    push CX
    push DX

    mov AH, 0x03
    int 0x10
    inc DH
    xor DL, DL
    mov AH, 0x02
    int 0x10

    pop DX
    pop CX
    pop BX
    pop AX
    ret

%include "print_string.asm"
%include "print_hex.asm"

hex_prefix db ": 0x", 0
AX_label db "AX", 0
BX_label db "BX", 0
CX_label db "CX", 0
DX_label db "DX", 0
SP_label db "SP", 0
BP_label db "BP", 0
SI_label db "SI", 0
DI_label db "DI", 0


times 510 - ($ - $$) db 0 ; fill rest of the segment with zeros
dw 0xaa55 ; last magic bytes for BIOS