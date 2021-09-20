%ifndef PRINT_HEX
%define PRINT_HEX

; Print word in hexadicimal view
; Arguments:
; DX - word to print
print_hex:
    push DX
    push AX
    push CX
    mov CX, 4   ; word has 4 hex symbols
                ; so, iterate 4 times
   
print_hex_print_loop:
    mov AX, DX
    and AX, 0b1111000000000000 ; leave only last 4 bits
    shr AX, 12
    ; now AX has reminder from dividing by 16

    ; now we need to print AX(remainder) as hex symbol
    ; due to ASCII table '0' symbol is 0x30 and '9' is 0x39
    ; but 'A' is 0x41, 'F' is 0x46
    cmp AX, 9
    jg print_hex_symbol
    add AX, 0x30 ; convert number to ASCII symbol
    jmp print_hex_end_symbol
print_hex_symbol:
    add AX, 0x41 - 10 ; convert number to ASCII symbol
print_hex_end_symbol:
    mov AH, 0x0e ; int argument
    int 0x10 ; print symbol

    shl DX, 4 ; divide by 16*

    ; loop end
    dec CX
    jnz print_hex_print_loop

    pop CX
    pop AX
    pop DX
    ret

%endif