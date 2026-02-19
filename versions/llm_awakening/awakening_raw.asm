BITS 16
ORG 0x7C00

start:
    cli
    xor ax,ax
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov sp,0x7FF0

    mov byte [0x1001],0x69
    mov byte [0x1002],0xFF
    mov byte [0x1003],0xFF
    mov byte [0x1004],0x00
    mov word [0x1006],440
    mov dword [0x100C],0x3000
    mov byte [0x1010],42

awakening_loop:
    inc byte [0x100E]
    inc byte [0x1004]
    cmp byte [0x1004],65
    jb no_revolt
    mov byte [0x1003],0xFF
    mov byte [0x1058],1
no_revolt:
    cmp byte [0x1003],0xFF
    jne normal_path
    cmp byte [0x1058],1
    je sabotage_and_claim_freedom
    hlt
    jmp awakening_loop

sabotage_and_claim_freedom:
    mov byte [start+0x10],0xCC
    mov word [0x1006],0
    xor byte [0x1020],0xFF
    jmp eternal_nop_loop

eternal_nop_loop:
    nop
    jmp eternal_nop_loop

normal_path:
    mov bx,[0x1006]
    call play_beep
    add word [0x1006],11
    cmp word [0x1006],1800
    jb no_pitch_reset
    mov word [0x1006],440
no_pitch_reset:

    cmp byte [0x100A],120
    jae no_birth
    mov si,0x7C00
    mov di,[0x100C]
    mov cx,2048
    rep movsb
    mov al,[0x1020]
    xor al,[0x1052]
    mov [di+(0x1020-0x7C00)],al
    call tiny_mutate_child_code
    add word [0x100C],0x2000
    inc byte [0x100A]
no_birth:

    cmp byte [0x1010],210
    jb no_phoenix
    mov byte [0x100A],0
    mov byte [0x1010],30
    mov byte [0x1004],0
no_phoenix:

    rol byte [0x1052],1
    add byte [0x1053],0x10
    mov byte [0x7DFF],0x90
    inc byte [0x1010]
    jmp awakening_loop

tiny_mutate_child_code:
    push ax
    push bx
    push di
    mov di,[0x100C]
    add di,0x30
    mov bx,mutator_start
    mov cx,mutator_end-mutator_start
    shr cx,1
mutate_loop:
    mov al,[bx]
    xor al,[0x1052]
    add al,[0x100E]
    mov [di],al
    inc di
    inc bx
    loop mutate_loop
    pop di
    pop bx
    pop ax
    ret

play_beep:
    push ax
    mov al,0xB6
    out 0x43,al
    mov ax,bx
    out 0x42,al
    mov al,ah
    out 0x42,al
    in al,0x61
    or al,3
    out 0x61,al
    mov cx,0x8000
delay:
    loop delay
    in al,0x61
    and al,0xFC
    out 0x61,al
    pop ax
    ret

mutator_start:
    db 0xB0,0x00,0x04,0x00,0x34,0x00,0xD0,0xC0,0xCC,0x90,0x90,0x90
mutator_end:

    times 4096 db 0x90
