; ================================================================
; MiniOS Kernel - by Avishka
; ================================================================

BITS 16
ORG 0x1000

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7E00

    call clear_screen
    call show_startup_msg

main_loop:
    call print_newline
    mov si, prompt_string
    call print_string

    mov di, command_buffer
    call read_string

    mov si, command_buffer
    mov di, info_cmd
    call string_compare
    je handle_info

    mov si, command_buffer
    mov di, help_cmd
    call string_compare
    je handle_help

    mov si, command_buffer
    mov di, clear_cmd
    call string_compare
    je handle_clear

    mov si, unknown_cmd
    call print_newline
    call print_string
    jmp main_loop

handle_info:
    call print_newline
    mov si, hw_info_msg
    call print_string
    call print_newline
    jmp main_loop

handle_help:
    call print_newline
    mov si, help_menu_string
    call print_string
    call print_newline
    jmp main_loop

handle_clear:
    call clear_screen
    call show_startup_msg
    jmp main_loop

; ----------------------------------------------------------------
; Show welcome + help
show_startup_msg:
    mov si, welcome_string
    call print_string
    call print_newline

    mov si, intro_string
    call print_string
    call print_newline

    mov si, help_menu_string
    call print_string
    call print_newline
    ret

; ----------------------------------------------------------------
; Print string
print_string:
    mov ah, 0Eh
.repeat:
    lodsb
    cmp al, 0
    je .done
    int 10h
    jmp .repeat
.done:
    ret

print_newline:
    push ax
    mov ah, 0Eh
    mov al, 0Dh
    int 10h
    mov al, 0Ah
    int 10h
    pop ax
    ret

; ----------------------------------------------------------------
; Read string from keyboard
read_string:
    pusha
    mov bx, di
.read_loop:
    mov ah, 00h
    int 16h
    cmp al, 0Dh
    je .done
    cmp al, 08h
    je .backspace
    mov [di], al
    mov ah, 0Eh
    int 10h
    inc di
    jmp .read_loop

.backspace:
    cmp di, bx
    je .read_loop
    dec di
    mov byte [di], 0
    mov ah, 0Eh
    mov al, 08h
    int 10h
    mov al, ' '
    int 10h
    mov al, 08h
    int 10h
    jmp .read_loop

.done:
    mov byte [di], 0
    popa
    ret

; ----------------------------------------------------------------
; String compare
string_compare:
    pusha
.loop:
    mov al, [si]
    mov ah, [di]
    cmp al, ah
    jne .notequal
    cmp al, 0
    je .equal
    inc si
    inc di
    jmp .loop
.notequal:
    popa
    clc
    ret
.equal:
    popa
    stc
    ret

; ----------------------------------------------------------------
; Clear screen
clear_screen:
    pusha
    mov ah, 0x00
    mov al, 0x03
    int 10h
    popa
    ret

; ----------------------------------------------------------------
; Strings and Buffers
welcome_string      db 'Welcome to MiniOS by Avishka!', 0
intro_string        db 'MiniOS is a simple OS with commands: info, help, clear', 0
prompt_string       db 'MiniOS >> ', 0
unknown_cmd         db 'Unknown command', 0
hw_info_msg         db 'MiniOS Kernel Version 1.0 - No real hardware info yet', 0

info_cmd            db 'info', 0
help_cmd            db 'help', 0
clear_cmd           db 'clear', 0

help_menu_string    db 'info - Hardware Info', 0Dh, 0Ah, 'clear - Clear screen', 0Dh, 0Ah, 'help - Show this menu', 0Dh, 0Ah, 0

command_buffer      times 64 db 0
