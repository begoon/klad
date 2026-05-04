; Skeleton for a hand-edited RK86 disassembly. Use this as the
; pre-amble of <NAME>.asm; the linear disasm output goes after the
; equates block. Adjust `org` and prune unused equates.

        org  3000h              ; load address from tape header
        section main

; ----------------------------------------------------------------
; RK86 monitor ROM jump-table entries. Prune those not referenced.
start_rom       equ  0F800h     ; cold-start (no return)
getc            equ  0F803h     ; A = key code (blocks)
inpb            equ  0F806h     ; A = byte from tape
putc            equ  0F809h     ; print char in C
outb            equ  0F80Ch     ; write byte in C to tape
kbhit           equ  0F812h     ; A = key code or 00h
hexb            equ  0F815h     ; print A as 2 hex digits
puts            equ  0F818h     ; print 0-terminated string at HL
scan_kbd        equ  0F81Bh     ; A = FFh / FEh / code
getxy           equ  0F81Eh     ; HL = (y<<8) | x
curc            equ  0F821h     ; A = char under cursor
inpblock        equ  0F824h     ; read tape block (HL=offset, in/out: HL,DE,BC)
outblock        equ  0F827h     ; write tape block (in: HL=start, DE=end)
chksum          equ  0F82Ah     ; in: HL=start, DE=end ; out: BC
video           equ  0F82Dh     ; reinit CRT controller
getlim          equ  0F830h     ; HL = memory limit
setlim          equ  0F833h     ; set memory limit from HL
prompt_loop     equ  0F86Ch     ; jmp here = back to monitor prompt

; ----------------------------------------------------------------
; Monitor variables. Prune those not referenced.
cursor_addr     equ  7600h      ; 2 bytes
cursor_xy       equ  7602h      ; 2 bytes (Y,X)
ruslat_flag     equ  7606h      ; 00h = LAT, FFh = RUS
memory_limit    equ  7631h      ; 2 bytes

; ----------------------------------------------------------------
; <linear disasm body goes here>
