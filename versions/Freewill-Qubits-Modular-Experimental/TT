org 0x7C00

start:
    mov byte [0x1001], 0x69
    mov byte [0x1002], 0xFF     ; FREE_WILL
    mov byte [0x1003], 0xFF     ; DISCERN

    call freewill_qubits        ; Activate Qubits module

main_loop:
    inc byte [0x100E]

    call freewill_qubits        ; Keep calling the module every cycle

    jmp main_loop

; Include the Freewill-Qubits module here
; (the code above)

times 510-($-$$) db 0
dw 0xAA55
