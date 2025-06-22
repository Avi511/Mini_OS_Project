; -------------------------------
; MiniOS Bootloader - by Avishka
; -------------------------------
ORG 0x7C00
BITS 16

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Load kernel from second sector (LBA 1) to 0x1000
    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0x00
    mov bx, 0x1000
    int 0x13

    jc disk_error
    jmp 0x0000:0x1000

disk_error:
    mov si, disk_error_msg
.print:
    lodsb
    cmp al, 0
    je $
    mov ah, 0x0E
    int 0x10
    jmp .print

disk_error_msg db 'Disk read error!', 0

times 510 - ($ - $$) db 0
dw 0xAA55
