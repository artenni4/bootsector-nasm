%ifndef PRINT_STRING
%define PRINT_STRING

; Print null-terminated strings
; values of registers are saved except SI
; Arguments:
; SI - beginning of the string
print_string:
    push AX ; save regs
    mov AH, 0x0e ; printing symbol (teletype)
print_string_continue:
    lodsb ; move byte from [SI] to AL and increment SI
    cmp AL, 0
    je print_string_exit ; exit if null in the end
    int 0x10 ; print symbol
    jmp print_string_continue
print_string_exit:
    pop AX ; restore regs
    ret

%endif