        org  0000h
        section KLAD.bin

; Monitor ROM jump-table entries used by this program.
start_rom       equ  0F800h
getc            equ  0F803h
putc            equ  0F809h
puts            equ  0F818h
scan_kbd        equ  0F81Bh

        lxi  sp, 00FFh
        jmp  game_init                  ; → loc_1605
        nop
        nop
loc_0008:
        ds   0DFh                       ; 0008-00E6 BSS
tbl_00E7:                               ; offset loc_00E7 (24 bytes referenced from elsewhere?)
        db   0FFh, 14h, 0Dh, 0C4h, 08h, 00h, 15h, 08h
        db   9Bh, 13h, 56h, 13h, 0CAh, 11h, 9Bh, 13h
        db   15h, 08h, 56h, 13h, 7Eh, 15h, 14h, 0Bh
        db   00h
loc_0100:
        mvi  c, 1Fh
        call putc
        lxi  h, 01D0h
        xra  a
        lda  0240h
        ral
        mov  e, a
        mvi  d, 00h
        dad  d
        mov  a, m
        sta  0241h
        inx  h
        mov  a, m
        sta  0242h
        lxi  h, 0243h
        shld 0883h
loc_0120:
        lhld 0241h
        mov  a, m
        ora  a
        rz
        call xlat_glyph
        sta  0885h
        inx  h
        mov  a, m
        sta  0886h
        inx  h
        mov  a, m
        sta  0887h
        inx  h
        mov  a, m
        sta  0888h
        inx  h
        mov  a, m
        sta  0889h
        inx  h
        shld 0241h
loc_0144:
        lda  0886h
        mov  b, a
        lda  0888h
        mov  c, a
        call coord_to_screen
        shld 088Ah
        lda  0886h
        mov  d, a
        lda  0887h
        sub  d
        sta  088Ch
        lda  0888h
        mov  d, a
        lda  0889h
        sub  d
        sta  088Dh
        lhld 088Ah
        xchg
        lda  0888h
        mov  c, a
        lda  0886h
        mov  b, a
loc_0174:
        lda  0885h
        stax d
        call plot_char
        inx  d
        inr  c
        lda  088Dh
        dcr  a
        sta  088Dh
        cpi  0FFh
        jnz  loc_0174
        lda  088Ch
        ora  a
        jz   loc_0120
        lda  0886h
        inr  a
        sta  0886h
        jmp  loc_0144

        db   1Bh, 59h, 00h, 00h          ; 019A-019D inline scratch
var_019E:
        db   09h, 00h                    ; 019E byte var (init 09), 019F pad

xlat_glyph:                             ; offset loc_01A0
        push psw
        push h
        push d
        mov  e, a
        mvi  d, 00h
        lxi  h, 01B2h
        dad  d
        mov  a, m
        sta  var_019E
        pop  d
        pop  h
        pop  psw
        ret

tbl_01B2:                               ; byte LUT for xlat_glyph (indexed by E, 30 entries)
        db   20h, 68h, 23h, 5Dh, 5Bh, 5Eh, 1Ch, 14h
        db   14h, 5Dh, 5Bh, 25h, 3Ah, 2Eh, 20h, 2Eh
        db   3Ah, 11h, 1Eh, 09h, 0Bh, 2Dh, 51h, 40h
        db   26h, 2Ah, 3Dh, 2Bh, 3Eh, 3Ch

tbl_01D0:                               ; 19 word pointers, indexed by level number*2
        dw   18B0h                          ; entry 0
        dw   0B35h                          ; entry 1
        dw   1987h                          ; entry 2
        dw   1ABFh                          ; entry 3
        dw   1BE0h                          ; entry 4
        dw   1DECh                          ; entry 5
        dw   1FD0h                          ; entry 6
        dw   21C8h                          ; entry 7
        dw   2267h                          ; entry 8
        dw   2473h                          ; entry 9
        dw   2600h                          ; entry 10
        dw   2810h                          ; entry 11
        dw   29D0h                          ; entry 12
        dw   2AB0h                          ; entry 13
        dw   2C40h                          ; entry 14
        dw   2D30h                          ; entry 15
        dw   2E50h                          ; entry 16
        dw   2FB0h                          ; entry 17
        dw   3250h                          ; entry 18

data_01F6:                              ; 01F6-0882 (zeroed at runtime by clear_bss, but tape ships non-zero values)
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 78h, 19h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 01h, 01h
        db   01h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh
        db   0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh
        db   0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 00h, 00h, 0Bh, 0Bh, 0Bh
        db   0Bh, 0Bh, 02h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh
        db   0Bh, 06h, 06h, 06h, 06h, 06h, 06h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh
        db   0Bh, 0Bh, 0Bh, 06h, 06h, 06h, 06h, 06h, 06h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh
        db   0Bh, 0Bh, 0Bh, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 0Bh, 0Bh, 02h, 02h, 0Bh, 0Bh, 0Bh, 0Bh, 00h, 00h, 00h, 00h, 00h, 00h, 0Bh
        db   0Bh, 02h, 02h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 06h, 06h, 06h, 06h, 06h
        db   06h, 06h, 06h, 06h, 06h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 02h
        db   02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h
        db   02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h
        db   02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 02h, 02h, 00h, 00h, 07h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 00h, 02h
        db   02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 02h, 02h, 00h, 00h, 0Bh, 0Bh, 02h, 02h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh
        db   0Bh, 0Bh, 0Bh, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh
        db   0Bh, 0Bh, 0Bh, 02h, 02h, 0Bh, 0Bh, 00h, 00h, 00h, 00h, 00h, 00h, 0Bh, 0Bh, 0Bh
        db   0Bh, 0Bh, 0Bh, 02h, 02h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 00h, 00h, 00h, 00h, 00h
        db   00h, 02h, 02h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 02h, 02h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 02h, 02h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h
        db   00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 00h, 00h, 00h, 00h, 0Bh, 0Bh, 0Bh, 0Bh, 02h, 02h, 0Bh, 0Bh, 0Bh
        db   0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 00h, 00h, 00h, 00h, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh
        db   0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 00h, 00h, 00h, 00h, 00h, 00h, 0Bh, 0Bh, 0Bh
        db   0Bh, 0Bh, 0Bh, 0Bh, 0Bh, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 05h
        db   05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h
        db   05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h
        db   05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 05h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
        db   01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

vars_0883:                              ; 0883-088D init values (not cleared)
        db   43h, 02h, 02h, 05h, 05h, 0Ah, 0Bh, 8Dh, 03h, 00h, 0FFh

clear_state:                            ; offset loc_088E
        lxi  h, 0243h
        lxi  d, 0882h
clear_state_loop:                       ; offset loc_0894
        xra  a
        mov  m, a
        inx  h
        mov  a, e
        sub  l
        mov  a, d
        sbb  h
        jnc  clear_state_loop
        ret
load_level_state:                       ; offset loc_089F
        lhld 0241h
        inx  h
        lxi  d, 08B1h
        mvi  b, 0Dh
loc_08A8:
        mov  a, m
        stax d
        inx  h
        inx  d
        dcr  b
        jnz  loc_08A8
        ret

        db   0Fh, 04h, 01h, 2Eh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 35h    ; 08B1-08BD filler

coord_to_screen:                               ; called from many places: maps (B,C) → screen address
        push psw
        push d
        mov  a, b
        cpi  18h
        jc   loc_08C8
        mvi  b, 18h
loc_08C8:
        mov  a, c
        cpi  3Fh
        jc   loc_08D0
        mvi  c, 3Fh
loc_08D0:
        xra  a
        lxi  d, 0000h
        mov  a, b
        rar
        mov  d, a
        mov  a, e
        rar
        mov  e, a
        mov  a, d
        rar
        mov  d, a
        mov  a, e
        rar
        add  c
        mov  e, a
        mov  a, d
        aci  00h
        lhld 0883h
        dad  d
        pop  d
        pop  psw
        ret
loc_08EB:
        lda  0AD4h
        mov  b, a
        lda  0AD5h
        mov  c, a
        call coord_to_screen
        mov  a, m
        cpi  02h
        jz   loc_0961
        inr  b
        call coord_to_screen
        mov  a, m
        ora  a
        jz   loc_0919
        cpi  07h
        jz   loc_0919
        cpi  08h
        jz   loc_0919
        cpi  05h
        jz   loc_0919
        cpi  0Eh
        jc   loc_0953
loc_0919:
        dcr  b
        call coord_to_screen
        mov  a, m
        call plot_char
        inr  b
        lda  0AD6h
        inr  a
        ani  03h
        jnz  loc_092C
        dcr  b
loc_092C:
        sta  0AD6h
        mov  a, b
        sta  0AD4h
        mvi  a, 13h
        call plot_char
        sta  0AD7h
        call coord_to_screen
        mov  a, m
        cpi  07h
        jnz  loc_0946
        mvi  m, 00h
loc_0946:
        cpi  08h
        rnz
        mvi  m, 12h
        lda  0AD9h
        inr  a
        sta  0AD9h
        ret
loc_0953:
        lda  0AD7h
        ora  a
        jz   loc_0960
        mov  a, m
        cpi  06h
        jz   loc_0919
loc_0960:
        dcr  b
loc_0961:
        xra  a
        sta  0AD7h
        lda  0AD8h
        cpi  08h
        jz   loc_097F
        cpi  18h
        jz   loc_09E3
        cpi  19h
        jz   loc_0A49
        cpi  1Ah
        jz   loc_0A94
        jmp  loc_0AD3
loc_097F:
        dcr  c
        call coord_to_screen
        mov  a, m
        ora  a
        jz   loc_09D0
        cpi  02h
        jz   loc_09D0
        cpi  06h
        jz   loc_09D0
        cpi  03h
        jnz  loc_099C
        mvi  m, 11h
        jmp  loc_09D0
loc_099C:
        cpi  05h
        jz   loc_09D0
        cpi  07h
        jnz  loc_09AB
        mvi  m, 00h
        jmp  loc_09D0
loc_09AB:
        cpi  08h
        jnz  loc_09B6
        call pickup_item
        jmp  loc_09D0
loc_09B6:
        cpi  09h
        jnz  loc_09CB
        lda  0AD9h
        ora  a
        jz   loc_0AD3
        dcr  a
        sta  0AD9h
        mvi  m, 11h
        jmp  loc_09D0
loc_09CB:
        cpi  0Eh
        jc   loc_0AD3
loc_09D0:
        inr  c
        call coord_to_screen
        mov  a, m
        call plot_char
        dcr  c
        mvi  a, 13h
        call plot_char
        mov  a, c
        sta  0AD5h
        ret
loc_09E3:
        inr  c
        call coord_to_screen
        mov  a, m
        ora  a
        jz   loc_0A34
        cpi  02h
        jz   loc_0A34
        cpi  06h
        jz   loc_0A34
        cpi  04h
        jnz  loc_0A00
        mvi  m, 11h
        jmp  loc_0A34
loc_0A00:
        cpi  05h
        jz   loc_0A34
        cpi  07h
        jnz  loc_0A0F
        mvi  m, 00h
        jmp  loc_0A34
loc_0A0F:
        cpi  08h
        jnz  loc_0A1A
        call pickup_item
        jmp  loc_0A34
loc_0A1A:
        cpi  0Ah
        jnz  loc_0A2F
        lda  0AD9h
        ora  a
        jz   loc_0AD3
        dcr  a
        sta  0AD9h
        mvi  m, 11h
        jmp  loc_0A34
loc_0A2F:
        cpi  0Eh
        jc   loc_0AD3
loc_0A34:
        dcr  c
        call coord_to_screen
        mov  a, m
        call plot_char
        inr  c
        mvi  a, 13h
        call plot_char
        mov  a, c
        sta  0AD5h
        jmp  loc_0AD3
loc_0A49:
        call coord_to_screen
        mov  a, m
        cpi  02h
        jnz  loc_0AD3
        dcr  b
        call coord_to_screen
        mov  a, m
        ora  a
        jz   loc_0A7F
        cpi  02h
        jz   loc_0A7F
        cpi  05h
        jz   loc_0A7F
        cpi  07h
        jnz  loc_0A6F
        mvi  m, 00h
        jmp  loc_0A7F
loc_0A6F:
        cpi  08h
        jnz  loc_0A7A
        call pickup_item
        jmp  loc_0A7F
loc_0A7A:
        cpi  0Eh
        jc   loc_0AD3
loc_0A7F:
        inr  b
        call coord_to_screen
        mov  a, m
        call plot_char
        dcr  b
        mvi  a, 13h
        call plot_char
        mov  a, b
        sta  0AD4h
        jmp  loc_0AD3
loc_0A94:
        inr  b
        call coord_to_screen
        mov  a, m
        ora  a
        jz   loc_0AC1
        cpi  02h
        jz   loc_0AC1
        cpi  05h
        jz   loc_0AC1
        cpi  07h
        jnz  loc_0AB1
        mvi  m, 00h
        jmp  loc_0AC1
loc_0AB1:
        cpi  08h
        jnz  loc_0ABC
        call pickup_item
        jmp  loc_0AC1
loc_0ABC:
        cpi  0Eh
        jc   loc_0AD3
loc_0AC1:
        dcr  b
        call coord_to_screen
        mov  a, m
        call plot_char
        inr  b
        mvi  a, 13h
        call plot_char
        mov  a, b
        sta  0AD4h
loc_0AD3:
        ret

var_0AD4:                               ; 0AD4-0AD9 game state vars
        db   15h, 08h                   ; 0AD4 player x, 0AD5 player y (init 15h,08h)
        db   01h, 00h                   ; 0AD6, 0AD7
        db   3Ah                        ; 0AD8 last key
        db   00h                        ; 0AD9 counter (reset by game_restart)

game_restart:                           ; offset loc_0ADA
        xra  a
        sta  0AD9h
        call clear_state
        call loc_0100
        call load_level_state
        lda  08B1h
        sta  0AD4h
        lda  08B2h
        sta  0AD5h
        call loc_1586
        call loc_1168
main_loop:                              ; offset loc_0AF9
        call scan_kbd
        sta  0AD8h
        call loc_08EB
        call loc_1039
        call loc_1181
        call loc_15A1
        call loc_1546
        call loc_1546
        call loc_15C7
        lda  var_11C3
        ora  a
        jnz  game_restart
        lda  0AD4h
        mov  b, a
        lda  0AD5h
        mov  c, a
        call coord_to_screen
        mov  a, m
        cpi  05h
        jz   game_restart
        mov  a, b
        cpi  18h
        jnc  game_restart
        jmp  main_loop

level_1:                                ; level 1 data, 5-byte records, 0x0B35-0x0E3C (775 bytes)
        db   01h, 01h, 16h, 00h, 01h, 01h, 16h, 16h, 00h, 3Fh, 01h, 01h, 14h, 03h, 03h, 01h
        db   01h, 16h, 1Eh, 1Fh, 05h, 16h, 16h, 0Ah, 17h, 0Bh, 01h, 01h, 04h, 1Dh, 02h, 12h
        db   15h, 09h, 09h, 0Bh, 14h, 14h, 0Ah, 13h, 01h, 17h, 17h, 00h, 3Fh, 06h, 14h, 14h
        db   0Eh, 0Eh, 06h, 14h, 14h, 12h, 12h, 06h, 12h, 12h, 08h, 08h, 0Bh, 12h, 12h, 0Ah
        db   14h, 06h, 12h, 12h, 0Eh, 0Eh, 06h, 12h, 12h, 12h, 12h, 0Bh, 10h, 10h, 08h, 0Dh
        db   06h, 10h, 10h, 0Eh, 0Eh, 02h, 0Eh, 0Fh, 09h, 09h, 0Bh, 0Eh, 0Eh, 04h, 08h, 06h
        db   0Eh, 0Eh, 05h, 06h, 02h, 03h, 0Dh, 04h, 04h, 07h, 10h, 10h, 04h, 04h, 07h, 12h
        db   12h, 04h, 04h, 0Bh, 11h, 11h, 04h, 05h, 0Bh, 13h, 13h, 04h, 06h, 0Bh, 0Ch, 0Ch
        db   07h, 11h, 06h, 0Ch, 0Ch, 0Ch, 0Ch, 07h, 0Bh, 0Bh, 11h, 11h, 0Bh, 0Ch, 0Ch, 13h
        db   16h, 07h, 0Bh, 0Bh, 13h, 13h, 02h, 0Ch, 11h, 0Fh, 0Fh, 0Bh, 09h, 09h, 06h, 0Eh
        db   06h, 09h, 09h, 0Ch, 0Ch, 0Bh, 0Ah, 0Ah, 0Eh, 15h, 07h, 09h, 09h, 11h, 11h, 02h
        db   03h, 0Bh, 09h, 09h, 0Bh, 03h, 05h, 05h, 06h, 0Bh, 05h, 05h, 08h, 08h, 06h, 05h
        db   05h, 07h, 07h, 0Bh, 04h, 04h, 0Ah, 1Dh, 0Bh, 03h, 03h, 0Ah, 0Bh, 06h, 04h, 04h
        db   0Ch, 0Ch, 0Bh, 03h, 03h, 14h, 18h, 02h, 03h, 03h, 13h, 13h, 06h, 04h, 04h, 19h
        db   19h, 02h, 04h, 06h, 0Eh, 0Eh, 08h, 06h, 06h, 0Dh, 0Dh, 0Bh, 07h, 07h, 0Dh, 15h
        db   0Bh, 08h, 08h, 15h, 17h, 02h, 06h, 07h, 16h, 16h, 02h, 08h, 0Eh, 18h, 18h, 0Bh
        db   0Fh, 0Fh, 10h, 18h, 0Bh, 0Eh, 0Eh, 13h, 15h, 06h, 0Fh, 0Fh, 12h, 12h, 06h, 0Fh
        db   0Fh, 16h, 16h, 02h, 01h, 0Dh, 1Ch, 1Ch, 0Ah, 05h, 05h, 18h, 18h, 0Bh, 06h, 06h
        db   17h, 1Ch, 06h, 09h, 09h, 19h, 1Bh, 0Bh, 0Eh, 0Eh, 1Ch, 1Ch, 02h, 0Eh, 12h, 1Bh
        db   1Bh, 0Bh, 11h, 11h, 17h, 19h, 0Bh, 13h, 13h, 16h, 1Bh, 02h, 11h, 15h, 18h, 18h
        db   0Bh, 11h, 15h, 1Dh, 1Dh, 07h, 10h, 10h, 1Dh, 1Dh, 0Bh, 11h, 11h, 1Ch, 1Ch, 07h
        db   14h, 14h, 1Ch, 1Ch, 0Bh, 15h, 15h, 1Bh, 1Ch, 0Bh, 16h, 16h, 22h, 3Dh, 05h, 16h
        db   16h, 38h, 3Ch, 01h, 01h, 16h, 3Eh, 3Fh, 01h, 01h, 01h, 31h, 3Dh, 01h, 01h, 01h
        db   22h, 2Eh, 01h, 01h, 14h, 21h, 21h, 02h, 03h, 15h, 22h, 22h, 01h, 11h, 12h, 23h
        db   32h, 05h, 11h, 11h, 26h, 31h, 01h, 0Fh, 10h, 32h, 32h, 06h, 0Fh, 0Fh, 31h, 31h
        db   0Bh, 0Fh, 0Fh, 2Ch, 30h, 0Bh, 0Fh, 0Fh, 24h, 2Ah, 06h, 0Fh, 0Fh, 25h, 27h, 02h
        db   09h, 0Eh, 24h, 24h, 0Bh, 09h, 09h, 25h, 25h, 06h, 09h, 09h, 26h, 26h, 0Bh, 03h
        db   05h, 23h, 25h, 07h, 04h, 04h, 24h, 24h, 06h, 04h, 04h, 26h, 27h, 07h, 06h, 06h
        db   25h, 25h, 0Bh, 07h, 07h, 25h, 25h, 01h, 0Dh, 0Dh, 26h, 30h, 06h, 0Dh, 0Dh, 28h
        db   28h, 06h, 0Dh, 0Dh, 2Ch, 2Ch, 02h, 06h, 0Ch, 30h, 30h, 01h, 06h, 0Bh, 2Fh, 2Fh
        db   06h, 06h, 06h, 2Ch, 2Eh, 01h, 08h, 08h, 2Dh, 2Dh, 02h, 08h, 0Ah, 2Eh, 2Eh, 0Bh
        db   0Bh, 0Bh, 27h, 2Eh, 06h, 0Bh, 0Bh, 28h, 28h, 06h, 0Bh, 0Bh, 2Ch, 2Ch, 0Bh, 02h
        db   02h, 27h, 28h, 01h, 02h, 08h, 29h, 29h, 0Bh, 03h, 05h, 29h, 29h, 06h, 05h, 05h
        db   27h, 28h, 02h, 03h, 08h, 2Ah, 2Ah, 0Bh, 09h, 09h, 29h, 2Bh, 06h, 09h, 09h, 2Ch
        db   2Ch, 0Bh, 03h, 04h, 2Bh, 2Bh, 01h, 02h, 03h, 2Ch, 2Ch, 08h, 02h, 02h, 2Bh, 2Bh
        db   07h, 03h, 03h, 2Dh, 2Dh, 06h, 04h, 04h, 2Dh, 2Eh, 0Bh, 03h, 04h, 2Fh, 31h, 0Bh
        db   04h, 04h, 33h, 35h, 0Bh, 05h, 05h, 33h, 34h, 0Bh, 06h, 06h, 34h, 3Bh, 06h, 06h
        db   06h, 36h, 36h, 0Ah, 05h, 05h, 37h, 37h, 0Bh, 02h, 02h, 34h, 38h, 0Bh, 03h, 03h
        db   38h, 3Dh, 0Bh, 04h, 04h, 37h, 38h, 02h, 03h, 05h, 39h, 39h, 02h, 01h, 02h, 3Ch
        db   3Ch, 02h, 03h, 08h, 32h, 32h, 06h, 08h, 08h, 33h, 3Ch, 02h, 05h, 15h, 3Dh, 3Dh
        db   06h, 14h, 14h, 37h, 3Ch, 0Bh, 14h, 14h, 24h, 35h, 01h, 15h, 15h, 2Ah, 2Ah, 02h
        db   14h, 14h, 2Bh, 2Bh, 0Bh, 13h, 13h, 34h, 34h, 01h, 11h, 12h, 34h, 34h, 07h, 10h
        db   10h, 34h, 34h, 0Bh, 0Ah, 0Eh, 34h, 37h, 0Bh, 0Ah, 0Ah, 32h, 33h, 0Bh, 0Ch, 0Dh
        db   33h, 33h, 06h, 0Ch, 0Ch, 32h, 32h, 07h, 0Bh, 0Bh, 33h, 33h, 01h, 0Bh, 0Bh, 35h
        db   35h, 01h, 0Eh, 0Eh, 35h, 35h, 0Bh, 0Ah, 0Ah, 38h, 38h, 01h, 0Ah, 0Bh, 39h, 3Bh
        db   05h, 0Ah, 0Ah, 3Ah, 3Ah, 06h, 0Ah, 0Ah, 3Ch, 3Ch, 06h, 0Eh, 0Eh, 38h, 38h, 0Bh
        db   0Ch, 0Fh, 39h, 3Bh, 07h, 0Dh, 0Dh, 3Ah, 3Ah, 0Bh, 10h, 10h, 3Ah, 3Bh, 07h, 11h
        db   11h, 3Bh, 3Bh, 0Bh, 10h, 10h, 38h, 38h, 0Bh, 11h, 11h, 38h, 39h, 0Bh, 12h, 12h
        db   38h, 3Bh, 02h, 0Ah, 15h, 36h, 36h, 00h

        db   01h, 02h, 01h, 30h, 01h, 2Fh, 02h, 1Ah, 00h, 00h, 03h, 01h, 3Ch    ; 0E3D-0E49 unused tail / filler

loc_0E4A:
        lda  0FAAh
        mov  b, a
        lda  0FABh
        mov  c, a
        call coord_to_screen
        mov  a, m
        cpi  02h
        jz   loc_0E9A
        inr  b
        call coord_to_screen
        mov  a, m
        ora  a
        jz   loc_0E8C
        cpi  05h
        jz   loc_0E8C
        cpi  07h
        jz   loc_0E8C
        cpi  08h
        jz   loc_0E8C
        cpi  0Eh
        jnc  loc_0E8C
        dcr  b
        lda  0FACh
        ora  a
        jz   loc_0E9A
        inr  b
        call coord_to_screen
        mov  a, m
        dcr  b
        cpi  06h
        jnz  loc_0E9A
        inr  b
loc_0E8C:
        mov  a, b
        sta  0FAEh
        mov  a, c
        sta  0FAFh
        mvi  a, 01h
        sta  0FACh
        ret
loc_0E9A:
        xra  a
        sta  0FACh
        lda  0AD4h
        mov  d, a
        lda  0AD5h
        mov  e, a
        cmp  c
        jnc  loc_0EEB
        dcr  c
        call coord_to_screen
        mov  a, m
        ora  a
        jz   loc_0ED5
        cpi  02h
        jz   loc_0ED5
        cpi  05h
        jz   loc_0ED5
        cpi  06h
        jz   loc_0ED5
        cpi  07h
        jz   loc_0ED5
        cpi  08h
        jz   loc_0ED5
        cpi  0Eh
        jnc  loc_0ED5
        inr  c
        jmp  loc_0EEB
loc_0ED5:
        lda  0FADh
        inr  a
        ani  03h
        sta  0FADh
        jnz  loc_0EE2
        inr  c
loc_0EE2:
        mov  a, b
        sta  0FAEh
        mov  a, c
        sta  0FAFh
        ret
loc_0EEB:
        mov  a, c
        cmp  e
        jnc  loc_0F2B
        inr  c
        call coord_to_screen
        mov  a, m
        ora  a
        jz   loc_0F1B
        cpi  02h
        jz   loc_0F1B
        cpi  06h
        jz   loc_0F1B
        cpi  05h
        jz   loc_0F1B
        cpi  07h
        jz   loc_0F1B
        cpi  08h
        jz   loc_0F1B
        cpi  0Eh
        jnc  loc_0F1B
        dcr  c
        jmp  loc_0F2B
loc_0F1B:
        lda  0FADh
        inr  a
        ani  03h
        sta  0FADh
        jnz  loc_0EE2
        dcr  c
        jmp  loc_0EE2
loc_0F2B:
        mov  a, d
        cmp  b
        jnc  loc_0F6F
        call coord_to_screen
        mov  a, m
        cpi  02h
        jnz  loc_0F6F
        dcr  b
        call coord_to_screen
        mov  a, m
        ora  a
        jz   loc_0F5F
        cpi  02h
        jz   loc_0F5F
        cpi  05h
        jz   loc_0F5F
        cpi  07h
        jz   loc_0F5F
        cpi  08h
        jz   loc_0F5F
        cpi  0Eh
        jnc  loc_0F5F
        inr  b
        jmp  loc_0F6F
loc_0F5F:
        lda  0FADh
        inr  a
        ani  03h
        sta  0FADh
        jnz  loc_0EE2
        inr  b
        jmp  loc_0EE2
loc_0F6F:
        mov  a, b
        cmp  d
        jnc  loc_0FA7
        inr  b
        call coord_to_screen
        mov  a, m
        ora  a
        jz   loc_0F9A
        cpi  02h
        jz   loc_0F9A
        cpi  05h
        jz   loc_0F9A
        cpi  07h
        jz   loc_0F9A
        cpi  08h
        jz   loc_0F9A
        cpi  0Eh
        jnc  loc_0F9A
        dcr  b
        jmp  loc_0FA7
loc_0F9A:
        lda  0FADh
        inr  a
        ani  03h
        sta  0FADh
        jnz  loc_0EE2
        dcr  b
loc_0FA7:
        jmp  loc_0EE2

actor_vars:                             ; 0FAA-0FBF actor/state vars used by routines below
        db   05h, 08h                   ; 0FAA-0FAB word var (player target?)
        db   00h, 02h                   ; 0FAC-0FAD bytes
        db   05h, 08h                   ; 0FAE-0FAF word var (player position)
        ; 0FB0-0FBF: 4 actor records, 4 bytes each (x, y, ?, ?)
        db   05h, 08h, 00h, 02h
        db   00h, 00h, 00h, 01h
        db   00h, 00h, 00h, 02h
        db   00h, 00h, 00h, 00h

loc_0FC0:
        lda  0FAEh
        mov  b, a
        lda  0FAFh
        mov  c, a
        lxi  h, 0FB0h
        mov  a, m
        sub  b
        mov  d, a
        inx  h
        mov  a, m
        sub  c
        inx  h
        ora  d
        jz   loc_0FFD
        inx  h
        inx  h
        mov  a, m
        sub  b
        mov  d, a
        inx  h
        mov  a, m
        sub  c
        inx  h
        ora  d
        jz   loc_0FFD
        inx  h
        inx  h
        mov  a, m
        sub  b
        mov  d, a
        inx  h
        mov  a, m
        sub  c
        inx  h
        ora  d
        jz   loc_0FFD
        inx  h
        inx  h
        mov  a, m
        sub  b
        mov  d, a
        inx  h
        mov  a, m
        sub  c
        ora  d
        jz   loc_0FFD
        ret
loc_0FFD:
        lhld 0FAAh
        shld 0FAEh
        ret
loc_1004:
        lda  0FAAh
        mov  b, a
        lda  0FABh
        mov  c, a
        call coord_to_screen
        mov  a, m
        call plot_char
        lda  0FAEh
        mov  b, a
        lda  0FAFh
        mov  c, a
        mvi  a, 14h
        call plot_char
        ret
loc_1021:
        lda  0FAEh
        mov  b, a
        lda  0FAFh
        mov  c, a
        call coord_to_screen
        mov  a, m
        cpi  05h
        jnz  loc_1037
        call plot_char
        xra  a
        ret
loc_1037:
        stc
        ret
loc_1039:
        lhld 0FB0h
        shld 0FAAh
        shld 0FAEh
        lhld 0FB2h
        shld 0FACh
        lda  1164h
        ora  a
        jz   loc_1056
        inr  a
        sta  1164h
        jmp  loc_107F
loc_1056:
        call 0E4Ah
        call loc_0FC0
        call loc_1004
        call loc_1021
        jc   loc_1073
        mvi  a, 0D0h
        sta  1164h
        lhld 08B3h
        shld 0FB0h
        jmp  loc_107F
loc_1073:
        lhld 0FAEh
        shld 0FB0h
        lhld 0FACh
        shld 0FB2h
loc_107F:
        lda  08BBh
        cpi  02h
        rc
        lhld 0FB4h
        shld 0FAAh
        shld 0FAEh
        lhld 0FB6h
        shld 0FACh
        lda  1165h
        ora  a
        jz   loc_10A2
        inr  a
        sta  1165h
        jmp  loc_10CB
loc_10A2:
        call 0E4Ah
        call loc_0FC0
        call loc_1004
        call loc_1021
        jc   loc_10BF
        mvi  a, 0D0h
        sta  1165h
        lhld 08B5h
        shld 0FB4h
        jmp  loc_10CB
loc_10BF:
        lhld 0FAEh
        shld 0FB4h
        lhld 0FACh
        shld 0FB6h
loc_10CB:
        lda  08BBh
        cpi  03h
        rc
        lhld 0FB8h
        shld 0FAAh
        shld 0FAEh
        lhld 0FBAh
        shld 0FACh
        lda  1166h
        ora  a
        jz   loc_10EE
        inr  a
        sta  1166h
        jmp  loc_1117
loc_10EE:
        call 0E4Ah
        call loc_0FC0
        call loc_1004
        call loc_1021
        jc   loc_110B
        mvi  a, 0D0h
        sta  1166h
        lhld 08B7h
        shld 0FB8h
        jmp  loc_1117
loc_110B:
        lhld 0FAEh
        shld 0FB8h
        lhld 0FACh
        shld 0FBAh
loc_1117:
        lda  08BBh
        cpi  04h
        rc
        lhld 0FBCh
        shld 0FAAh
        shld 0FAEh
        lhld 0FBEh
        shld 0FACh
        lda  1167h
        ora  a
        jz   loc_113A
        inr  a
        sta  1167h
        jmp  loc_1163
loc_113A:
        call 0E4Ah
        call loc_0FC0
        call loc_1004
        call loc_1021
        jc   loc_1157
        mvi  a, 0D0h
        sta  1167h
        lhld 08B9h
        shld 0FBCh
        jmp  loc_1163
loc_1157:
        lhld 0FAEh
        shld 0FBCh
        lhld 0FACh
        shld 0FBEh
loc_1163:
        ret

        ds   4                          ; 1164-1167 pad

loc_1168:
        lhld 08B3h
        shld 0FB0h
        lhld 08B5h
        shld 0FB4h
        lhld 08B7h
        shld 0FB8h
        lhld 08B9h
        shld 0FBCh
        ret
loc_1181:
        lhld 0AD4h
        xchg
        lhld 0FB0h
        mov  a, d
        sub  h
        jnz  loc_1192
        mov  a, e
        sub  l
        jz   loc_11BE
loc_1192:
        lhld 0FB4h
        mov  a, d
        sub  h
        jnz  loc_119F
        mov  a, e
        sub  l
        jz   loc_11BE
loc_119F:
        lhld 0FB8h
        mov  a, d
        sub  h
        jnz  loc_11AC
        mov  a, e
        sub  l
        jz   loc_11BE
loc_11AC:
        lhld 0FBCh
        mov  a, d
        sub  h
        jnz  loc_11B9
        mov  a, e
        sub  l
        jz   loc_11BE
loc_11B9:
        xra  a
loc_11BA:
        sta  var_11C3
        ret
loc_11BE:
        mvi  a, 01h
        jmp  loc_11BA

var_11C3:
        db   00h                        ; 1-byte var (initial 00), modified by sta var_11C3

plot_char:                              ; offset loc_11C4
        push psw
        push d
        push h
        call xlat_glyph
        lxi  h, 77BDh
        lxi  d, 004Eh
        mov  a, b
        inr  a
        cpi  1Ah
        jc   loc_11D9
        mvi  a, 19h
loc_11D9:
        dcr  a
        jz   loc_11E1
        dad  d
        jmp  loc_11D9
loc_11E1:
        mov  a, c
        cpi  40h
        jc   loc_11E9
        mvi  a, 3Fh
loc_11E9:
        mov  e, a
        dad  d
        lda  var_019E
        mov  m, a
        pop  h
        pop  d
        pop  psw
        ret
loc_11F3:
        push psw
        push d
        lxi  d, 0000h
        lxi  h, 120Fh
        xra  a
        lda  120Eh
        ral
        mov  e, a
        mov  a, d
        ral
        mov  d, a
        mov  a, e
        ral
        mov  e, a
        mov  a, d
        ral
        mov  d, a
        dad  d
        pop  d
        pop  psw
        ret

var_120E:
        db   64h                        ; var (init 64h, 100 dec)
        ds   0195h                      ; 120F-13A3 zero table (4-byte records, indexed by var_120E)

loc_13A4:
        xra  a
        sta  120Eh
loc_13A8:
        call loc_11F3
        mov  a, m
        ora  a
        jnz  loc_13C9
loc_13B0:
        lda  120Eh
        inr  a
        sta  120Eh
        cpi  64h
        jc   loc_13A8
        lda  0AD4h
        mov  b, a
        lda  0AD5h
        mov  c, a
        mvi  a, 13h
        jmp  plot_char
loc_13C9:
        inx  h
        mov  a, m
        dcr  a
        mov  b, a
        lda  13A3h
        ani  07h
        mov  a, b
        jz   loc_13D7
        inr  a
loc_13D7:
        mov  m, a
        ora  a
        jm   loc_1431
        jnz  loc_13F4
loc_13DF:
        xra  a
        mov  m, a
        dcx  h
        mov  m, a
        inx  h
        inx  h
        mov  b, m
        inx  h
        mov  c, m
        call coord_to_screen
        mvi  a, 0Bh
        mov  m, a
        call plot_char
        jmp  loc_13B0
loc_13F4:
        cpi  1Eh
        jnc  loc_1409
        inx  h
        mov  b, m
        inx  h
        mov  c, m
        call coord_to_screen
        mvi  a, 0Ch
        mov  m, a
        call plot_char
        jmp  loc_13B0
loc_1409:
        cpi  3Ch
        jnc  loc_141E
        inx  h
        mov  b, m
        inx  h
        mov  c, m
        call coord_to_screen
        mvi  a, 0Dh
        mov  m, a
        call plot_char
        jmp  loc_13B0
loc_141E:
        ori  80h
        mov  m, a
        inx  h
        mov  b, m
        inx  h
        mov  c, m
        call coord_to_screen
        mvi  a, 0Eh
        mov  m, a
        call plot_char
        jmp  loc_13B0
loc_1431:
        ani  7Fh
        jz   loc_13DF
        cpi  1Eh
        jnc  loc_144B
        inx  h
        mov  b, m
        inx  h
        mov  c, m
        call coord_to_screen
        mvi  a, 10h
        mov  m, a
        call plot_char
        jmp  loc_13B0
loc_144B:
        cpi  3Ch
        jnc  loc_141E
        inx  h
        mov  b, m
        inx  h
        mov  c, m
        call coord_to_screen
        mvi  a, 0Fh
        mov  m, a
        call plot_char
        jmp  loc_13B0
loc_1460:
        push psw
        push d
        push h
        xra  a
        sta  120Eh
loc_1467:
        call loc_11F3
        mov  a, m
        ora  a
        jnz  loc_1497
loc_146F:
        lda  120Eh
        inr  a
        sta  120Eh
        cpi  64h
        jc   loc_1467
        xra  a
        sta  120Eh
loc_147F:
        call loc_11F3
        mov  a, m
        ora  a
        jz   loc_14A7
        lda  120Eh
        inr  a
        sta  120Eh
        cpi  64h
        jc   loc_147F
loc_1493:
        pop  h
        pop  d
        pop  psw
        ret
loc_1497:
        inx  h
        inx  h
        mov  a, m
        cmp  b
        jnz  loc_146F
        inx  h
        mov  a, m
        cmp  c
        jnz  loc_146F
        jmp  loc_1493
loc_14A7:
        inr  a
        mov  m, a
        inx  h
        inx  h
        mov  m, b
        inx  h
        mov  m, c
        jmp  loc_1493
loc_14B1:
        lda  159Ch
        ora  a
        jnz  loc_14C0
        lda  159Bh
        ora  a
        jnz  loc_150B
        ret
loc_14C0:
        lhld 159Dh
        mov  c, h
        mov  b, l
        call coord_to_screen
        mov  a, m
        call plot_char
        dcr  c
        mov  h, c
        mov  l, b
        shld 159Dh
        call coord_to_screen
        mov  a, m
        cpi  01h
        jnz  loc_14E0
        xra  a
        sta  159Ch
        ret
loc_14E0:
        cpi  0Bh
        jz   loc_14F4
        cpi  0Ch
        jz   loc_14F4
        cpi  0Dh
        jz   loc_14F4
        mvi  a, 15h
        jmp  plot_char
loc_14F4:
        xra  a
        sta  159Ch
loc_14F8:
        call loc_1460
        call loc_11F3
        inx  h
        mov  a, m
        adi  1Eh
        cpi  3Bh
        jc   loc_1509
        mvi  a, 7Fh
loc_1509:
        mov  m, a
        ret
loc_150B:
        lhld 159Fh
        mov  c, h
        mov  b, l
        call coord_to_screen
        mov  a, m
        call plot_char
        inr  c
        mov  l, b
        mov  h, c
        shld 159Fh
        call coord_to_screen
        mov  a, m
        cpi  01h
        jnz  loc_152B
        xra  a
        sta  159Bh
        ret
loc_152B:
        cpi  0Bh
        jz   loc_153F
        cpi  0Ch
        jz   loc_153F
        cpi  0Dh
        jz   loc_153F
        mvi  a, 15h
        jmp  plot_char
loc_153F:
        xra  a
        sta  159Bh
        jmp  loc_14F8
loc_1546:
        lda  0AD8h
        cpi  5Eh
        jnz  loc_155F
        lda  159Bh
        ora  a
        jnz  loc_155F
        inr  a
        sta  159Bh
        lhld 0AD4h
        shld 159Fh
loc_155F:
        lda  0AD8h
        cpi  51h
        jnz  loc_1578
        lda  159Ch
        ora  a
        jnz  loc_1578
        inr  a
        sta  159Ch
        lhld 0AD4h
        shld 159Dh
loc_1578:
        call loc_14B1
        call loc_13A4
        lda  13A3h
        inr  a
        sta  13A3h
        ret
loc_1586:
        xra  a
        sta  159Bh
        sta  159Ch
        lxi  h, 120Fh
        mvi  b, 0C8h
loc_1592:
        mov  m, a
        inx  h
        mov  m, a
        inx  h
        dcr  b
        jnz  loc_1592
        ret

var_159B:                               ; 159B-15A0 inline scratch (variables zeroed by loc_1586)
        db   00h, 00h                   ; 159B, 159C bytes
        db   11h, 1Dh, 0Bh, 14h         ; 159D-15A0 misc

loc_15A1:
        lda  0AD8h
        cpi  30h
        jc   loc_15B7
        cpi  3Ah
        jnc  loc_15B7
        ani  0Fh
        rlc
        rlc
        rlc
        inr  a
        sta  15C6h
loc_15B7:
        lda  15C6h
        mov  b, a
loc_15BB:
        mvi  a, 0FFh
loc_15BD:
        dcr  a
        jnz  loc_15BD
        dcr  b
        jnz  loc_15BB
        ret
        dad  h
loc_15C7:
        lda  0AD8h
        cpi  2Eh
        jz   loc_15E6
        cpi  3Ah
        jz   start_rom
        lhld 0AD4h
        lda  08BCh
        cmp  l
        jnz  loc_15E5
        lda  08BDh
        cmp  h
        jz   loc_15E6
loc_15E5:
        ret
loc_15E6:
        lda  0240h
        inr  a
        sta  0240h
        lxi  h, 01D0h
        lxi  d, 0000h
        ral
        mov  e, a
        dad  d
        mov  a, m
        inx  h
        ora  m
        jnz  loc_15FF
        sta  0240h
loc_15FF:
        mvi  a, 01h
        sta  var_11C3
        ret
game_init:                              ; offset loc_1605 — program entry: banner, wait for key, restart
        lxi  b, game_restart            ; return target after getc
        push b
        lxi  h, str_intro
        call puts
        jmp  getc                       ; on return, pops game_restart off stack → game_restart

str_intro:                              ; offset 1612h, welcome / instructions screen (RU)
        db   1Fh, 1Bh, 59h, 22h, 36h, 17h, 20h, 20h, 17h, 20h, 20h, 20h, 17h, 17h, 17h, 20h
        db   20h, 20h, 17h, 17h, 17h, 20h, 20h, 20h, 17h, 17h, 17h, 1Bh, 59h, 23h, 36h, 17h
        db   20h, 17h, 20h, 20h, 20h, 17h, 20h, 20h, 17h, 20h, 20h, 17h, 20h, 20h, 17h, 20h
        db   20h, 17h, 20h, 20h, 17h, 1Bh, 59h, 24h, 36h, 17h, 17h, 20h, 20h, 20h, 20h, 17h
        db   20h, 20h, 17h, 20h, 20h, 17h, 20h, 20h, 17h, 20h, 20h, 17h, 20h, 20h, 17h, 1Bh
        db   59h, 25h, 36h, 17h, 20h, 17h, 20h, 20h, 20h, 17h, 20h, 20h, 17h, 20h, 20h, 17h
        db   17h, 17h, 17h, 20h, 20h, 17h, 20h, 20h, 17h, 1Bh, 59h, 26h, 36h, 17h, 20h, 20h
        db   17h, 20h, 20h, 17h, 20h, 20h, 17h, 20h, 20h, 17h, 20h, 20h, 17h, 20h, 17h, 17h
        db   17h, 17h, 17h, 17h, 1Bh, 59h, 28h, 3Ch, 72h, 69h, 67h, 61h, 20h, 2Ah, 20h, 31h
        db   39h, 38h, 37h, 1Bh, 59h, 29h, 3Ch, 77h, 65h, 72h, 73h, 69h, 71h, 20h, 20h, 31h
        db   2Eh, 34h, 1Bh, 59h, 2Ah, 36h, 61h, 77h, 74h, 6Fh, 72h, 20h, 70h, 75h, 6Ah, 73h
        db   69h, 73h, 2Dh, 70h, 75h, 6Ah, 7Bh, 65h, 20h, 7Ch, 2Eh, 69h, 2Eh, 1Bh, 59h, 2Ch
        db   2Dh, 77h, 61h, 7Bh, 61h, 20h, 7Ah, 61h, 64h, 61h, 7Eh, 61h, 20h, 73h, 6Fh, 73h
        db   74h, 6Fh, 69h, 74h, 20h, 77h, 20h, 74h, 6Fh, 6Dh, 20h, 7Eh, 74h, 6Fh, 62h, 79h
        db   20h, 70h, 72h, 6Fh, 6Ah, 74h, 69h, 1Bh, 59h, 2Dh, 2Ch, 6Ch, 61h, 62h, 69h, 72h
        db   69h, 6Eh, 74h, 79h, 2Ch, 6Eh, 61h, 68h, 6Fh, 64h, 71h, 20h, 70h, 6Fh, 20h, 64h
        db   6Fh, 72h, 6Fh, 67h, 65h, 20h, 6Bh, 6Ch, 61h, 64h, 2Dh, 1Eh, 2Ch, 73h, 70h, 72h
        db   71h, 74h, 61h, 6Eh, 2Dh, 1Bh, 59h, 2Eh, 2Ch, 6Eh, 79h, 6Ah, 20h, 77h, 20h, 73h
        db   75h, 6Eh, 64h, 75h, 6Bh, 65h, 2Dh, 14h, 2Eh, 1Bh, 59h, 2Fh, 2Dh, 6Eh, 65h, 6Fh
        db   62h, 68h, 6Fh, 64h, 69h, 6Dh, 6Fh, 20h, 74h, 61h, 6Bh, 76h, 65h, 20h, 6Fh, 73h
        db   74h, 65h, 72h, 65h, 67h, 61h, 74h, 78h, 73h, 71h, 20h, 6Ch, 60h, 64h, 6Fh, 65h
        db   64h, 6Fh, 77h, 2Dh, 0Bh, 2Ch, 1Bh, 59h, 30h, 2Ch, 69h, 20h, 6Eh, 65h, 20h, 75h
        db   74h, 6Fh, 6Eh, 75h, 74h, 78h, 20h, 77h, 20h, 77h, 6Fh, 64h, 65h, 2Dh, 5Eh, 5Eh
        db   5Eh, 2Eh, 1Bh, 59h, 31h, 2Dh, 73h, 74h, 65h, 6Eh, 79h, 2Ch, 73h, 64h, 65h, 6Ch
        db   61h, 6Eh, 6Eh, 79h, 65h, 20h, 69h, 7Ah, 20h, 64h, 65h, 72h, 65h, 77h, 61h, 2Dh
        db   25h, 2Ch, 6Dh, 6Fh, 76h, 6Eh, 6Fh, 20h, 6Ch, 6Fh, 6Dh, 61h, 74h, 78h, 1Bh, 59h
        db   32h, 2Ch, 70h, 72h, 69h, 20h, 70h, 6Fh, 6Dh, 6Fh, 7Dh, 69h, 20h, 6Bh, 6Ch, 61h
        db   77h, 69h, 7Bh, 20h, 22h, 51h, 22h, 20h, 69h, 20h, 22h, 5Eh, 22h, 1Bh, 59h, 33h
        db   2Dh, 77h, 79h, 20h, 69h, 7Ah, 6Fh, 62h, 72h, 61h, 76h, 61h, 65h, 74h, 65h, 73h
        db   78h, 2Dh, 09h, 2Ch, 20h, 62h, 65h, 74h, 6Fh, 6Eh, 6Eh, 79h, 65h, 20h, 73h, 74h
        db   65h, 6Eh, 79h, 2Dh, 58h, 1Bh, 59h, 34h, 2Ch, 64h, 77h, 65h, 72h, 69h, 2Dh, 5Dh
        db   20h, 69h, 20h, 5Bh, 2Ch, 20h, 6Dh, 6Fh, 73h, 74h, 69h, 6Bh, 69h, 2Dh, 20h, 1Ch
        db   2Ch, 20h, 6Ch, 65h, 73h, 74h, 6Eh, 69h, 63h, 79h, 2Dh, 23h, 2Eh, 1Bh, 59h, 35h
        db   2Dh, 75h, 70h, 72h, 61h, 77h, 6Ch, 71h, 74h, 78h, 20h, 73h, 77h, 6Fh, 69h, 6Dh
        db   20h, 64h, 77h, 69h, 76h, 65h, 6Eh, 69h, 65h, 6Dh, 20h, 77h, 79h, 20h, 6Dh, 6Fh
        db   76h, 65h, 74h, 65h, 20h, 70h, 72h, 69h, 1Bh, 59h, 36h, 2Ch, 70h, 6Fh, 6Dh, 6Fh
        db   7Dh, 69h, 20h, 6Bh, 6Ch, 61h, 77h, 69h, 7Bh, 20h, 75h, 70h, 72h, 61h, 77h, 6Ch
        db   65h, 6Eh, 69h, 71h, 20h, 6Bh, 75h, 72h, 73h, 6Fh, 72h, 6Fh, 6Dh, 2Ch, 69h, 7Ah
        db   6Dh, 65h, 6Eh, 71h, 74h, 78h, 1Bh, 59h, 37h, 2Ch, 73h, 6Bh, 6Fh, 72h, 6Fh, 73h
        db   74h, 78h, 20h, 6Bh, 6Ch, 61h, 77h, 69h, 7Bh, 61h, 6Dh, 69h, 20h, 22h, 30h, 2Dh
        db   39h, 22h, 2Eh, 00h

pickup_item:                            ; offset loc_1896
        lda  0AD9h
        inr  a
        sta  0AD9h
        mvi  m, 12h
        push b
        mvi  c, 07h
        call putc
        pop  b
        ret

        ds   9                          ; 18A7-18AF zero pad before level data

level_data:                             ; 0x18B0-0x334F: levels 0, 2-18 with inter-level filler
        ; --- level 0 (0x18B0) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 16h, 17h, 00h, 3Fh, 01h, 01h, 17h, 3Ch, 3Fh, 05h
        db   16h, 16h, 12h, 3Bh, 02h, 12h, 15h, 0Eh, 0Fh, 0Bh, 12h, 12h, 0Ah, 0Dh, 07h, 11h
        db   11h, 0Ah, 0Ah, 0Bh, 12h, 12h, 10h, 19h, 02h, 0Eh, 11h, 14h, 15h, 0Bh, 0Eh, 0Eh
        db   16h, 1Dh, 02h, 0Ah, 0Dh, 1Ch, 1Dh, 0Bh, 0Ah, 0Ah, 1Eh, 29h, 02h, 0Ah, 11h, 26h
        db   27h, 0Bh, 12h, 12h, 1Eh, 29h, 07h, 11h, 11h, 1Eh, 1Eh, 0Bh, 0Eh, 0Eh, 28h, 2Fh
        db   02h, 0Eh, 11h, 30h, 31h, 07h, 09h, 09h, 1Eh, 1Eh, 0Bh, 12h, 12h, 30h, 37h, 02h
        db   0Ah, 11h, 36h, 37h, 0Bh, 0Ah, 0Ah, 30h, 35h, 07h, 09h, 09h, 30h, 30h, 02h, 06h
        db   09h, 32h, 33h, 0Bh, 06h, 06h, 12h, 31h, 06h, 06h, 06h, 1Eh, 27h, 02h, 06h, 09h
        db   14h, 15h, 0Bh, 0Ah, 0Ah, 0Ah, 15h, 07h, 09h, 09h, 0Ah, 0Ah, 02h, 0Ah, 0Dh, 0Ch
        db   0Dh, 0Bh, 0Eh, 0Eh, 04h, 0Dh, 0Bh, 06h, 06h, 04h, 0Bh, 02h, 06h, 0Dh, 06h, 07h
        db   0Bh, 03h, 03h, 0Ch, 35h, 06h, 03h, 03h, 14h, 19h, 07h, 02h, 02h, 20h, 20h, 06h
        db   03h, 03h, 26h, 2Bh, 0Bh, 01h, 01h, 04h, 2Dh, 0Bh, 01h, 01h, 30h, 3Bh, 02h, 01h
        db   02h, 35h, 35h, 02h, 03h, 05h, 0Ah, 0Bh, 00h
        ; (gap 0x1979-0x1986)
        db   0Fh, 04h, 01h, 2Eh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 35h, 00h
        ; --- level 2 (0x1987) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 15h, 17h, 00h, 3Fh, 01h, 01h, 17h, 3Ah, 3Fh, 05h
        db   15h, 16h, 08h, 39h, 01h, 15h, 15h, 0Ch, 0Dh, 01h, 15h, 15h, 12h, 13h, 01h, 15h
        db   15h, 18h, 19h, 01h, 15h, 15h, 1Eh, 1Fh, 01h, 15h, 15h, 24h, 25h, 01h, 15h, 15h
        db   2Ah, 2Bh, 01h, 15h, 15h, 30h, 31h, 01h, 15h, 15h, 36h, 37h, 02h, 04h, 14h, 06h
        db   07h, 02h, 03h, 14h, 0Ch, 0Dh, 02h, 04h, 14h, 12h, 13h, 02h, 03h, 14h, 18h, 19h
        db   02h, 04h, 14h, 1Eh, 1Fh, 02h, 03h, 14h, 24h, 25h, 02h, 04h, 14h, 2Ah, 2Bh, 02h
        db   03h, 14h, 30h, 31h, 02h, 04h, 14h, 36h, 37h, 02h, 03h, 03h, 08h, 35h, 02h, 06h
        db   06h, 06h, 37h, 02h, 09h, 09h, 08h, 35h, 02h, 0Ch, 0Ch, 06h, 35h, 02h, 0Fh, 0Fh
        db   06h, 36h, 02h, 12h, 12h, 06h, 36h, 01h, 01h, 04h, 38h, 3Ah, 0Ah, 03h, 03h, 39h
        db   39h, 02h, 03h, 03h, 38h, 38h, 02h, 01h, 03h, 3Ah, 3Ah, 07h, 03h, 03h, 06h, 07h
        db   07h, 03h, 03h, 12h, 13h, 07h, 03h, 03h, 1Eh, 1Fh, 07h, 03h, 03h, 2Ah, 2Bh, 07h
        db   03h, 03h, 36h, 37h, 07h, 06h, 06h, 0Ch, 0Dh, 07h, 06h, 06h, 18h, 19h, 07h, 06h
        db   06h, 24h, 25h, 07h, 06h, 06h, 30h, 31h, 07h, 09h, 09h, 06h, 07h, 07h, 09h, 09h
        db   12h, 13h, 07h, 09h, 09h, 1Eh, 1Fh, 07h, 09h, 09h, 2Ah, 2Bh, 07h, 09h, 09h, 36h
        db   37h, 07h, 0Ch, 0Ch, 0Ch, 0Dh, 07h, 0Ch, 0Ch, 18h, 19h, 07h, 0Ch, 0Ch, 24h, 25h
        db   07h, 0Ch, 0Ch, 30h, 31h, 07h, 0Fh, 0Fh, 06h, 07h, 07h, 0Fh, 0Fh, 12h, 13h, 07h
        db   0Fh, 0Fh, 1Eh, 1Fh, 07h, 0Fh, 0Fh, 2Ah, 2Bh, 07h, 0Fh, 0Fh, 36h, 37h, 07h, 12h
        db   12h, 0Ch, 0Dh, 07h, 12h, 12h, 18h, 19h, 07h, 12h, 12h, 24h, 25h, 07h, 12h, 12h
        db   30h, 31h, 08h, 09h, 09h, 1Eh, 1Eh, 00h
        ; (gap 0x1AAF-0x1ABE)
        db   07h, 04h, 01h, 0Dh, 01h, 30h, 00h, 00h, 00h, 00h, 02h, 01h, 3Ah, 00h, 00h, 00h
        ; --- level 3 (0x1ABF) ---
        db   01h, 01h, 17h, 00h, 3Fh, 0Eh, 01h, 01h, 0Ah, 0Bh, 0Eh, 05h, 05h, 06h, 09h, 0Eh
        db   11h, 11h, 06h, 09h, 0Eh, 15h, 15h, 06h, 10h, 07h, 0Dh, 0Dh, 06h, 09h, 0Eh, 09h
        db   09h, 0Ch, 15h, 0Eh, 05h, 05h, 12h, 1Bh, 0Eh, 02h, 02h, 1Eh, 21h, 07h, 02h, 02h
        db   0Ch, 0Fh, 07h, 0Dh, 0Dh, 24h, 27h, 0Eh, 0Dh, 0Dh, 18h, 1Bh, 0Eh, 11h, 11h, 12h
        db   15h, 0Eh, 11h, 11h, 1Ah, 27h, 07h, 15h, 15h, 18h, 1Bh, 0Eh, 15h, 15h, 1Eh, 21h
        db   07h, 09h, 09h, 1Eh, 21h, 0Eh, 05h, 05h, 24h, 27h, 07h, 02h, 02h, 2Ah, 2Dh, 0Eh
        db   09h, 09h, 2Ah, 33h, 0Eh, 0Dh, 0Dh, 30h, 33h, 07h, 05h, 05h, 30h, 33h, 0Eh, 01h
        db   01h, 34h, 35h, 0Eh, 11h, 11h, 30h, 33h, 07h, 15h, 15h, 2Ah, 2Dh, 07h, 15h, 15h
        db   36h, 39h, 02h, 07h, 15h, 04h, 05h, 02h, 02h, 05h, 04h, 05h, 02h, 02h, 09h, 0Ah
        db   0Bh, 02h, 0Bh, 0Dh, 0Ah, 0Bh, 02h, 0Fh, 11h, 0Ah, 0Bh, 02h, 13h, 15h, 0Ah, 0Bh
        db   02h, 02h, 05h, 10h, 11h, 02h, 07h, 0Dh, 10h, 11h, 02h, 0Fh, 15h, 10h, 11h, 02h
        db   02h, 05h, 16h, 17h, 02h, 07h, 15h, 16h, 17h, 02h, 02h, 09h, 1Ch, 1Dh, 02h, 0Bh
        db   15h, 1Ch, 1Dh, 02h, 02h, 05h, 22h, 23h, 02h, 07h, 09h, 22h, 23h, 02h, 0Bh, 0Dh
        db   22h, 23h, 02h, 0Fh, 11h, 22h, 23h, 02h, 13h, 15h, 22h, 23h, 02h, 02h, 0Dh, 28h
        db   29h, 02h, 0Fh, 15h, 28h, 29h, 02h, 02h, 05h, 2Eh, 2Fh, 02h, 07h, 09h, 2Eh, 2Fh
        db   02h, 0Bh, 11h, 2Eh, 2Fh, 02h, 13h, 15h, 2Eh, 2Fh, 02h, 02h, 05h, 34h, 35h, 02h
        db   07h, 0Dh, 34h, 35h, 02h, 0Fh, 15h, 34h, 35h, 07h, 15h, 15h, 36h, 39h, 02h, 01h
        db   15h, 3Ah, 3Ah, 00h
        ; (gap 0x1BD3-0x1BDF)
        db   15h, 06h, 01h, 0Ah, 01h, 34h, 00h, 00h, 00h, 00h, 02h, 01h, 3Ah
        ; --- level 4 (0x1BE0) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 16h, 17h, 00h, 3Fh, 01h, 01h, 17h, 3Ah, 3Fh, 01h
        db   0Ah, 0Ah, 00h, 3Fh, 01h, 0Eh, 0Eh, 00h, 3Fh, 01h, 12h, 12h, 00h, 3Fh, 0Bh, 01h
        db   02h, 04h, 37h, 06h, 03h, 03h, 0Ch, 35h, 01h, 06h, 06h, 08h, 3Ah, 01h, 0Bh, 0Ch
        db   0Ah, 0Bh, 01h, 0Bh, 15h, 12h, 13h, 01h, 0Bh, 15h, 22h, 23h, 01h, 0Bh, 15h, 32h
        db   33h, 01h, 0Fh, 15h, 2Ah, 33h, 01h, 0Ah, 0Ch, 22h, 2Bh, 06h, 14h, 14h, 04h, 09h
        db   06h, 10h, 10h, 04h, 09h, 02h, 0Eh, 15h, 06h, 07h, 0Bh, 0Fh, 11h, 0Ah, 0Bh, 0Bh
        db   13h, 14h, 0Ah, 0Bh, 04h, 15h, 15h, 0Ah, 0Ah, 02h, 10h, 15h, 0Eh, 0Fh, 03h, 15h
        db   15h, 13h, 13h, 07h, 11h, 11h, 11h, 11h, 05h, 0Ah, 0Ah, 02h, 05h, 1Ah, 0Bh, 0Bh
        db   02h, 05h, 01h, 0Ch, 0Ch, 00h, 07h, 01h, 0Bh, 0Bh, 06h, 07h, 02h, 0Ah, 0Dh, 0Eh
        db   0Fh, 04h, 0Dh, 0Dh, 0Ah, 0Ah, 03h, 0Dh, 0Dh, 13h, 13h, 07h, 09h, 09h, 06h, 09h
        db   03h, 09h, 09h, 0Ah, 0Ah, 02h, 12h, 13h, 14h, 15h, 06h, 14h, 14h, 16h, 1Fh, 07h
        db   13h, 13h, 20h, 20h, 0Bh, 15h, 15h, 16h, 23h, 0Eh, 0Dh, 0Dh, 12h, 12h, 0Eh, 15h
        db   15h, 12h, 12h, 01h, 08h, 08h, 06h, 23h, 07h, 11h, 11h, 18h, 18h, 0Bh, 0Eh, 0Eh
        db   18h, 2Fh, 01h, 0Ch, 0Dh, 18h, 1Bh, 0Bh, 0Dh, 0Dh, 1Ah, 1Bh, 01h, 0Fh, 12h, 1Ah
        db   1Bh, 06h, 0Fh, 0Fh, 1Ch, 21h, 05h, 10h, 10h, 1Ch, 21h, 1Ah, 11h, 11h, 1Ch, 21h
        db   02h, 0Ah, 0Bh, 1Ah, 1Bh, 04h, 09h, 09h, 1Ah, 1Ah, 05h, 0Bh, 0Bh, 24h, 29h, 06h
        db   0Ah, 0Ah, 26h, 27h, 07h, 0Dh, 0Dh, 26h, 26h, 07h, 0Bh, 0Bh, 31h, 31h, 02h, 0Ch
        db   0Eh, 30h, 31h, 07h, 0Dh, 0Dh, 37h, 37h, 02h, 0Eh, 15h, 38h, 39h, 01h, 11h, 11h
        db   36h, 37h, 0Bh, 10h, 11h, 2Eh, 33h, 08h, 10h, 10h, 2Eh, 2Eh, 07h, 10h, 10h, 2Fh
        db   2Fh, 02h, 11h, 15h, 2Ch, 2Dh, 02h, 11h, 15h, 30h, 31h, 0Bh, 15h, 15h, 2Ah, 2Bh
        db   04h, 15h, 15h, 33h, 33h, 0Eh, 15h, 15h, 32h, 32h, 06h, 0Fh, 0Fh, 24h, 29h, 05h
        db   10h, 10h, 24h, 29h, 1Ah, 11h, 11h, 24h, 29h, 06h, 08h, 08h, 14h, 19h, 06h, 08h
        db   08h, 24h, 25h, 06h, 08h, 08h, 28h, 29h, 04h, 09h, 09h, 2Ah, 2Ah, 0Bh, 0Dh, 0Dh
        db   22h, 23h, 06h, 06h, 06h, 14h, 19h, 06h, 06h, 06h, 24h, 29h, 01h, 08h, 08h, 2Ah
        db   35h, 0Bh, 07h, 07h, 34h, 35h, 02h, 01h, 09h, 3Ah, 3Ah, 02h, 02h, 09h, 36h, 37h
        db   01h, 01h, 08h, 38h, 39h, 0Ah, 09h, 09h, 38h, 38h, 04h, 07h, 07h, 08h, 08h, 01h
        db   03h, 05h, 0Ah, 0Bh, 07h, 05h, 05h, 0Ch, 11h, 0Bh, 03h, 05h, 12h, 13h, 01h, 04h
        db   04h, 12h, 13h, 07h, 05h, 05h, 14h, 14h, 02h, 02h, 05h, 18h, 19h, 0Bh, 05h, 05h
        db   1Ah, 25h, 07h, 05h, 05h, 1Ch, 21h, 01h, 03h, 04h, 1Ah, 1Bh, 01h, 04h, 05h, 22h
        db   23h, 0Bh, 03h, 03h, 22h, 23h, 07h, 04h, 04h, 24h, 24h, 02h, 02h, 05h, 28h, 29h
        db   01h, 03h, 04h, 2Ah, 2Bh, 0Bh, 05h, 05h, 2Ah, 2Bh, 07h, 05h, 05h, 2Ch, 35h, 0Bh
        db   03h, 03h, 32h, 33h, 01h, 04h, 05h, 32h, 33h, 0Eh, 07h, 07h, 34h, 35h, 00h
        ; (gap 0x1DDF-0x1DEB)
        db   15h, 04h, 04h, 16h, 07h, 34h, 00h, 00h, 00h, 00h, 02h, 01h, 3Ah
        ; --- level 5 (0x1DEC) ---
        db   01h, 01h, 17h, 00h, 03h, 0Bh, 16h, 17h, 04h, 3Bh, 01h, 01h, 17h, 3Ch, 3Fh, 01h
        db   07h, 10h, 08h, 37h, 05h, 07h, 07h, 0Ch, 11h, 19h, 08h, 08h, 0Ah, 13h, 19h, 09h
        db   0Fh, 0Ah, 0Bh, 19h, 09h, 0Fh, 12h, 13h, 19h, 0Ch, 0Dh, 0Ah, 13h, 05h, 07h, 07h
        db   18h, 1Dh, 19h, 08h, 08h, 16h, 1Fh, 19h, 09h, 09h, 1Eh, 1Fh, 19h, 08h, 0Bh, 16h
        db   17h, 19h, 0Bh, 0Bh, 16h, 1Fh, 19h, 0Bh, 0Eh, 1Eh, 1Fh, 19h, 0Dh, 0Eh, 16h, 17h
        db   19h, 0Eh, 0Fh, 18h, 1Dh, 05h, 07h, 07h, 24h, 29h, 19h, 08h, 09h, 2Ah, 2Bh, 19h
        db   08h, 08h, 22h, 29h, 19h, 09h, 0Eh, 22h, 23h, 19h, 0Eh, 0Fh, 24h, 29h, 19h, 0Dh
        db   0Eh, 2Ah, 2Bh, 05h, 07h, 07h, 2Eh, 2Fh, 19h, 08h, 0Fh, 2Eh, 2Fh, 05h, 07h, 07h
        db   34h, 35h, 19h, 08h, 0Fh, 34h, 35h, 06h, 03h, 05h, 06h, 39h, 07h, 04h, 04h, 06h
        db   39h, 01h, 01h, 03h, 1Eh, 23h, 0Ah, 02h, 02h, 1Eh, 1Eh, 0Eh, 02h, 02h, 1Fh, 1Fh
        db   02h, 01h, 02h, 20h, 20h, 02h, 03h, 12h, 04h, 05h, 07h, 06h, 11h, 06h, 06h, 07h
        db   11h, 11h, 06h, 39h, 07h, 06h, 11h, 39h, 39h, 02h, 03h, 11h, 3Ah, 3Bh, 08h, 11h
        db   11h, 1Ah, 1Ah, 02h, 14h, 14h, 04h, 05h, 02h, 13h, 13h, 06h, 07h, 02h, 15h, 15h
        db   06h, 07h, 02h, 12h, 12h, 08h, 09h, 02h, 14h, 14h, 08h, 09h, 02h, 13h, 13h, 0Ah
        db   0Bh, 02h, 15h, 15h, 0Ah, 0Bh, 02h, 12h, 12h, 0Ch, 0Dh, 02h, 14h, 14h, 0Ch, 0Dh
        db   02h, 13h, 13h, 0Eh, 0Fh, 02h, 15h, 15h, 0Eh, 0Fh, 02h, 12h, 12h, 10h, 11h, 02h
        db   14h, 14h, 10h, 11h, 02h, 13h, 13h, 12h, 13h, 02h, 15h, 15h, 12h, 13h, 02h, 12h
        db   12h, 14h, 15h, 02h, 14h, 14h, 14h, 15h, 02h, 13h, 13h, 16h, 17h, 02h, 15h, 15h
        db   16h, 17h, 02h, 12h, 12h, 18h, 19h, 02h, 14h, 14h, 18h, 19h, 02h, 13h, 13h, 1Ah
        db   1Bh, 02h, 15h, 15h, 1Ah, 1Bh, 02h, 12h, 12h, 1Ch, 1Dh, 02h, 14h, 14h, 1Ch, 1Dh
        db   02h, 13h, 13h, 1Eh, 1Fh, 02h, 15h, 15h, 1Eh, 1Fh, 02h, 12h, 12h, 20h, 21h, 02h
        db   14h, 14h, 20h, 21h, 02h, 13h, 13h, 22h, 23h, 02h, 15h, 15h, 22h, 23h, 02h, 12h
        db   12h, 24h, 25h, 02h, 14h, 14h, 24h, 25h, 02h, 13h, 13h, 26h, 27h, 02h, 15h, 15h
        db   26h, 27h, 02h, 12h, 12h, 28h, 29h, 02h, 14h, 14h, 28h, 29h, 02h, 13h, 13h, 2Ah
        db   2Bh, 02h, 15h, 15h, 2Ah, 2Bh, 02h, 12h, 12h, 2Ch, 2Dh, 02h, 14h, 14h, 2Ch, 2Dh
        db   02h, 13h, 13h, 2Eh, 2Fh, 02h, 15h, 15h, 2Eh, 2Fh, 02h, 12h, 12h, 30h, 31h, 02h
        db   14h, 14h, 30h, 31h, 02h, 13h, 13h, 32h, 33h, 02h, 15h, 15h, 32h, 33h, 02h, 12h
        db   12h, 34h, 35h, 02h, 14h, 14h, 34h, 35h, 02h, 13h, 13h, 36h, 37h, 02h, 15h, 15h
        db   36h, 37h, 02h, 12h, 12h, 38h, 39h, 02h, 14h, 14h, 38h, 39h, 02h, 13h, 13h, 3Ah
        db   3Bh, 02h, 15h, 15h, 3Ah, 3Bh, 00h
        ; (gap 0x1FC3-0x1FCF)
        db   15h, 04h, 00h, 07h, 00h, 38h, 00h, 00h, 00h, 00h, 02h, 01h, 20h
        ; --- level 6 (0x1FD0) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 16h, 17h, 00h, 3Fh, 01h, 01h, 17h, 3Ch, 3Fh, 05h
        db   16h, 16h, 1Ch, 23h, 06h, 02h, 02h, 18h, 27h, 02h, 02h, 15h, 1Ah, 1Bh, 02h, 02h
        db   15h, 24h, 25h, 04h, 15h, 15h, 08h, 08h, 04h, 15h, 15h, 17h, 17h, 04h, 15h, 15h
        db   28h, 28h, 04h, 15h, 15h, 37h, 37h, 0Bh, 02h, 02h, 08h, 17h, 0Bh, 03h, 03h, 08h
        db   09h, 0Bh, 03h, 03h, 16h, 17h, 0Bh, 04h, 04h, 0Ah, 15h, 0Bh, 05h, 05h, 08h, 09h
        db   0Bh, 05h, 05h, 16h, 17h, 0Bh, 06h, 06h, 0Ah, 15h, 0Bh, 07h, 07h, 08h, 09h, 0Bh
        db   07h, 07h, 16h, 17h, 0Bh, 08h, 08h, 0Ah, 15h, 0Bh, 09h, 09h, 08h, 09h, 0Bh, 09h
        db   09h, 16h, 17h, 0Bh, 0Ah, 0Ah, 0Ah, 15h, 0Bh, 0Bh, 0Bh, 08h, 09h, 0Bh, 0Bh, 0Bh
        db   16h, 17h, 0Bh, 0Ch, 0Ch, 0Ah, 15h, 0Bh, 0Fh, 0Fh, 08h, 09h, 0Bh, 0Fh, 0Fh, 16h
        db   17h, 0Bh, 0Dh, 0Dh, 08h, 09h, 0Bh, 0Dh, 0Dh, 16h, 17h, 0Bh, 0Eh, 0Eh, 0Ah, 15h
        db   0Bh, 10h, 10h, 0Ah, 15h, 0Bh, 12h, 12h, 0Ah, 15h, 0Bh, 11h, 11h, 08h, 09h, 0Bh
        db   11h, 11h, 16h, 17h, 0Bh, 13h, 13h, 08h, 09h, 0Bh, 13h, 13h, 16h, 17h, 0Bh, 14h
        db   14h, 08h, 17h, 07h, 03h, 03h, 0Eh, 11h, 07h, 05h, 05h, 0Eh, 11h, 07h, 07h, 07h
        db   0Eh, 11h, 07h, 09h, 09h, 0Eh, 11h, 07h, 0Bh, 0Bh, 0Eh, 11h, 07h, 0Dh, 0Dh, 0Eh
        db   11h, 07h, 0Fh, 0Fh, 0Eh, 11h, 07h, 11h, 11h, 0Eh, 11h, 07h, 13h, 13h, 0Eh, 11h
        db   08h, 13h, 13h, 0Fh, 0Fh, 0Bh, 02h, 02h, 28h, 37h, 0Bh, 04h, 04h, 2Ah, 35h, 0Bh
        db   06h, 06h, 2Ah, 35h, 0Bh, 08h, 08h, 2Ah, 35h, 0Bh, 0Ah, 0Ah, 2Ah, 35h, 0Bh, 0Ch
        db   0Ch, 2Ah, 35h, 0Bh, 0Eh, 0Eh, 2Ah, 35h, 0Bh, 10h, 10h, 2Ah, 35h, 0Bh, 12h, 12h
        db   2Ah, 35h, 0Bh, 14h, 14h, 28h, 37h, 0Bh, 03h, 03h, 28h, 29h, 0Bh, 05h, 05h, 28h
        db   29h, 0Bh, 07h, 07h, 28h, 29h, 0Bh, 09h, 09h, 28h, 29h, 0Bh, 0Bh, 0Bh, 28h, 29h
        db   0Bh, 0Dh, 0Dh, 28h, 29h, 0Bh, 0Fh, 0Fh, 28h, 29h, 0Bh, 11h, 11h, 28h, 29h, 0Bh
        db   13h, 13h, 28h, 29h, 0Bh, 03h, 03h, 36h, 37h, 0Bh, 05h, 05h, 36h, 37h, 0Bh, 07h
        db   07h, 36h, 37h, 0Bh, 09h, 09h, 36h, 37h, 0Bh, 0Bh, 0Bh, 36h, 37h, 0Bh, 0Dh, 0Dh
        db   36h, 37h, 0Bh, 0Fh, 0Fh, 36h, 37h, 0Bh, 11h, 11h, 36h, 37h, 0Bh, 13h, 13h, 36h
        db   37h, 07h, 03h, 03h, 2Eh, 31h, 07h, 05h, 05h, 2Eh, 31h, 07h, 07h, 07h, 2Eh, 31h
        db   07h, 09h, 09h, 2Eh, 31h, 07h, 0Bh, 0Bh, 2Eh, 31h, 07h, 0Dh, 0Dh, 2Eh, 31h, 07h
        db   0Fh, 0Fh, 2Eh, 31h, 07h, 11h, 11h, 2Eh, 31h, 07h, 13h, 13h, 2Eh, 31h, 01h, 14h
        db   14h, 3Ah, 3Bh, 0Ah, 15h, 15h, 3Ah, 3Ah, 02h, 01h, 15h, 3Ch, 3Ch, 00h
        ; (gap 0x218E-0x21C7)
        db   05h, 04h, 00h, 11h, 00h, 2Eh, 00h, 00h, 00h, 00h, 02h, 01h, 3Ch, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        ; --- level 7 (0x21C8) ---
        db   01h, 01h, 17h, 00h, 05h, 01h, 16h, 17h, 00h, 3Fh, 01h, 01h, 17h, 3Ch, 3Fh, 05h
        db   16h, 16h, 06h, 13h, 07h, 14h, 14h, 04h, 05h, 06h, 15h, 15h, 06h, 13h, 02h, 15h
        db   15h, 14h, 15h, 05h, 16h, 16h, 2Eh, 3Bh, 02h, 15h, 15h, 2Ch, 2Dh, 06h, 15h, 15h
        db   2Eh, 31h, 02h, 0Ch, 14h, 30h, 31h, 06h, 0Ch, 0Ch, 32h, 39h, 02h, 02h, 0Bh, 38h
        db   39h, 06h, 02h, 02h, 24h, 37h, 0Bh, 02h, 16h, 1Eh, 23h, 0Bh, 08h, 0Ah, 14h, 2Dh
        db   07h, 03h, 15h, 20h, 21h, 07h, 09h, 09h, 16h, 2Bh, 06h, 08h, 08h, 20h, 21h, 06h
        db   0Ah, 0Ah, 20h, 21h, 08h, 0Eh, 0Eh, 20h, 20h, 06h, 0Eh, 0Eh, 34h, 35h, 01h, 0Eh
        db   0Eh, 36h, 39h, 0Bh, 0Fh, 0Fh, 36h, 37h, 0Ah, 0Fh, 0Fh, 39h, 39h, 01h, 10h, 10h
        db   34h, 39h, 06h, 10h, 10h, 3Ah, 3Bh, 02h, 01h, 10h, 3Ch, 3Ch, 06h, 0Ah, 0Ah, 2Eh
        db   33h, 00h
        ; (gap 0x225A-0x2266)
        db   15h, 16h, 00h, 14h, 00h, 2Dh, 00h, 00h, 00h, 00h, 02h, 01h, 3Ch
        ; --- level 8 (0x2267) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 17h, 17h, 00h, 3Fh, 01h, 01h, 17h, 3Bh, 3Fh, 02h
        db   01h, 16h, 3Ah, 3Ah, 01h, 01h, 15h, 38h, 39h, 02h, 14h, 16h, 06h, 07h, 02h, 09h
        db   14h, 04h, 05h, 02h, 05h, 09h, 06h, 07h, 07h, 04h, 04h, 07h, 07h, 01h, 0Fh, 11h
        db   06h, 11h, 01h, 12h, 16h, 0Ch, 11h, 05h, 0Fh, 0Fh, 08h, 0Fh, 1Ah, 10h, 10h, 08h
        db   0Fh, 1Ch, 11h, 16h, 0Eh, 0Eh, 1Dh, 11h, 16h, 0Fh, 0Fh, 01h, 0Eh, 0Eh, 0Ah, 0Dh
        db   06h, 0Eh, 0Eh, 0Eh, 0Fh, 06h, 0Fh, 0Fh, 12h, 13h, 02h, 03h, 04h, 0Bh, 0Bh, 0Bh
        db   04h, 04h, 0Ch, 19h, 0Bh, 06h, 06h, 10h, 19h, 06h, 06h, 06h, 12h, 13h, 08h, 05h
        db   05h, 10h, 10h, 07h, 05h, 05h, 14h, 14h, 07h, 05h, 05h, 19h, 19h, 06h, 08h, 08h
        db   08h, 19h, 01h, 04h, 06h, 1Ah, 1Bh, 0Bh, 0Ah, 0Ah, 0Ah, 1Dh, 01h, 0Bh, 0Ch, 0Ch
        db   27h, 01h, 04h, 04h, 1Ch, 23h, 01h, 05h, 06h, 22h, 23h, 01h, 06h, 08h, 1Eh, 1Fh
        db   01h, 08h, 08h, 1Eh, 25h, 06h, 08h, 08h, 26h, 27h, 02h, 06h, 09h, 1Ch, 1Dh, 02h
        db   06h, 07h, 20h, 21h, 0Bh, 04h, 04h, 24h, 27h, 01h, 06h, 06h, 24h, 25h, 02h, 03h
        db   07h, 28h, 29h, 01h, 07h, 07h, 2Ah, 2Dh, 02h, 05h, 06h, 2Ch, 2Dh, 02h, 04h, 05h
        db   2Eh, 2Fh, 02h, 03h, 04h, 30h, 31h, 02h, 04h, 05h, 32h, 33h, 02h, 05h, 05h, 34h
        db   35h, 01h, 06h, 06h, 34h, 37h, 02h, 07h, 14h, 36h, 37h, 06h, 09h, 09h, 2Ch, 35h
        db   01h, 0Bh, 0Ch, 2Eh, 33h, 05h, 0Bh, 0Bh, 30h, 31h, 07h, 0Ah, 0Ah, 22h, 25h, 0Bh
        db   0Ah, 0Ah, 26h, 27h, 06h, 0Ah, 0Ah, 28h, 29h, 06h, 0Bh, 0Bh, 1Eh, 21h, 05h, 0Ch
        db   0Ch, 1Eh, 21h, 05h, 0Ch, 0Ch, 24h, 29h, 01h, 0Dh, 0Dh, 1Ah, 2Ah, 01h, 0Eh, 0Eh
        db   1Ch, 27h, 01h, 0Ah, 0Ch, 2Ah, 2Bh, 1Ah, 0Dh, 0Dh, 20h, 27h, 0Bh, 0Eh, 0Eh, 28h
        db   29h, 0Bh, 0Fh, 0Fh, 20h, 25h, 01h, 0Fh, 10h, 2Ah, 31h, 02h, 0Fh, 10h, 2Ch, 2Fh
        db   0Bh, 0Eh, 0Eh, 2Ch, 2Dh, 0Bh, 0Fh, 0Fh, 30h, 31h, 0Bh, 10h, 10h, 2Eh, 2Fh, 06h
        db   0Fh, 11h, 32h, 33h, 07h, 0Eh, 0Eh, 32h, 33h, 07h, 10h, 10h, 32h, 33h, 05h, 15h
        db   15h, 12h, 13h, 1Ah, 16h, 16h, 12h, 13h, 06h, 11h, 11h, 14h, 1Fh, 02h, 10h, 11h
        db   24h, 25h, 01h, 10h, 10h, 1Eh, 23h, 02h, 10h, 11h, 20h, 21h, 02h, 10h, 10h, 1Ch
        db   1Dh, 07h, 10h, 10h, 14h, 1Bh, 01h, 15h, 16h, 14h, 16h, 0Ah, 14h, 14h, 16h, 16h
        db   01h, 12h, 13h, 16h, 17h, 01h, 13h, 13h, 18h, 1Fh, 01h, 15h, 15h, 1Ah, 38h, 01h
        db   14h, 14h, 1Ah, 1Bh, 07h, 14h, 14h, 1Ch, 1Ch, 0Bh, 12h, 14h, 20h, 31h, 06h, 12h
        db   12h, 22h, 23h, 02h, 13h, 13h, 20h, 21h, 02h, 14h, 14h, 22h, 23h, 02h, 13h, 13h
        db   24h, 25h, 06h, 12h, 12h, 26h, 27h, 02h, 14h, 14h, 26h, 27h, 02h, 13h, 13h, 28h
        db   29h, 06h, 12h, 12h, 2Ah, 2Bh, 02h, 14h, 14h, 2Ah, 2Bh, 02h, 13h, 13h, 2Ch, 2Dh
        db   06h, 12h, 12h, 2Eh, 2Fh, 02h, 14h, 14h, 2Eh, 2Fh, 02h, 13h, 13h, 30h, 31h, 02h
        db   14h, 14h, 32h, 33h, 0Bh, 13h, 13h, 32h, 33h, 0Bh, 10h, 10h, 26h, 27h, 00h
        ; (gap 0x2466-0x2472)
        db   15h, 04h, 07h, 25h, 14h, 1Eh, 00h, 00h, 00h, 00h, 02h, 01h, 3Ah
        ; --- level 9 (0x2473) ---
        db   01h, 01h, 17h, 00h, 3Fh, 18h, 05h, 0Bh, 02h, 05h, 0Bh, 01h, 01h, 02h, 17h, 18h
        db   02h, 04h, 02h, 03h, 0Eh, 03h, 03h, 06h, 0Fh, 07h, 03h, 03h, 06h, 06h, 07h, 03h
        db   03h, 0Fh, 0Fh, 02h, 04h, 0Dh, 08h, 09h, 0Eh, 0Dh, 0Dh, 04h, 07h, 02h, 0Eh, 15h
        db   04h, 05h, 0Eh, 15h, 15h, 06h, 0Fh, 02h, 14h, 15h, 10h, 11h, 07h, 13h, 13h, 10h
        db   11h, 0Eh, 0Fh, 0Fh, 06h, 1Bh, 02h, 05h, 0Fh, 16h, 17h, 0Eh, 09h, 09h, 0Ah, 15h
        db   18h, 0Bh, 0Dh, 0Ch, 13h, 18h, 05h, 07h, 0Ch, 13h, 18h, 02h, 04h, 12h, 13h, 18h
        db   02h, 02h, 14h, 17h, 18h, 06h, 0Dh, 1Ah, 1Bh, 18h, 11h, 13h, 08h, 0Dh, 18h, 11h
        db   11h, 0Eh, 21h, 18h, 0Fh, 10h, 1Eh, 21h, 0Eh, 04h, 04h, 16h, 1Fh, 02h, 04h, 04h
        db   1Ah, 1Bh, 0Eh, 01h, 03h, 1Ah, 1Bh, 02h, 05h, 0Dh, 1Eh, 1Fh, 0Eh, 09h, 09h, 20h
        db   27h, 07h, 09h, 09h, 28h, 28h, 0Eh, 0Dh, 0Dh, 20h, 27h, 07h, 0Dh, 0Dh, 27h, 27h
        db   0Eh, 13h, 13h, 18h, 31h, 05h, 14h, 14h, 18h, 19h, 02h, 0Eh, 13h, 24h, 25h, 07h
        db   13h, 13h, 1Ah, 1Ah, 0Eh, 14h, 14h, 30h, 3Bh, 02h, 14h, 14h, 30h, 31h, 02h, 0Fh
        db   14h, 3Ah, 3Bh, 0Eh, 0Eh, 0Eh, 3Ah, 3Dh, 08h, 0Eh, 0Eh, 3Dh, 3Dh, 02h, 10h, 13h
        db   2Eh, 2Fh, 0Eh, 0Fh, 0Fh, 2Eh, 31h, 02h, 0Ah, 0Fh, 32h, 33h, 0Eh, 09h, 09h, 32h
        db   3Bh, 05h, 0Ah, 0Ah, 3Ah, 3Bh, 07h, 09h, 09h, 39h, 39h, 02h, 06h, 09h, 30h, 31h
        db   0Eh, 05h, 05h, 30h, 3Bh, 0Eh, 03h, 03h, 28h, 2Fh, 0Eh, 01h, 02h, 28h, 29h, 02h
        db   04h, 05h, 2Eh, 2Fh, 0Ah, 05h, 05h, 34h, 34h, 02h, 01h, 05h, 39h, 39h, 18h, 12h
        db   16h, 14h, 15h, 18h, 16h, 16h, 16h, 3Dh, 18h, 15h, 15h, 1Ch, 2Dh, 18h, 02h, 02h
        db   1Eh, 25h, 0Bh, 01h, 01h, 1Eh, 25h, 18h, 03h, 07h, 22h, 25h, 18h, 05h, 07h, 26h
        db   2Bh, 18h, 07h, 0Bh, 2Ch, 2Dh, 18h, 0Bh, 0Bh, 22h, 2Fh, 18h, 0Ch, 0Dh, 2Ah, 2Fh
        db   18h, 0Eh, 11h, 2Ah, 2Bh, 18h, 0Fh, 11h, 28h, 29h, 0Bh, 01h, 01h, 2Ch, 36h, 18h
        db   02h, 03h, 32h, 36h, 0Bh, 01h, 01h, 3Ch, 3Dh, 18h, 02h, 03h, 3Ch, 3Dh, 18h, 07h
        db   07h, 34h, 3Dh, 18h, 0Bh, 12h, 36h, 37h, 18h, 0Ch, 0Ch, 38h, 3Dh, 18h, 11h, 11h
        db   32h, 35h, 18h, 12h, 12h, 34h, 37h, 00h
        ; (gap 0x25EB-0x25FF)
        db   15h, 06h, 00h, 1Ah, 00h, 28h, 00h, 00h, 00h, 00h, 02h, 01h, 39h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h
        ; --- level 10 (0x2600) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 16h, 17h, 00h, 3Fh, 01h, 01h, 15h, 3Ch, 3Fh, 1Ah
        db   16h, 16h, 14h, 27h, 1Ah, 16h, 16h, 2Ch, 33h, 01h, 15h, 15h, 12h, 3Fh, 05h, 15h
        db   15h, 14h, 27h, 05h, 15h, 15h, 2Ch, 33h, 0Bh, 01h, 01h, 06h, 1Dh, 0Bh, 01h, 01h
        db   20h, 3Bh, 0Bh, 13h, 13h, 06h, 23h, 06h, 13h, 13h, 18h, 1Bh, 06h, 13h, 13h, 24h
        db   27h, 0Bh, 11h, 12h, 06h, 0Bh, 0Bh, 0Dh, 10h, 06h, 09h, 0Bh, 05h, 0Ch, 06h, 07h
        db   0Bh, 11h, 11h, 0Eh, 25h, 06h, 11h, 11h, 18h, 19h, 02h, 11h, 15h, 10h, 11h, 01h
        db   0Eh, 0Fh, 0Ch, 11h, 05h, 0Eh, 0Eh, 0Eh, 0Fh, 0Bh, 0Ah, 0Dh, 0Ch, 0Dh, 06h, 0Ah
        db   0Ah, 08h, 0Bh, 0Bh, 0Eh, 0Fh, 12h, 17h, 02h, 0Eh, 10h, 14h, 15h, 0Bh, 03h, 03h
        db   0Ch, 2Dh, 0Bh, 05h, 05h, 0Ch, 0Dh, 0Bh, 08h, 08h, 0Ch, 0Dh, 06h, 04h, 04h, 08h
        db   09h, 02h, 03h, 08h, 0Ah, 0Bh, 06h, 08h, 08h, 0Eh, 0Fh, 02h, 08h, 0Dh, 10h, 11h
        db   0Bh, 0Bh, 0Bh, 12h, 17h, 0Bh, 0Ch, 0Ch, 16h, 17h, 06h, 09h, 09h, 12h, 13h, 0Bh
        db   09h, 09h, 14h, 1Bh, 0Bh, 0Ah, 0Ch, 1Ah, 1Bh, 0Bh, 0Ch, 0Ch, 1Ch, 1Fh, 0Bh, 0Dh
        db   0Dh, 1Eh, 1Fh, 06h, 0Eh, 0Eh, 18h, 19h, 0Bh, 0Eh, 0Eh, 1Ah, 1Bh, 0Bh, 0Fh, 0Fh
        db   1Ah, 29h, 06h, 0Fh, 0Fh, 20h, 21h, 0Bh, 05h, 05h, 10h, 1Bh, 02h, 03h, 04h, 1Ah
        db   1Bh, 0Bh, 05h, 05h, 1Eh, 1Fh, 0Bh, 07h, 07h, 14h, 35h, 0Bh, 08h, 0Ah, 1Eh, 1Fh
        db   06h, 07h, 07h, 12h, 13h, 06h, 07h, 07h, 1Ch, 1Dh, 06h, 07h, 07h, 20h, 21h, 02h
        db   07h, 08h, 2Ch, 2Dh, 06h, 07h, 07h, 2Eh, 33h, 0Bh, 05h, 05h, 24h, 33h, 0Bh, 06h
        db   06h, 2Ah, 2Bh, 02h, 05h, 06h, 22h, 23h, 02h, 04h, 05h, 2Ah, 2Bh, 06h, 05h, 05h
        db   2Eh, 2Fh, 0Bh, 09h, 09h, 24h, 3Bh, 02h, 09h, 0Ah, 22h, 23h, 01h, 0Bh, 0Dh, 22h
        db   2Bh, 06h, 0Bh, 0Bh, 24h, 27h, 05h, 0Ch, 0Ch, 24h, 29h, 06h, 09h, 09h, 2Eh, 2Fh
        db   06h, 09h, 09h, 32h, 33h, 0Bh, 0Bh, 0Bh, 28h, 2Dh, 0Bh, 0Bh, 0Eh, 2Eh, 31h, 06h
        db   0Bh, 0Bh, 2Eh, 2Fh, 06h, 0Bh, 0Bh, 32h, 33h, 0Bh, 0Bh, 0Ch, 34h, 37h, 0Bh, 0Eh
        db   11h, 34h, 37h, 02h, 0Bh, 14h, 38h, 39h, 0Bh, 10h, 10h, 28h, 31h, 06h, 10h, 10h
        db   2Ah, 2Dh, 01h, 12h, 13h, 28h, 29h, 02h, 12h, 14h, 2Ah, 2Bh, 06h, 12h, 12h, 2Ch
        db   2Dh, 0Bh, 12h, 12h, 2Eh, 2Fh, 0Bh, 13h, 14h, 2Eh, 31h, 06h, 13h, 13h, 32h, 33h
        db   0Bh, 13h, 14h, 34h, 35h, 0Bh, 02h, 03h, 30h, 31h, 02h, 03h, 04h, 32h, 33h, 0Bh
        db   03h, 04h, 34h, 3Bh, 0Bh, 05h, 07h, 38h, 39h, 02h, 04h, 06h, 36h, 37h, 0Bh, 05h
        db   05h, 3Ah, 3Bh, 02h, 01h, 02h, 39h, 39h, 0Ah, 02h, 02h, 34h, 34h, 07h, 04h, 04h
        db   06h, 07h, 07h, 0Ch, 0Ch, 08h, 09h, 07h, 10h, 10h, 0Ah, 0Bh, 07h, 0Ah, 0Ah, 16h
        db   17h, 07h, 12h, 12h, 1Eh, 1Eh, 07h, 14h, 14h, 28h, 29h, 07h, 0Ch, 0Ch, 2Eh, 2Fh
        db   07h, 02h, 02h, 2Ch, 2Ch, 07h, 04h, 04h, 16h, 17h, 07h, 04h, 04h, 3Ah, 3Bh, 08h
        db   04h, 04h, 16h, 16h, 00h
        ; (gap 0x27F5-0x280F)
        db   01h, 04h, 01h, 1Eh, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 00h, 39h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        ; --- level 11 (0x2810) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 17h, 17h, 00h, 3Fh, 0Bh, 16h, 16h, 04h, 0Bh, 01h
        db   01h, 16h, 3Ch, 3Fh, 05h, 16h, 16h, 0Ch, 3Bh, 02h, 14h, 15h, 0Ah, 0Bh, 06h, 14h
        db   14h, 0Ch, 15h, 02h, 14h, 14h, 16h, 17h, 06h, 15h, 15h, 18h, 25h, 02h, 14h, 14h
        db   26h, 27h, 06h, 14h, 14h, 28h, 37h, 02h, 12h, 13h, 38h, 39h, 06h, 12h, 12h, 26h
        db   37h, 02h, 12h, 12h, 24h, 25h, 06h, 13h, 13h, 1Ah, 23h, 02h, 12h, 12h, 18h, 19h
        db   06h, 12h, 12h, 0Ch, 17h, 02h, 10h, 12h, 0Ah, 0Bh, 06h, 10h, 10h, 0Ch, 19h, 02h
        db   10h, 10h, 1Ah, 1Bh, 06h, 11h, 11h, 1Ch, 21h, 02h, 10h, 10h, 22h, 23h, 06h, 10h
        db   10h, 24h, 37h, 02h, 02h, 10h, 38h, 39h, 06h, 0Eh, 0Eh, 36h, 37h, 0Bh, 0Eh, 0Eh
        db   34h, 35h, 06h, 02h, 02h, 24h, 37h, 06h, 03h, 03h, 1Ch, 1Fh, 02h, 03h, 04h, 20h
        db   21h, 02h, 05h, 05h, 1Eh, 1Fh, 02h, 06h, 07h, 1Ch, 1Dh, 02h, 08h, 08h, 1Eh, 1Fh
        db   02h, 09h, 0Ah, 20h, 21h, 02h, 0Bh, 0Dh, 22h, 23h, 0Bh, 0Eh, 0Eh, 24h, 25h, 06h
        db   0Eh, 0Eh, 26h, 2Fh, 02h, 0Ch, 0Eh, 30h, 31h, 06h, 0Ch, 0Ch, 28h, 2Fh, 02h, 0Ah
        db   0Ch, 26h, 27h, 06h, 0Ah, 0Ah, 28h, 2Fh, 02h, 08h, 0Ah, 30h, 31h, 06h, 08h, 08h
        db   28h, 2Fh, 02h, 06h, 08h, 26h, 27h, 06h, 06h, 06h, 28h, 31h, 02h, 05h, 06h, 32h
        db   33h, 02h, 04h, 04h, 30h, 31h, 06h, 04h, 04h, 28h, 2Fh, 07h, 04h, 04h, 27h, 27h
        db   07h, 08h, 08h, 34h, 34h, 07h, 0Ah, 0Ah, 34h, 34h, 07h, 0Ch, 0Ch, 34h, 34h, 02h
        db   0Fh, 0Fh, 1Eh, 1Fh, 02h, 0Eh, 0Eh, 1Ch, 1Dh, 02h, 0Eh, 0Eh, 20h, 21h, 06h, 0Eh
        db   0Eh, 0Eh, 1Bh, 0Bh, 0Eh, 0Eh, 0Ch, 0Dh, 07h, 0Dh, 0Dh, 0Ch, 15h, 06h, 0Dh, 0Dh
        db   18h, 1Bh, 0Bh, 0Ch, 0Ch, 0Ah, 0Bh, 06h, 0Ch, 0Ch, 0Ch, 15h, 07h, 0Bh, 0Bh, 0Ah
        db   15h, 07h, 0Ch, 0Ch, 18h, 19h, 02h, 0Bh, 0Ch, 1Ah, 1Bh, 02h, 0Ch, 0Ch, 1Eh, 1Fh
        db   02h, 0Bh, 0Bh, 1Ch, 1Dh, 02h, 0Ah, 0Ah, 18h, 19h, 02h, 09h, 09h, 16h, 17h, 02h
        db   08h, 08h, 14h, 15h, 02h, 07h, 07h, 12h, 13h, 02h, 06h, 06h, 10h, 11h, 02h, 05h
        db   05h, 0Eh, 0Fh, 02h, 04h, 04h, 0Ch, 0Dh, 02h, 03h, 03h, 0Ah, 0Bh, 02h, 01h, 02h
        db   09h, 09h, 0Bh, 04h, 05h, 06h, 09h, 0Ah, 06h, 06h, 08h, 08h, 02h, 07h, 0Dh, 06h
        db   07h, 0Bh, 07h, 07h, 08h, 09h, 06h, 07h, 07h, 0Ah, 11h, 07h, 09h, 09h, 08h, 09h
        db   0Bh, 0Ah, 0Ah, 08h, 09h, 07h, 0Dh, 0Dh, 08h, 09h, 0Bh, 0Eh, 0Eh, 08h, 09h, 07h
        db   02h, 02h, 1Ch, 1Dh, 08h, 09h, 09h, 09h, 09h, 00h
        ; (gap 0x29BA-0x29CF)
        db   10h, 04h, 01h, 0Bh, 00h, 00h, 00h, 00h, 00h, 00h, 01h, 00h, 09h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h
        ; --- level 12 (0x29D0) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 15h, 17h, 04h, 3Fh, 01h, 01h, 14h, 3Ah, 3Fh, 05h
        db   16h, 16h, 04h, 39h, 06h, 15h, 15h, 0Ah, 35h, 06h, 03h, 03h, 05h, 1Dh, 02h, 03h
        db   14h, 04h, 04h, 02h, 01h, 14h, 39h, 39h, 01h, 14h, 14h, 08h, 09h, 01h, 13h, 13h
        db   36h, 38h, 0Ah, 14h, 14h, 36h, 36h, 0Bh, 03h, 04h, 1Eh, 1Fh, 0Bh, 05h, 05h, 1Ah
        db   23h, 0Bh, 06h, 06h, 18h, 1Dh, 0Bh, 06h, 06h, 20h, 25h, 0Bh, 07h, 07h, 1Ch, 21h
        db   0Bh, 08h, 08h, 18h, 25h, 0Bh, 09h, 09h, 16h, 1Bh, 0Bh, 09h, 09h, 22h, 27h, 0Bh
        db   0Ah, 0Ah, 1Ah, 23h, 0Bh, 0Bh, 0Bh, 18h, 25h, 0Bh, 0Ch, 0Ch, 16h, 1Bh, 0Bh, 0Ch
        db   0Ch, 22h, 27h, 0Bh, 0Dh, 0Dh, 1Ah, 23h, 0Bh, 0Eh, 0Eh, 16h, 27h, 0Bh, 0Fh, 0Fh
        db   14h, 1Bh, 0Bh, 0Fh, 0Fh, 22h, 29h, 0Bh, 10h, 10h, 1Ah, 23h, 0Bh, 11h, 11h, 14h
        db   29h, 0Bh, 12h, 12h, 12h, 1Bh, 0Bh, 12h, 12h, 22h, 2Bh, 0Bh, 13h, 14h, 18h, 19h
        db   0Bh, 13h, 14h, 24h, 25h, 0Bh, 15h, 16h, 12h, 2Bh, 07h, 07h, 07h, 1Eh, 1Fh, 07h
        db   0Ah, 0Ah, 1Ch, 21h, 07h, 0Dh, 0Dh, 1Ch, 21h, 07h, 10h, 10h, 1Ch, 21h, 07h, 14h
        db   14h, 1Ch, 21h, 02h, 08h, 14h, 1Eh, 1Fh, 08h, 14h, 14h, 1Ch, 1Ch, 00h
        ; (gap 0x2A9E-0x2AAF)
        db   14h, 07h, 12h, 1Ch, 12h, 21h, 00h, 00h, 00h, 00h, 02h, 00h, 39h, 00h, 00h, 00h
        db   00h, 00h
        ; --- level 13 (0x2AB0) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 17h, 17h, 04h, 3Fh, 01h, 01h, 16h, 3Ch, 3Fh, 01h
        db   01h, 01h, 04h, 13h, 01h, 01h, 01h, 16h, 2Bh, 01h, 01h, 01h, 2Eh, 3Bh, 0Bh, 13h
        db   16h, 14h, 2Dh, 05h, 13h, 13h, 0Ah, 13h, 05h, 13h, 13h, 1Ah, 27h, 05h, 13h, 13h
        db   2Eh, 37h, 1Ah, 14h, 16h, 0Ah, 13h, 1Ah, 14h, 16h, 1Ah, 27h, 1Ah, 14h, 16h, 2Eh
        db   3Bh, 01h, 12h, 13h, 04h, 05h, 01h, 12h, 16h, 08h, 09h, 01h, 16h, 16h, 04h, 07h
        db   02h, 12h, 15h, 06h, 07h, 06h, 04h, 04h, 0Ch, 35h, 06h, 06h, 06h, 0Ch, 1Bh, 06h
        db   06h, 06h, 26h, 35h, 06h, 08h, 08h, 0Ch, 35h, 06h, 0Ah, 0Ah, 0Ch, 13h, 06h, 0Ch
        db   0Ch, 0Ch, 13h, 06h, 0Eh, 0Eh, 0Ch, 13h, 06h, 10h, 10h, 0Ch, 13h, 06h, 12h, 12h
        db   0Ch, 0Fh, 06h, 0Ah, 0Ah, 2Eh, 35h, 06h, 0Ch, 0Ch, 2Eh, 35h, 06h, 0Eh, 0Eh, 2Eh
        db   35h, 06h, 10h, 10h, 2Eh, 35h, 06h, 12h, 12h, 32h, 35h, 0Bh, 0Ah, 0Ah, 1Ah, 27h
        db   06h, 0Ah, 0Ah, 1Ch, 25h, 06h, 0Ch, 0Ch, 20h, 23h, 06h, 0Eh, 0Eh, 1Eh, 21h, 06h
        db   0Fh, 0Fh, 1Ah, 1Bh, 06h, 0Fh, 0Fh, 26h, 27h, 06h, 10h, 10h, 20h, 23h, 06h, 12h
        db   12h, 1Ah, 21h, 06h, 12h, 12h, 26h, 27h, 0Bh, 04h, 05h, 20h, 21h, 0Bh, 06h, 07h
        db   1Eh, 1Fh, 0Bh, 06h, 07h, 22h, 23h, 0Bh, 08h, 09h, 1Ch, 1Dh, 0Bh, 08h, 09h, 24h
        db   25h, 0Bh, 0Ch, 0Dh, 28h, 29h, 0Bh, 0Ch, 0Dh, 18h, 19h, 0Bh, 0Eh, 0Eh, 16h, 17h
        db   0Bh, 0Eh, 0Eh, 2Ah, 2Bh, 0Bh, 10h, 10h, 14h, 19h, 0Bh, 10h, 10h, 28h, 2Dh, 0Bh
        db   12h, 12h, 14h, 15h, 0Bh, 12h, 12h, 2Ch, 2Dh, 02h, 04h, 12h, 0Ah, 0Bh, 02h, 04h
        db   12h, 10h, 11h, 02h, 04h, 0Dh, 16h, 17h, 02h, 04h, 07h, 1Ch, 1Dh, 02h, 04h, 07h
        db   24h, 25h, 02h, 04h, 0Dh, 2Ah, 2Bh, 02h, 04h, 12h, 30h, 31h, 02h, 04h, 12h, 36h
        db   37h, 02h, 0Ch, 12h, 1Ch, 1Dh, 02h, 0Ch, 12h, 24h, 25h, 01h, 02h, 14h, 38h, 3Bh
        db   0Eh, 11h, 11h, 38h, 3Bh, 02h, 01h, 11h, 3Bh, 3Bh, 0Ah, 11h, 11h, 39h, 39h, 07h
        db   07h, 07h, 20h, 21h, 07h, 09h, 09h, 20h, 21h, 07h, 0Bh, 0Bh, 20h, 21h, 07h, 0Dh
        db   0Dh, 20h, 21h, 07h, 0Fh, 0Fh, 20h, 21h, 07h, 11h, 11h, 20h, 21h, 08h, 0Fh, 0Fh
        db   20h, 20h, 03h, 0Fh, 0Fh, 16h, 16h, 04h, 0Fh, 0Fh, 2Bh, 2Bh, 00h
        ; (gap 0x2C2D-0x2C3F)
        db   14h, 04h, 01h, 14h, 01h, 2Dh, 00h, 00h, 00h, 00h, 02h, 00h, 3Bh, 00h, 00h, 00h
        db   00h, 00h, 00h
        ; --- level 14 (0x2C40) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 16h, 17h, 04h, 3Fh, 01h, 01h, 15h, 3Ch, 3Fh, 05h
        db   16h, 16h, 0Eh, 33h, 02h, 04h, 15h, 06h, 07h, 06h, 04h, 04h, 08h, 21h, 0Bh, 02h
        db   02h, 20h, 21h, 0Bh, 04h, 04h, 1Eh, 1Fh, 0Bh, 04h, 04h, 22h, 23h, 0Bh, 06h, 06h
        db   1Ch, 25h, 06h, 06h, 06h, 20h, 21h, 0Bh, 08h, 08h, 1Ah, 1Bh, 0Bh, 08h, 08h, 1Eh
        db   23h, 0Bh, 08h, 08h, 26h, 27h, 0Bh, 0Ah, 0Ah, 18h, 1Bh, 0Bh, 0Ah, 0Ah, 1Eh, 23h
        db   0Bh, 0Ah, 0Ah, 26h, 29h, 0Bh, 0Ch, 0Ch, 16h, 19h, 0Bh, 0Ch, 0Ch, 1Ch, 25h, 0Bh
        db   0Ch, 0Ch, 28h, 2Bh, 0Bh, 0Eh, 0Eh, 14h, 17h, 0Bh, 0Eh, 0Eh, 1Ah, 27h, 0Bh, 0Eh
        db   0Eh, 2Ah, 2Dh, 0Bh, 10h, 10h, 12h, 15h, 0Bh, 10h, 10h, 18h, 29h, 0Bh, 10h, 10h
        db   2Ch, 2Fh, 0Bh, 12h, 12h, 10h, 13h, 0Bh, 12h, 12h, 16h, 2Bh, 0Bh, 12h, 12h, 2Eh
        db   31h, 0Bh, 14h, 14h, 0Eh, 33h, 07h, 05h, 05h, 1Eh, 23h, 07h, 07h, 07h, 1Eh, 23h
        db   07h, 09h, 09h, 1Eh, 23h, 07h, 0Bh, 0Bh, 1Eh, 23h, 07h, 0Dh, 0Dh, 1Eh, 23h, 07h
        db   0Fh, 0Fh, 1Eh, 23h, 07h, 11h, 11h, 1Eh, 23h, 07h, 13h, 13h, 1Eh, 23h, 0Eh, 07h
        db   14h, 20h, 21h, 01h, 14h, 14h, 38h, 3Bh, 02h, 01h, 15h, 3Bh, 3Bh, 0Ah, 15h, 15h
        db   39h, 39h, 0Eh, 05h, 05h, 20h, 21h, 08h, 09h, 09h, 23h, 23h, 00h
        ; (gap 0x2D1D-0x2D2F)
        db   14h, 04h, 01h, 1Ch, 01h, 25h, 00h, 00h, 00h, 00h, 02h, 00h, 3Bh, 00h, 00h, 00h
        db   00h, 00h, 00h
        ; --- level 15 (0x2D30) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 17h, 17h, 04h, 3Fh, 01h, 01h, 16h, 3Ah, 3Fh, 0Eh
        db   11h, 11h, 3Ah, 3Ch, 05h, 13h, 13h, 04h, 39h, 1Bh, 14h, 16h, 04h, 39h, 02h, 02h
        db   11h, 02h, 03h, 06h, 03h, 03h, 04h, 37h, 02h, 03h, 08h, 38h, 39h, 06h, 07h, 07h
        db   08h, 37h, 07h, 09h, 11h, 20h, 21h, 06h, 0Ch, 0Ch, 06h, 39h, 06h, 09h, 0Ah, 30h
        db   37h, 02h, 09h, 09h, 30h, 31h, 02h, 0Ah, 0Bh, 38h, 39h, 06h, 09h, 0Ah, 08h, 11h
        db   02h, 07h, 08h, 06h, 07h, 02h, 09h, 09h, 10h, 11h, 02h, 0Ah, 0Bh, 06h, 07h, 06h
        db   12h, 12h, 04h, 13h, 06h, 12h, 12h, 2Eh, 39h, 0Bh, 04h, 05h, 20h, 21h, 0Bh, 06h
        db   07h, 1Eh, 23h, 0Bh, 08h, 09h, 1Ch, 1Fh, 0Bh, 0Ah, 0Bh, 1Ah, 1Dh, 0Bh, 0Ch, 0Dh
        db   18h, 1Bh, 0Bh, 0Eh, 0Fh, 16h, 19h, 0Bh, 10h, 10h, 14h, 17h, 0Bh, 11h, 13h, 14h
        db   15h, 0Bh, 13h, 13h, 16h, 19h, 0Bh, 12h, 12h, 18h, 19h, 0Bh, 08h, 09h, 22h, 25h
        db   0Bh, 0Ah, 0Bh, 24h, 27h, 0Bh, 0Ch, 0Dh, 26h, 29h, 0Bh, 0Eh, 0Fh, 28h, 2Bh, 0Bh
        db   10h, 10h, 2Ah, 2Bh, 0Bh, 11h, 13h, 2Ch, 2Dh, 0Bh, 13h, 13h, 28h, 2Bh, 0Bh, 12h
        db   12h, 28h, 29h, 06h, 0Ah, 0Ah, 1Eh, 23h, 06h, 0Eh, 0Eh, 1Ah, 21h, 06h, 0Eh, 0Eh
        db   26h, 27h, 06h, 10h, 10h, 1Ah, 1Bh, 06h, 10h, 10h, 20h, 27h, 06h, 12h, 12h, 1Ah
        db   21h, 06h, 12h, 12h, 26h, 27h, 02h, 0Eh, 12h, 1Ch, 1Dh, 02h, 0Eh, 12h, 24h, 25h
        db   0Ah, 11h, 11h, 3Bh, 3Bh, 02h, 01h, 11h, 3Dh, 3Dh, 08h, 11h, 11h, 21h, 21h, 01h
        db   01h, 01h, 04h, 1Dh, 01h, 01h, 01h, 20h, 21h, 01h, 01h, 01h, 24h, 3Ah, 00h
        ; (gap 0x2E3F-0x2E4F)
        db   02h, 02h, 01h, 1Fh, 01h, 22h, 00h, 00h, 00h, 00h, 02h, 00h, 3Dh, 00h, 00h, 00h
        db   00h
        ; --- level 16 (0x2E50) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 16h, 17h, 04h, 3Fh, 01h, 01h, 17h, 3Ch, 3Fh, 02h
        db   13h, 15h, 09h, 09h, 02h, 04h, 12h, 0Ah, 0Ah, 06h, 04h, 04h, 0Bh, 1Dh, 0Bh, 02h
        db   02h, 20h, 21h, 0Bh, 04h, 04h, 1Eh, 23h, 0Bh, 06h, 06h, 1Ch, 25h, 06h, 06h, 06h
        db   1Eh, 1Fh, 06h, 06h, 06h, 22h, 23h, 07h, 05h, 05h, 20h, 21h, 0Bh, 08h, 08h, 1Ah
        db   1Bh, 0Bh, 08h, 08h, 1Eh, 23h, 0Bh, 08h, 08h, 26h, 27h, 07h, 09h, 09h, 1Ch, 1Dh
        db   07h, 09h, 09h, 24h, 25h, 0Bh, 0Ah, 0Ah, 18h, 19h, 0Bh, 0Ah, 0Ah, 1Ch, 1Fh, 0Bh
        db   0Ah, 0Ah, 22h, 25h, 0Bh, 0Ah, 0Ah, 28h, 29h, 07h, 0Bh, 0Bh, 1Ah, 1Bh, 07h, 0Bh
        db   0Bh, 26h, 27h, 0Bh, 0Ch, 0Ch, 16h, 17h, 06h, 0Ch, 0Ch, 1Ah, 1Bh, 01h, 0Ch, 0Eh
        db   1Ch, 1Dh, 01h, 0Eh, 0Eh, 1Eh, 25h, 01h, 0Ch, 0Dh, 24h, 25h, 0Bh, 0Ch, 0Ch, 26h
        db   2Bh, 06h, 0Ch, 0Ch, 28h, 29h, 02h, 0Eh, 0Eh, 18h, 19h, 0Bh, 0Eh, 0Eh, 14h, 15h
        db   05h, 0Dh, 0Dh, 1Eh, 23h, 02h, 0Eh, 0Eh, 28h, 29h, 0Bh, 0Eh, 0Eh, 2Ch, 2Dh, 0Bh
        db   10h, 10h, 12h, 13h, 0Bh, 10h, 10h, 16h, 1Fh, 06h, 10h, 10h, 18h, 1Bh, 0Bh, 10h
        db   10h, 22h, 2Bh, 0Bh, 10h, 10h, 2Eh, 2Fh, 0Bh, 12h, 12h, 10h, 17h, 06h, 12h, 12h
        db   12h, 13h, 0Bh, 12h, 12h, 1Ah, 1Fh, 06h, 12h, 12h, 20h, 21h, 0Bh, 12h, 12h, 24h
        db   27h, 0Bh, 12h, 12h, 2Ah, 31h, 06h, 12h, 12h, 2Eh, 2Fh, 0Bh, 14h, 14h, 0Eh, 15h
        db   0Bh, 14h, 14h, 18h, 19h, 0Bh, 14h, 14h, 1Ch, 1Fh, 0Bh, 14h, 14h, 22h, 29h, 0Bh
        db   14h, 14h, 2Ch, 2Fh, 0Bh, 14h, 14h, 32h, 33h, 01h, 14h, 14h, 38h, 3Bh, 0Ah, 15h
        db   15h, 39h, 39h, 02h, 01h, 15h, 3Bh, 3Bh, 07h, 0Fh, 0Fh, 16h, 17h, 04h, 0Fh, 0Fh
        db   1Ah, 1Bh, 07h, 0Fh, 0Fh, 2Ah, 2Bh, 07h, 11h, 11h, 14h, 15h, 07h, 11h, 11h, 1Eh
        db   1Fh, 07h, 11h, 11h, 2Ch, 2Dh, 03h, 13h, 13h, 10h, 10h, 07h, 13h, 13h, 22h, 23h
        db   08h, 11h, 11h, 1Eh, 1Eh, 00h
        ; (gap 0x2F96-0x2FAF)
        db   15h, 04h, 01h, 1Ah, 01h, 27h, 00h, 00h, 00h, 00h, 02h, 00h, 3Bh, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        ; --- level 17 (0x2FB0) ---
        db   01h, 01h, 17h, 00h, 03h, 01h, 16h, 17h, 04h, 3Fh, 01h, 01h, 15h, 3Ch, 3Fh, 05h
        db   16h, 16h, 10h, 3Bh, 06h, 15h, 15h, 08h, 3Bh, 02h, 03h, 15h, 04h, 05h, 01h, 04h
        db   14h, 06h, 07h, 01h, 14h, 15h, 0Eh, 0Fh, 06h, 03h, 03h, 06h, 0Bh, 06h, 02h, 02h
        db   12h, 2Bh, 06h, 03h, 03h, 0Eh, 29h, 06h, 04h, 04h, 14h, 29h, 06h, 05h, 05h, 0Ah
        db   25h, 02h, 01h, 02h, 0Eh, 0Eh, 02h, 02h, 02h, 28h, 29h, 06h, 07h, 07h, 0Ah, 19h
        db   06h, 07h, 07h, 20h, 25h, 02h, 05h, 06h, 08h, 09h, 02h, 08h, 09h, 08h, 09h, 06h
        db   09h, 09h, 0Ah, 0Dh, 01h, 06h, 09h, 0Eh, 0Fh, 02h, 07h, 09h, 10h, 11h, 06h, 0Ah
        db   0Ah, 10h, 13h, 01h, 0Ch, 0Ch, 0Ch, 0Fh, 02h, 0Dh, 0Dh, 0Ah, 0Bh, 01h, 0Eh, 0Fh
        db   08h, 0Bh, 05h, 0Eh, 0Eh, 08h, 09h, 02h, 11h, 14h, 08h, 09h, 01h, 11h, 13h, 0Ah
        db   0Bh, 02h, 0Eh, 10h, 0Ch, 0Dh, 01h, 11h, 11h, 0Ch, 0Fh, 01h, 0Eh, 10h, 0Eh, 0Fh
        db   06h, 0Eh, 0Eh, 10h, 17h, 01h, 0Fh, 0Fh, 10h, 19h, 06h, 0Fh, 0Fh, 12h, 13h, 02h
        db   0Ah, 0Dh, 14h, 15h, 01h, 09h, 0Dh, 16h, 17h, 02h, 09h, 0Eh, 18h, 19h, 02h, 07h
        db   07h, 1Eh, 1Fh, 02h, 07h, 07h, 26h, 27h, 06h, 09h, 09h, 1Ah, 21h, 02h, 09h, 09h
        db   1Eh, 1Fh, 02h, 04h, 09h, 2Ah, 2Bh, 06h, 0Ah, 0Ah, 24h, 2Bh, 02h, 0Ah, 0Eh, 22h
        db   23h, 0Bh, 0Bh, 0Bh, 1Ch, 1Dh, 0Bh, 0Dh, 0Dh, 1Ch, 1Dh, 0Bh, 0Fh, 0Fh, 20h, 23h
        db   06h, 0Fh, 0Fh, 1Eh, 1Fh, 02h, 0Fh, 0Fh, 1Ch, 1Dh, 06h, 10h, 10h, 1Eh, 23h, 01h
        db   10h, 10h, 1Ch, 1Dh, 02h, 10h, 11h, 1Ah, 1Bh, 01h, 11h, 11h, 1Ch, 27h, 02h, 0Ch
        db   0Eh, 26h, 27h, 06h, 11h, 11h, 24h, 25h, 06h, 0Ch, 0Ch, 28h, 29h, 01h, 0Fh, 0Fh
        db   26h, 27h, 06h, 0Fh, 0Fh, 28h, 2Fh, 06h, 11h, 11h, 28h, 2Fh, 06h, 12h, 12h, 12h
        db   19h, 01h, 13h, 13h, 12h, 27h, 06h, 13h, 13h, 0Eh, 11h, 06h, 13h, 13h, 14h, 19h
        db   06h, 13h, 13h, 24h, 25h, 06h, 13h, 13h, 28h, 29h, 02h, 13h, 14h, 1Ch, 1Dh, 0Bh
        db   0Dh, 0Dh, 2Ah, 2Bh, 0Bh, 0Fh, 0Fh, 2Ah, 2Bh, 0Bh, 11h, 11h, 2Ah, 2Bh, 0Bh, 13h
        db   13h, 2Ah, 2Bh, 02h, 11h, 11h, 30h, 31h, 0Bh, 11h, 11h, 32h, 33h, 0Bh, 11h, 11h
        db   36h, 37h, 02h, 11h, 12h, 38h, 39h, 0Bh, 13h, 13h, 36h, 39h, 06h, 13h, 13h, 34h
        db   35h, 02h, 13h, 14h, 32h, 33h, 07h, 02h, 0Eh, 34h, 35h, 0Bh, 03h, 03h, 30h, 37h
        db   0Bh, 05h, 05h, 32h, 37h, 0Bh, 09h, 09h, 32h, 37h, 0Bh, 07h, 07h, 32h, 37h, 0Bh
        db   0Bh, 0Bh, 32h, 37h, 0Bh, 0Dh, 0Dh, 32h, 37h, 0Bh, 0Fh, 0Fh, 30h, 37h, 02h, 02h
        db   03h, 2Eh, 2Fh, 02h, 03h, 03h, 34h, 35h, 02h, 03h, 04h, 38h, 39h, 02h, 05h, 06h
        db   30h, 31h, 02h, 05h, 05h, 34h, 35h, 02h, 07h, 07h, 34h, 35h, 02h, 07h, 08h, 38h
        db   39h, 02h, 09h, 09h, 34h, 35h, 02h, 09h, 0Ah, 30h, 31h, 02h, 0Bh, 0Bh, 34h, 35h
        db   02h, 0Bh, 0Ch, 38h, 39h, 02h, 0Dh, 0Dh, 34h, 35h, 02h, 0Dh, 0Eh, 30h, 31h, 02h
        db   0Fh, 0Fh, 34h, 35h, 01h, 01h, 01h, 32h, 33h, 01h, 01h, 01h, 36h, 3Bh, 01h, 02h
        db   02h, 2Ch, 2Dh, 07h, 02h, 02h, 0Ah, 0Bh, 07h, 02h, 02h, 10h, 11h, 07h, 01h, 01h
        db   12h, 13h, 07h, 06h, 06h, 0Ch, 0Dh, 07h, 08h, 08h, 0Ch, 0Dh, 07h, 06h, 06h, 18h
        db   19h, 07h, 06h, 06h, 1Eh, 1Fh, 07h, 06h, 06h, 26h, 27h, 07h, 08h, 08h, 1Ch, 1Dh
        db   07h, 08h, 08h, 20h, 21h, 07h, 0Ah, 0Ah, 1Ch, 1Dh, 07h, 0Ch, 0Ch, 1Ch, 1Dh, 07h
        db   0Bh, 0Bh, 0Eh, 0Fh, 07h, 0Ch, 0Ch, 0Ah, 0Bh, 07h, 0Ch, 0Ch, 2Ah, 2Bh, 07h, 0Eh
        db   0Eh, 2Ah, 2Bh, 07h, 10h, 10h, 2Ah, 2Bh, 07h, 12h, 12h, 2Ah, 2Bh, 07h, 12h, 12h
        db   1Ch, 1Dh, 07h, 12h, 12h, 20h, 21h, 07h, 14h, 14h, 10h, 11h, 08h, 12h, 12h, 1Ch
        db   1Ch, 03h, 11h, 11h, 12h, 13h, 04h, 12h, 12h, 1Ah, 1Bh, 04h, 12h, 12h, 1Eh, 1Eh
        db   03h, 12h, 12h, 32h, 33h, 09h, 02h, 02h, 33h, 33h, 00h
        ; (gap 0x323B-0x324F)
        db   15h, 06h, 00h, 11h, 00h, 34h, 00h, 00h, 00h, 00h, 02h, 00h, 0Eh, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h
        ; --- level 18 (0x3250) ---
        db   01h, 01h, 17h, 00h, 05h, 01h, 16h, 17h, 00h, 3Fh, 01h, 01h, 17h, 3Ch, 3Fh, 05h
        db   16h, 16h, 06h, 09h, 05h, 16h, 16h, 38h, 3Bh, 01h, 0Eh, 14h, 0Ch, 35h, 02h, 0Eh
        db   15h, 0Ah, 0Bh, 02h, 04h, 0Eh, 06h, 07h, 06h, 0Fh, 0Fh, 06h, 09h, 05h, 0Fh, 0Fh
        db   0Eh, 1Fh, 05h, 0Fh, 0Fh, 22h, 33h, 0Bh, 04h, 08h, 08h, 11h, 02h, 04h, 04h, 10h
        db   11h, 01h, 05h, 07h, 08h, 09h, 01h, 05h, 06h, 10h, 11h, 07h, 05h, 07h, 0Ah, 0Fh
        db   01h, 09h, 0Ch, 08h, 09h, 06h, 09h, 09h, 0Ah, 0Fh, 01h, 09h, 0Ch, 10h, 11h, 07h
        db   0Ah, 0Ch, 0Ah, 0Fh, 06h, 08h, 08h, 12h, 1Bh, 0Bh, 09h, 09h, 14h, 15h, 01h, 0Ah
        db   0Dh, 14h, 15h, 02h, 0Ah, 0Dh, 16h, 17h, 01h, 0Dh, 0Dh, 18h, 1Bh, 06h, 0Eh, 0Eh
        db   1Eh, 23h, 02h, 01h, 0Eh, 20h, 21h, 06h, 08h, 08h, 26h, 2Fh, 0Bh, 09h, 09h, 2Ch
        db   2Dh, 02h, 0Ah, 0Dh, 2Ah, 2Bh, 01h, 0Dh, 0Dh, 26h, 29h, 01h, 0Ah, 0Dh, 2Ch, 2Dh
        db   0Bh, 04h, 08h, 30h, 39h, 02h, 04h, 04h, 30h, 31h, 01h, 05h, 06h, 30h, 31h, 01h
        db   05h, 07h, 38h, 39h, 07h, 05h, 07h, 32h, 37h, 02h, 04h, 0Eh, 3Ah, 3Bh, 06h, 0Fh
        db   0Fh, 38h, 3Bh, 01h, 09h, 0Ch, 30h, 39h, 06h, 09h, 09h, 32h, 37h, 07h, 0Ah, 0Ch
        db   32h, 37h, 02h, 0Eh, 15h, 36h, 37h, 1Bh, 10h, 12h, 0Eh, 33h, 01h, 01h, 01h, 06h
        db   1Fh, 01h, 01h, 01h, 21h, 3Bh, 00h
        ; --- post-level tail ---
        db   15h, 20h, 02h, 18h, 02h, 29h, 00h, 00h, 00h, 00h, 02h, 00h, 20h, 00h, 00h, 00h
        db   00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

