        org  0000h
        section KLAD.bin

        lxi  sp, 00FFh
        jmp  loc_1605
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
        call 0F809h
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
        call loc_01A0
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
        call 08BEh
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
        call loc_11C4
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

loc_01A0:
        push psw
        push h
        push d
        mov  e, a
        mvi  d, 00h
        lxi  h, 01B2h
        dad  d
        mov  a, m
        sta  019Eh
        pop  d
        pop  h
        pop  psw
        ret

tbl_01B2:                               ; byte LUT for loc_01A0 (indexed by E, 30 entries)
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

loc_088E:
        lxi  h, 0243h
        lxi  d, 0882h
loc_0894:
        xra  a
        mov  m, a
        inx  h
        mov  a, e
        sub  l
        mov  a, d
        sbb  h
        jnc  loc_0894
        ret
loc_089F:
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
        rrc
        inr  b
        lxi  b, 002Eh
        nop
        nop
        nop
        nop
        nop
        nop
        lxi  b, 0F535h
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
        call 08BEh
        mov  a, m
        cpi  02h
        jz   loc_0961
        inr  b
        call 08BEh
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
        call 08BEh
        mov  a, m
        call loc_11C4
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
        call loc_11C4
        sta  0AD7h
        call 08BEh
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
        call 08BEh
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
        call loc_1896
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
        call 08BEh
        mov  a, m
        call loc_11C4
        dcr  c
        mvi  a, 13h
        call loc_11C4
        mov  a, c
        sta  0AD5h
        ret
loc_09E3:
        inr  c
        call 08BEh
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
        call loc_1896
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
        call 08BEh
        mov  a, m
        call loc_11C4
        inr  c
        mvi  a, 13h
        call loc_11C4
        mov  a, c
        sta  0AD5h
        jmp  loc_0AD3
loc_0A49:
        call 08BEh
        mov  a, m
        cpi  02h
        jnz  loc_0AD3
        dcr  b
        call 08BEh
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
        call loc_1896
        jmp  loc_0A7F
loc_0A7A:
        cpi  0Eh
        jc   loc_0AD3
loc_0A7F:
        inr  b
        call 08BEh
        mov  a, m
        call loc_11C4
        dcr  b
        mvi  a, 13h
        call loc_11C4
        mov  a, b
        sta  0AD4h
        jmp  loc_0AD3
loc_0A94:
        inr  b
        call 08BEh
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
        call loc_1896
        jmp  loc_0AC1
loc_0ABC:
        cpi  0Eh
        jc   loc_0AD3
loc_0AC1:
        dcr  b
        call 08BEh
        mov  a, m
        call loc_11C4
        inr  b
        mvi  a, 13h
        call loc_11C4
        mov  a, b
        sta  0AD4h
loc_0AD3:
        ret
        dcr  d
        db   08h
        lxi  b, 3A00h
        nop
loc_0ADA:
        xra  a
        sta  0AD9h
        call loc_088E
        call loc_0100
        call loc_089F
        lda  08B1h
        sta  0AD4h
        lda  08B2h
        sta  0AD5h
        call loc_1586
        call loc_1168
loc_0AF9:
        call 0F81Bh
        sta  0AD8h
        call loc_08EB
        call loc_1039
        call loc_1181
        call loc_15A1
        call loc_1546
        call loc_1546
        call loc_15C7
        lda  11C3h
        ora  a
        jnz  loc_0ADA
        lda  0AD4h
        mov  b, a
        lda  0AD5h
        mov  c, a
        call 08BEh
        mov  a, m
        cpi  05h
        jz   loc_0ADA
        mov  a, b
        cpi  18h
        jnc  loc_0ADA
        jmp  loc_0AF9
        lxi  b, 1601h
        nop
        lxi  b, 1601h
        mvi  d, 00h
        cmc
        lxi  b, 1401h
        inx  b
        inx  b
        lxi  b, 1601h
        mvi  e, 1Fh
        dcr  b
        mvi  d, 16h
        ldax b
        ral
        dcx  b
        lxi  b, 0401h
        dcr  e
        stax b
        stax d
        dcr  d
        dad  b
        dad  b
        dcx  b
        inr  d
        inr  d
        ldax b
        inx  d
        lxi  b, 1717h
        nop
        cmc
        mvi  b, 14h
        inr  d
        mvi  c, 0Eh
        mvi  b, 14h
        inr  d
        stax d
        stax d
        mvi  b, 12h
        stax d
        db   08h
        db   08h
        dcx  b
        stax d
        stax d
        ldax b
        inr  d
        mvi  b, 12h
        stax d
        mvi  c, 0Eh
        mvi  b, 12h
        stax d
        stax d
        stax d
        dcx  b
        db   10h
        db   10h
        db   08h
        dcr  c
        mvi  b, 10h
        db   10h
        mvi  c, 0Eh
        stax b
        mvi  c, 0Fh
        dad  b
        dad  b
        dcx  b
        mvi  c, 0Eh
        inr  b
        db   08h
        mvi  b, 0Eh
        mvi  c, 05h
        mvi  b, 02h
        inx  b
        dcr  c
        inr  b
        inr  b
        rlc
        db   10h
        db   10h
        inr  b
        inr  b
        rlc
        stax d
        stax d
        inr  b
        inr  b
        dcx  b
        lxi  d, 0411h
        dcr  b
        dcx  b
        inx  d
        inx  d
        inr  b
        mvi  b, 0Bh
        inr  c
        inr  c
        rlc
        lxi  d, 0C06h
        inr  c
        inr  c
        inr  c
        rlc
        dcx  b
        dcx  b
        lxi  d, 0B11h
        inr  c
        inr  c
        inx  d
        mvi  d, 07h
        dcx  b
        dcx  b
        inx  d
        inx  d
        stax b
        inr  c
        lxi  d, 0F0Fh
        dcx  b
        dad  b
        dad  b
        mvi  b, 0Eh
        mvi  b, 09h
        dad  b
        inr  c
        inr  c
        dcx  b
        ldax b
        ldax b
        mvi  c, 15h
        rlc
        dad  b
        dad  b
        lxi  d, 0211h
        inx  b
        dcx  b
        dad  b
        dad  b
        dcx  b
        inx  b
        dcr  b
        dcr  b
        mvi  b, 0Bh
        dcr  b
        dcr  b
        db   08h
        db   08h
        mvi  b, 05h
        dcr  b
        rlc
        rlc
        dcx  b
        inr  b
        inr  b
        ldax b
        dcr  e
        dcx  b
        inx  b
        inx  b
        ldax b
        dcx  b
        mvi  b, 04h
        inr  b
        inr  c
        inr  c
        dcx  b
        inx  b
        inx  b
        inr  d
        db   18h
        stax b
        inx  b
        inx  b
        inx  d
        inx  d
        mvi  b, 04h
        inr  b
        dad  d
        dad  d
        stax b
        inr  b
        mvi  b, 0Eh
        mvi  c, 08h
        mvi  b, 06h
        dcr  c
        dcr  c
        dcx  b
        rlc
        rlc
        dcr  c
        dcr  d
        dcx  b
        db   08h
        db   08h
        dcr  d
        ral
        stax b
        mvi  b, 07h
        mvi  d, 16h
        stax b
        db   08h
        mvi  c, 18h
        db   18h
        dcx  b
        rrc
        rrc
        db   10h
        db   18h
        dcx  b
        mvi  c, 0Eh
        inx  d
        dcr  d
        mvi  b, 0Fh
        rrc
        stax d
        stax d
        mvi  b, 0Fh
        rrc
        mvi  d, 16h
        stax b
        lxi  b, 1C0Dh
        inr  e
        ldax b
        dcr  b
        dcr  b
        db   18h
        db   18h
        dcx  b
        mvi  b, 06h
        ral
        inr  e
        mvi  b, 09h
        dad  b
        dad  d
        dcx  d
        dcx  b
        mvi  c, 0Eh
        inr  e
        inr  e
        stax b
        mvi  c, 12h
        dcx  d
        dcx  d
        dcx  b
        lxi  d, 1711h
        dad  d
        dcx  b
        inx  d
        inx  d
        mvi  d, 1Bh
        stax b
        lxi  d, 1815h
        db   18h
        dcx  b
        lxi  d, 1D15h
        dcr  e
        rlc
        db   10h
        db   10h
        dcr  e
        dcr  e
        dcx  b
        lxi  d, 1C11h
        inr  e
        rlc
        inr  d
        inr  d
        inr  e
        inr  e
        dcx  b
        dcr  d
        dcr  d
        dcx  d
        inr  e
        dcx  b
        mvi  d, 16h
        shld 053Dh
        mvi  d, 16h
        db   38h
        inr  a
        lxi  b, 1601h
        mvi  a, 3Fh
        lxi  b, 0101h
        lxi  sp, 013Dh
        lxi  b, 2201h
        mvi  l, 01h
        lxi  b, 2114h
        lxi  h, 0302h
        dcr  d
        shld 0122h
        lxi  d, 2312h
        sta  1105h
        lxi  d, 3126h
        lxi  b, 100Fh
        sta  0632h
        rrc
        rrc
        lxi  sp, 0B31h
        rrc
        rrc
        inr  l
        db   30h
        dcx  b
        rrc
        rrc
        inr  h
        lhld 0F06h
        rrc
        dcr  h
        daa
        stax b
        dad  b
        mvi  c, 24h
        inr  h
        dcx  b
        dad  b
        dad  b
        dcr  h
        dcr  h
        mvi  b, 09h
        dad  b
        mvi  h, 26h
        dcx  b
        inx  b
        dcr  b
        inx  h
        dcr  h
        rlc
        inr  b
        inr  b
        inr  h
        inr  h
        mvi  b, 04h
        inr  b
        mvi  h, 27h
        rlc
        mvi  b, 06h
        dcr  h
        dcr  h
        dcx  b
        rlc
        rlc
        dcr  h
        dcr  h
        lxi  b, 0D0Dh
        mvi  h, 30h
        mvi  b, 0Dh
        dcr  c
        db   28h
        db   28h
        mvi  b, 0Dh
        dcr  c
        inr  l
        inr  l
        stax b
        mvi  b, 0Ch
        db   30h
        db   30h
        lxi  b, 0B06h
        cma
        cma
        mvi  b, 06h
        mvi  b, 2Ch
        mvi  l, 01h
        db   08h
        db   08h
        dcr  l
        dcr  l
        stax b
        db   08h
        ldax b
        mvi  l, 2Eh
        dcx  b
        dcx  b
        dcx  b
        daa
        mvi  l, 06h
        dcx  b
        dcx  b
        db   28h
        db   28h
        mvi  b, 0Bh
        dcx  b
        inr  l
        inr  l
        dcx  b
        stax b
        stax b
        daa
        db   28h
        lxi  b, 0802h
        dad  h
        dad  h
        dcx  b
        inx  b
        dcr  b
        dad  h
        dad  h
        mvi  b, 05h
        dcr  b
        daa
        db   28h
        stax b
        inx  b
        db   08h
        lhld 0B2Ah
        dad  b
        dad  b
        dad  h
        dcx  h
        mvi  b, 09h
        dad  b
        inr  l
        inr  l
        dcx  b
        inx  b
        inr  b
        dcx  h
        dcx  h
        lxi  b, 0302h
        inr  l
        inr  l
        db   08h
        stax b
        stax b
        dcx  h
        dcx  h
        rlc
        inx  b
        inx  b
        dcr  l
        dcr  l
        mvi  b, 04h
        inr  b
        dcr  l
        mvi  l, 0Bh
        inx  b
        inr  b
        cma
        lxi  sp, 040Bh
        inr  b
        inx  sp
        dcr  m
        dcx  b
        dcr  b
        dcr  b
        inx  sp
        inr  m
        dcx  b
        mvi  b, 06h
        inr  m
        dcx  sp
        mvi  b, 06h
        mvi  b, 36h
        mvi  m, 0Ah
        dcr  b
        dcr  b
        stc
        stc
        dcx  b
        stax b
        stax b
        inr  m
        db   38h
        dcx  b
        inx  b
        inx  b
        db   38h
        dcr  a
        dcx  b
        inr  b
        inr  b
        stc
        db   38h
        stax b
        inx  b
        dcr  b
        dad  sp
        dad  sp
        stax b
        lxi  b, 3C02h
        inr  a
        stax b
        inx  b
        db   08h
        sta  0632h
        db   08h
        db   08h
        inx  sp
        inr  a
        stax b
        dcr  b
        dcr  d
        dcr  a
        dcr  a
        mvi  b, 14h
        inr  d
        stc
        inr  a
        dcx  b
        inr  d
        inr  d
        inr  h
        dcr  m
        lxi  b, 1515h
        lhld 022Ah
        inr  d
        inr  d
        dcx  h
        dcx  h
        dcx  b
        inx  d
        inx  d
        inr  m
        inr  m
        lxi  b, 1211h
        inr  m
        inr  m
        rlc
        db   10h
        db   10h
        inr  m
        inr  m
        dcx  b
        ldax b
        mvi  c, 34h
        stc
        dcx  b
        ldax b
        ldax b
        sta  0B33h
        inr  c
        dcr  c
        inx  sp
        inx  sp
        mvi  b, 0Ch
        inr  c
        sta  0732h
        dcx  b
        dcx  b
        inx  sp
        inx  sp
        lxi  b, 0B0Bh
        dcr  m
        dcr  m
        lxi  b, 0E0Eh
        dcr  m
        dcr  m
        dcx  b
        ldax b
        ldax b
        db   38h
        db   38h
        lxi  b, 0B0Ah
        dad  sp
        dcx  sp
        dcr  b
        ldax b
        ldax b
        lda  063Ah
        ldax b
        ldax b
        inr  a
        inr  a
        mvi  b, 0Eh
        mvi  c, 38h
        db   38h
        dcx  b
        inr  c
        rrc
        dad  sp
        dcx  sp
        rlc
        dcr  c
        dcr  c
        lda  0B3Ah
        db   10h
        db   10h
        lda  073Bh
        lxi  d, 3B11h
        dcx  sp
        dcx  b
        db   10h
        db   10h
        db   38h
        db   38h
        dcx  b
        lxi  d, 3811h
        dad  sp
        dcx  b
        stax d
        stax d
        db   38h
        dcx  sp
        stax b
        ldax b
        dcr  d
        mvi  m, 36h
        nop
        lxi  b, 0102h
        db   30h
        lxi  b, 022Fh
        ldax d
        nop
        nop
        inx  b
        lxi  b, 3A3Ch
        xra  d
        rrc
        mov  b, a
        lda  0FABh
        mov  c, a
        call 08BEh
        mov  a, m
        cpi  02h
        jz   loc_0E9A
        inr  b
        call 08BEh
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
        call 08BEh
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
        call 08BEh
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
        call 08BEh
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
        call 08BEh
        mov  a, m
        cpi  02h
        jnz  loc_0F6F
        dcr  b
        call 08BEh
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
        call 08BEh
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
        dcr  b
        db   08h
        nop
        stax b
        dcr  b
        db   08h
        dcr  b
        db   08h
        nop
        stax b
        nop
        nop
        nop
        lxi  b, 0000h
        nop
        stax b
        nop
        nop
        nop
        nop
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
        call 08BEh
        mov  a, m
        call loc_11C4
        lda  0FAEh
        mov  b, a
        lda  0FAFh
        mov  c, a
        mvi  a, 14h
        call loc_11C4
        ret
loc_1021:
        lda  0FAEh
        mov  b, a
        lda  0FAFh
        mov  c, a
        call 08BEh
        mov  a, m
        cpi  05h
        jnz  loc_1037
        call loc_11C4
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
        nop
        nop
        nop
        nop
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
        sta  11C3h
        ret
loc_11BE:
        mvi  a, 01h
        jmp  loc_11BA
        nop
loc_11C4:
        push psw
        push d
        push h
        call loc_01A0
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
        lda  019Eh
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
        jmp  loc_11C4
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
        call 08BEh
        mvi  a, 0Bh
        mov  m, a
        call loc_11C4
        jmp  loc_13B0
loc_13F4:
        cpi  1Eh
        jnc  loc_1409
        inx  h
        mov  b, m
        inx  h
        mov  c, m
        call 08BEh
        mvi  a, 0Ch
        mov  m, a
        call loc_11C4
        jmp  loc_13B0
loc_1409:
        cpi  3Ch
        jnc  loc_141E
        inx  h
        mov  b, m
        inx  h
        mov  c, m
        call 08BEh
        mvi  a, 0Dh
        mov  m, a
        call loc_11C4
        jmp  loc_13B0
loc_141E:
        ori  80h
        mov  m, a
        inx  h
        mov  b, m
        inx  h
        mov  c, m
        call 08BEh
        mvi  a, 0Eh
        mov  m, a
        call loc_11C4
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
        call 08BEh
        mvi  a, 10h
        mov  m, a
        call loc_11C4
        jmp  loc_13B0
loc_144B:
        cpi  3Ch
        jnc  loc_141E
        inx  h
        mov  b, m
        inx  h
        mov  c, m
        call 08BEh
        mvi  a, 0Fh
        mov  m, a
        call loc_11C4
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
        call 08BEh
        mov  a, m
        call loc_11C4
        dcr  c
        mov  h, c
        mov  l, b
        shld 159Dh
        call 08BEh
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
        jmp  loc_11C4
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
        call 08BEh
        mov  a, m
        call loc_11C4
        inr  c
        mov  l, b
        mov  h, c
        shld 159Fh
        call 08BEh
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
        jmp  loc_11C4
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
        nop
        nop
        lxi  d, 0B1Dh
        inr  d
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
        jz   0F800h
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
        sta  11C3h
        ret
loc_1605:
        lxi  b, 0ADAh
        push b
        lxi  h, 1612h
        call 0F818h
        jmp  0F803h

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

loc_1896:
        lda  0AD9h
        inr  a
        sta  0AD9h
        mvi  m, 12h
        push b
        mvi  c, 07h
        call 0F809h
        pop  b
        ret
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        lxi  b, 1701h
        nop
        inx  b
        lxi  b, 1716h
        nop
        cmc
        lxi  b, 1701h
        inr  a
        cmc
        dcr  b
        mvi  d, 16h
        stax d
        dcx  sp
        stax b
        stax d
        dcr  d
        mvi  c, 0Fh
        dcx  b
        stax d
        stax d
        ldax b
        dcr  c
        rlc
        lxi  d, 0A11h
        ldax b
        dcx  b
        stax d
        stax d
        db   10h
        dad  d
        stax b
        mvi  c, 11h
        inr  d
        dcr  d
        dcx  b
        mvi  c, 0Eh
        mvi  d, 1Dh
        stax b
        ldax b
        dcr  c
        inr  e
        dcr  e
        dcx  b
        ldax b
        ldax b
        mvi  e, 29h
        stax b
        ldax b
        lxi  d, 2726h
        dcx  b
        stax d
        stax d
        mvi  e, 29h
        rlc
        lxi  d, 1E11h
        mvi  e, 0Bh
        mvi  c, 0Eh
        db   28h
        cma
        stax b
        mvi  c, 11h
        db   30h
        lxi  sp, 0907h
        dad  b
        mvi  e, 1Eh
        dcx  b
        stax d
        stax d
        db   30h
        stc
        stax b
        ldax b
        lxi  d, 3736h
        dcx  b
        ldax b
        ldax b
        db   30h
        dcr  m
        rlc
        dad  b
        dad  b
        db   30h
        db   30h
        stax b
        mvi  b, 09h
        sta  0B33h
        mvi  b, 06h
        stax d
        lxi  sp, 0606h
        mvi  b, 1Eh
        daa
        stax b
        mvi  b, 09h
        inr  d
        dcr  d
        dcx  b
        ldax b
        ldax b
        ldax b
        dcr  d
        rlc
        dad  b
        dad  b
        ldax b
        ldax b
        stax b
        ldax b
        dcr  c
        inr  c
        dcr  c
        dcx  b
        mvi  c, 0Eh
        inr  b
        dcr  c
        dcx  b
        mvi  b, 06h
        inr  b
        dcx  b
        stax b
        mvi  b, 0Dh
        mvi  b, 07h
        dcx  b
        inx  b
        inx  b
        inr  c
        dcr  m
        mvi  b, 03h
        inx  b
        inr  d
        dad  d
        rlc
        stax b
        stax b
        db   20h
        db   20h
        mvi  b, 03h
        inx  b
        mvi  h, 2Bh
        dcx  b
        lxi  b, 0401h
        dcr  l
        dcx  b
        lxi  b, 3001h
        dcx  sp
        stax b
        lxi  b, 3502h
        dcr  m
        stax b
        inx  b
        dcr  b
        ldax b
        dcx  b
        nop
        rrc
        inr  b
        lxi  b, 002Eh
        nop
        nop
        nop
        nop
        nop
        nop
        lxi  b, 0035h
        lxi  b, 1701h
        nop
        inx  b
        lxi  b, 1715h
        nop
        cmc
        lxi  b, 1701h
        lda  053Fh
        dcr  d
        mvi  d, 08h
        dad  sp
        lxi  b, 1515h
        inr  c
        dcr  c
        lxi  b, 1515h
        stax d
        inx  d
        lxi  b, 1515h
        db   18h
        dad  d
        lxi  b, 1515h
        mvi  e, 1Fh
        lxi  b, 1515h
        inr  h
        dcr  h
        lxi  b, 1515h
        lhld 012Bh
        dcr  d
        dcr  d
        db   30h
        lxi  sp, 1501h
        dcr  d
        mvi  m, 37h
        stax b
        inr  b
        inr  d
        mvi  b, 07h
        stax b
        inx  b
        inr  d
        inr  c
        dcr  c
        stax b
        inr  b
        inr  d
        stax d
        inx  d
        stax b
        inx  b
        inr  d
        db   18h
        dad  d
        stax b
        inr  b
        inr  d
        mvi  e, 1Fh
        stax b
        inx  b
        inr  d
        inr  h
        dcr  h
        stax b
        inr  b
        inr  d
        lhld 022Bh
        inx  b
        inr  d
        db   30h
        lxi  sp, 0402h
        inr  d
        mvi  m, 37h
        stax b
        inx  b
        inx  b
        db   08h
        dcr  m
        stax b
        mvi  b, 06h
        mvi  b, 37h
        stax b
        dad  b
        dad  b
        db   08h
        dcr  m
        stax b
        inr  c
        inr  c
        mvi  b, 35h
        stax b
        rrc
        rrc
        mvi  b, 36h
        stax b
        stax d
        stax d
        mvi  b, 36h
        lxi  b, 0401h
        db   38h
        lda  030Ah
        inx  b
        dad  sp
        dad  sp
        stax b
        inx  b
        inx  b
        db   38h
        db   38h
        stax b
        lxi  b, 3A03h
        lda  0307h
        inx  b
        mvi  b, 07h
        rlc
        inx  b
        inx  b
        stax d
        inx  d
        rlc
        inx  b
        inx  b
        mvi  e, 1Fh
        rlc
        inx  b
        inx  b
        lhld 072Bh
        inx  b
        inx  b
        mvi  m, 37h
        rlc
        mvi  b, 06h
        inr  c
        dcr  c
        rlc
        mvi  b, 06h
        db   18h
        dad  d
        rlc
        mvi  b, 06h
        inr  h
        dcr  h
        rlc
        mvi  b, 06h
        db   30h
        lxi  sp, 0907h
        dad  b
        mvi  b, 07h
        rlc
        dad  b
        dad  b
        stax d
        inx  d
        rlc
        dad  b
        dad  b
        mvi  e, 1Fh
        rlc
        dad  b
        dad  b
        lhld 072Bh
        dad  b
        dad  b
        mvi  m, 37h
        rlc
        inr  c
        inr  c
        inr  c
        dcr  c
        rlc
        inr  c
        inr  c
        db   18h
        dad  d
        rlc
        inr  c
        inr  c
        inr  h
        dcr  h
        rlc
        inr  c
        inr  c
        db   30h
        lxi  sp, 0F07h
        rrc
        mvi  b, 07h
        rlc
        rrc
        rrc
        stax d
        inx  d
        rlc
        rrc
        rrc
        mvi  e, 1Fh
        rlc
        rrc
        rrc
        lhld 072Bh
        rrc
        rrc
        mvi  m, 37h
        rlc
        stax d
        stax d
        inr  c
        dcr  c
        rlc
        stax d
        stax d
        db   18h
        dad  d
        rlc
        stax d
        stax d
        inr  h
        dcr  h
        rlc
        stax d
        stax d
        db   30h
        lxi  sp, 0908h
        dad  b
        mvi  e, 1Eh
        nop
        rlc
        inr  b
        lxi  b, 010Dh
        db   30h
        nop
        nop
        nop
        nop
        stax b
        lxi  b, 003Ah
        nop
        nop
        lxi  b, 1701h
        nop
        cmc
        mvi  c, 01h
        lxi  b, 0B0Ah
        mvi  c, 05h
        dcr  b
        mvi  b, 09h
        mvi  c, 11h
        lxi  d, 0906h
        mvi  c, 15h
        dcr  d
        mvi  b, 10h
        rlc
        dcr  c
        dcr  c
        mvi  b, 09h
        mvi  c, 09h
        dad  b
        inr  c
        dcr  d
        mvi  c, 05h
        dcr  b
        stax d
        dcx  d
        mvi  c, 02h
        stax b
        mvi  e, 21h
        rlc
        stax b
        stax b
        inr  c
        rrc
        rlc
        dcr  c
        dcr  c
        inr  h
        daa
        mvi  c, 0Dh
        dcr  c
        db   18h
        dcx  d
        mvi  c, 11h
        lxi  d, 1512h
        mvi  c, 11h
        lxi  d, 271Ah
        rlc
        dcr  d
        dcr  d
        db   18h
        dcx  d
        mvi  c, 15h
        dcr  d
        mvi  e, 21h
        rlc
        dad  b
        dad  b
        mvi  e, 21h
        mvi  c, 05h
        dcr  b
        inr  h
        daa
        rlc
        stax b
        stax b
        lhld 0E2Dh
        dad  b
        dad  b
        lhld 0E33h
        dcr  c
        dcr  c
        db   30h
        inx  sp
        rlc
        dcr  b
        dcr  b
        db   30h
        inx  sp
        mvi  c, 01h
        lxi  b, 3534h
        mvi  c, 11h
        lxi  d, 3330h
        rlc
        dcr  d
        dcr  d
        lhld 072Dh
        dcr  d
        dcr  d
        mvi  m, 39h
        stax b
        rlc
        dcr  d
        inr  b
        dcr  b
        stax b
        stax b
        dcr  b
        inr  b
        dcr  b
        stax b
        stax b
        dad  b
        ldax b
        dcx  b
        stax b
        dcx  b
        dcr  c
        ldax b
        dcx  b
        stax b
        rrc
        lxi  d, 0B0Ah
        stax b
        inx  d
        dcr  d
        ldax b
        dcx  b
        stax b
        stax b
        dcr  b
        db   10h
        lxi  d, 0702h
        dcr  c
        db   10h
        lxi  d, 0F02h
        dcr  d
        db   10h
        lxi  d, 0202h
        dcr  b
        mvi  d, 17h
        stax b
        rlc
        dcr  d
        mvi  d, 17h
        stax b
        stax b
        dad  b
        inr  e
        dcr  e
        stax b
        dcx  b
        dcr  d
        inr  e
        dcr  e
        stax b
        stax b
        dcr  b
        shld 0223h
        rlc
        dad  b
        shld 0223h
        dcx  b
        dcr  c
        shld 0223h
        rrc
        lxi  d, 2322h
        stax b
        inx  d
        dcr  d
        shld 0223h
        stax b
        dcr  c
        db   28h
        dad  h
        stax b
        rrc
        dcr  d
        db   28h
        dad  h
        stax b
        stax b
        dcr  b
        mvi  l, 2Fh
        stax b
        rlc
        dad  b
        mvi  l, 2Fh
        stax b
        dcx  b
        lxi  d, 2F2Eh
        stax b
        inx  d
        dcr  d
        mvi  l, 2Fh
        stax b
        stax b
        dcr  b
        inr  m
        dcr  m
        stax b
        rlc
        dcr  c
        inr  m
        dcr  m
        stax b
        rrc
        dcr  d
        inr  m
        dcr  m
        rlc
        dcr  d
        dcr  d
        mvi  m, 39h
        stax b
        lxi  b, 3A15h
        lda  1500h
        mvi  b, 01h
        ldax b
        lxi  b, 0034h
        nop
        nop
        nop
        stax b
        lxi  b, 013Ah
        lxi  b, 0017h
        inx  b
        lxi  b, 1716h
        nop
        cmc
        lxi  b, 1701h
        lda  013Fh
        ldax b
        ldax b
        nop
        cmc
        lxi  b, 0E0Eh
        nop
        cmc
        lxi  b, 1212h
        nop
        cmc
        dcx  b
        lxi  b, 0402h
        stc
        mvi  b, 03h
        inx  b
        inr  c
        dcr  m
        lxi  b, 0606h
        db   08h
        lda  0B01h
        inr  c
        ldax b
        dcx  b
        lxi  b, 150Bh
        stax d
        inx  d
        lxi  b, 150Bh
        shld 0123h
        dcx  b
        dcr  d
        sta  0133h
        rrc
        dcr  d
        lhld 0133h
        ldax b
        inr  c
        shld 062Bh
        inr  d
        inr  d
        inr  b
        dad  b
        mvi  b, 10h
        db   10h
        inr  b
        dad  b
        stax b
        mvi  c, 15h
        mvi  b, 07h
        dcx  b
        rrc
        lxi  d, 0B0Ah
        dcx  b
        inx  d
        inr  d
        ldax b
        dcx  b
        inr  b
        dcr  d
        dcr  d
        ldax b
        ldax b
        stax b
        db   10h
        dcr  d
        mvi  c, 0Fh
        inx  b
        dcr  d
        dcr  d
        inx  d
        inx  d
        rlc
        lxi  d, 1111h
        lxi  d, 0A05h
        ldax b
        stax b
        dcr  b
        ldax d
        dcx  b
        dcx  b
        stax b
        dcr  b
        lxi  b, 0C0Ch
        nop
        rlc
        lxi  b, 0B0Bh
        mvi  b, 07h
        stax b
        ldax b
        dcr  c
        mvi  c, 0Fh
        inr  b
        dcr  c
        dcr  c
        ldax b
        ldax b
        inx  b
        dcr  c
        dcr  c
        inx  d
        inx  d
        rlc
        dad  b
        dad  b
        mvi  b, 09h
        inx  b
        dad  b
        dad  b
        ldax b
        ldax b
        stax b
        stax d
        inx  d
        inr  d
        dcr  d
        mvi  b, 14h
        inr  d
        mvi  d, 1Fh
        rlc
        inx  d
        inx  d
        db   20h
        db   20h
        dcx  b
        dcr  d
        dcr  d
        mvi  d, 23h
        mvi  c, 0Dh
        dcr  c
        stax d
        stax d
        mvi  c, 15h
        dcr  d
        stax d
        stax d
        lxi  b, 0808h
        mvi  b, 23h
        rlc
        lxi  d, 1811h
        db   18h
        dcx  b
        mvi  c, 0Eh
        db   18h
        cma
        lxi  b, 0D0Ch
        db   18h
        dcx  d
        dcx  b
        dcr  c
        dcr  c
        ldax d
        dcx  d
        lxi  b, 120Fh
        ldax d
        dcx  d
        mvi  b, 0Fh
        rrc
        inr  e
        lxi  h, 1005h
        db   10h
        inr  e
        lxi  h, 111Ah
        lxi  d, 211Ch
        stax b
        ldax b
        dcx  b
        ldax d
        dcx  d
        inr  b
        dad  b
        dad  b
        ldax d
        ldax d
        dcr  b
        dcx  b
        dcx  b
        inr  h
        dad  h
        mvi  b, 0Ah
        ldax b
        mvi  h, 27h
        rlc
        dcr  c
        dcr  c
        mvi  h, 26h
        rlc
        dcx  b
        dcx  b
        lxi  sp, 0231h
        inr  c
        mvi  c, 30h
        lxi  sp, 0D07h
        dcr  c
        stc
        stc
        stax b
        mvi  c, 15h
        db   38h
        dad  sp
        lxi  b, 1111h
        mvi  m, 37h
        dcx  b
        db   10h
        lxi  d, 332Eh
        db   08h
        db   10h
        db   10h
        mvi  l, 2Eh
        rlc
        db   10h
        db   10h
        cma
        cma
        stax b
        lxi  d, 2C15h
        dcr  l
        stax b
        lxi  d, 3015h
        lxi  sp, 150Bh
        dcr  d
        lhld 042Bh
        dcr  d
        dcr  d
        inx  sp
        inx  sp
        mvi  c, 15h
        dcr  d
        sta  0632h
        rrc
        rrc
        inr  h
        dad  h
        dcr  b
        db   10h
        db   10h
        inr  h
        dad  h
        ldax d
        lxi  d, 2411h
        dad  h
        mvi  b, 08h
        db   08h
        inr  d
        dad  d
        mvi  b, 08h
        db   08h
        inr  h
        dcr  h
        mvi  b, 08h
        db   08h
        db   28h
        dad  h
        inr  b
        dad  b
        dad  b
        lhld 0B2Ah
        dcr  c
        dcr  c
        shld 0623h
        mvi  b, 06h
        inr  d
        dad  d
        mvi  b, 06h
        mvi  b, 24h
        dad  h
        lxi  b, 0808h
        lhld 0B35h
        rlc
        rlc
        inr  m
        dcr  m
        stax b
        lxi  b, 3A09h
        lda  0202h
        dad  b
        mvi  m, 37h
        lxi  b, 0801h
        db   38h
        dad  sp
        ldax b
        dad  b
        dad  b
        db   38h
        db   38h
        inr  b
        rlc
        rlc
        db   08h
        db   08h
        lxi  b, 0503h
        ldax b
        dcx  b
        rlc
        dcr  b
        dcr  b
        inr  c
        lxi  d, 030Bh
        dcr  b
        stax d
        inx  d
        lxi  b, 0404h
        stax d
        inx  d
        rlc
        dcr  b
        dcr  b
        inr  d
        inr  d
        stax b
        stax b
        dcr  b
        db   18h
        dad  d
        dcx  b
        dcr  b
        dcr  b
        ldax d
        dcr  h
        rlc
        dcr  b
        dcr  b
        inr  e
        lxi  h, 0301h
        inr  b
        ldax d
        dcx  d
        lxi  b, 0504h
        shld 0B23h
        inx  b
        inx  b
        shld 0723h
        inr  b
        inr  b
        inr  h
        inr  h
        stax b
        stax b
        dcr  b
        db   28h
        dad  h
        lxi  b, 0403h
        lhld 0B2Bh
        dcr  b
        dcr  b
        lhld 072Bh
        dcr  b
        dcr  b
        inr  l
        dcr  m
        dcx  b
        inx  b
        inx  b
        sta  0133h
        inr  b
        dcr  b
        sta  0E33h
        rlc
        rlc
        inr  m
        dcr  m
        nop
        dcr  d
        inr  b
        inr  b
        mvi  d, 07h
        inr  m
        nop
        nop
        nop
        nop
        stax b
        lxi  b, 013Ah
        lxi  b, 0017h
        inx  b
        dcx  b
        mvi  d, 17h
        inr  b
        dcx  sp
        lxi  b, 1701h
        inr  a
        cmc
        lxi  b, 1007h
        db   08h
        stc
        dcr  b
        rlc
        rlc
        inr  c
        lxi  d, 0819h
        db   08h
        ldax b
        inx  d
        dad  d
        dad  b
        rrc
        ldax b
        dcx  b
        dad  d
        dad  b
        rrc
        stax d
        inx  d
        dad  d
        inr  c
        dcr  c
        ldax b
        inx  d
        dcr  b
        rlc
        rlc
        db   18h
        dcr  e
        dad  d
        db   08h
        db   08h
        mvi  d, 1Fh
        dad  d
        dad  b
        dad  b
        mvi  e, 1Fh
        dad  d
        db   08h
        dcx  b
        mvi  d, 17h
        dad  d
        dcx  b
        dcx  b
        mvi  d, 1Fh
        dad  d
        dcx  b
        mvi  c, 1Eh
        rar
        dad  d
        dcr  c
        mvi  c, 16h
        ral
        dad  d
        mvi  c, 0Fh
        db   18h
        dcr  e
        dcr  b
        rlc
        rlc
        inr  h
        dad  h
        dad  d
        db   08h
        dad  b
        lhld 192Bh
        db   08h
        db   08h
        shld 1929h
        dad  b
        mvi  c, 22h
        inx  h
        dad  d
        mvi  c, 0Fh
        inr  h
        dad  h
        dad  d
        dcr  c
        mvi  c, 2Ah
        dcx  h
        dcr  b
        rlc
        rlc
        mvi  l, 2Fh
        dad  d
        db   08h
        rrc
        mvi  l, 2Fh
        dcr  b
        rlc
        rlc
        inr  m
        dcr  m
        dad  d
        db   08h
        rrc
        inr  m
        dcr  m
        mvi  b, 03h
        dcr  b
        mvi  b, 39h
        rlc
        inr  b
        inr  b
        mvi  b, 39h
        lxi  b, 0301h
        mvi  e, 23h
        ldax b
        stax b
        stax b
        mvi  e, 1Eh
        mvi  c, 02h
        stax b
        rar
        rar
        stax b
        lxi  b, 2002h
        db   20h
        stax b
        inx  b
        stax d
        inr  b
        dcr  b
        rlc
        mvi  b, 11h
        mvi  b, 06h
        rlc
        lxi  d, 0611h
        dad  sp
        rlc
        mvi  b, 11h
        dad  sp
        dad  sp
        stax b
        inx  b
        lxi  d, 3B3Ah
        db   08h
        lxi  d, 1A11h
        ldax d
        stax b
        inr  d
        inr  d
        inr  b
        dcr  b
        stax b
        inx  d
        inx  d
        mvi  b, 07h
        stax b
        dcr  d
        dcr  d
        mvi  b, 07h
        stax b
        stax d
        stax d
        db   08h
        dad  b
        stax b
        inr  d
        inr  d
        db   08h
        dad  b
        stax b
        inx  d
        inx  d
        ldax b
        dcx  b
        stax b
        dcr  d
        dcr  d
        ldax b
        dcx  b
        stax b
        stax d
        stax d
        inr  c
        dcr  c
        stax b
        inr  d
        inr  d
        inr  c
        dcr  c
        stax b
        inx  d
        inx  d
        mvi  c, 0Fh
        stax b
        dcr  d
        dcr  d
        mvi  c, 0Fh
        stax b
        stax d
        stax d
        db   10h
        lxi  d, 1402h
        inr  d
        db   10h
        lxi  d, 1302h
        inx  d
        stax d
        inx  d
        stax b
        dcr  d
        dcr  d
        stax d
        inx  d
        stax b
        stax d
        stax d
        inr  d
        dcr  d
        stax b
        inr  d
        inr  d
        inr  d
        dcr  d
        stax b
        inx  d
        inx  d
        mvi  d, 17h
        stax b
        dcr  d
        dcr  d
        mvi  d, 17h
        stax b
        stax d
        stax d
        db   18h
        dad  d
        stax b
        inr  d
        inr  d
        db   18h
        dad  d
        stax b
        inx  d
        inx  d
        ldax d
        dcx  d
        stax b
        dcr  d
        dcr  d
        ldax d
        dcx  d
        stax b
        stax d
        stax d
        inr  e
        dcr  e
        stax b
        inr  d
        inr  d
        inr  e
        dcr  e
        stax b
        inx  d
        inx  d
        mvi  e, 1Fh
        stax b
        dcr  d
        dcr  d
        mvi  e, 1Fh
        stax b
        stax d
        stax d
        db   20h
        lxi  h, 1402h
        inr  d
        db   20h
        lxi  h, 1302h
        inx  d
        shld 0223h
        dcr  d
        dcr  d
        shld 0223h
        stax d
        stax d
        inr  h
        dcr  h
        stax b
        inr  d
        inr  d
        inr  h
        dcr  h
        stax b
        inx  d
        inx  d
        mvi  h, 27h
        stax b
        dcr  d
        dcr  d
        mvi  h, 27h
        stax b
        stax d
        stax d
        db   28h
        dad  h
        stax b
        inr  d
        inr  d
        db   28h
        dad  h
        stax b
        inx  d
        inx  d
        lhld 022Bh
        dcr  d
        dcr  d
        lhld 022Bh
        stax d
        stax d
        inr  l
        dcr  l
        stax b
        inr  d
        inr  d
        inr  l
        dcr  l
        stax b
        inx  d
        inx  d
        mvi  l, 2Fh
        stax b
        dcr  d
        dcr  d
        mvi  l, 2Fh
        stax b
        stax d
        stax d
        db   30h
        lxi  sp, 1402h
        inr  d
        db   30h
        lxi  sp, 1302h
        inx  d
        sta  0233h
        dcr  d
        dcr  d
        sta  0233h
        stax d
        stax d
        inr  m
        dcr  m
        stax b
        inr  d
        inr  d
        inr  m
        dcr  m
        stax b
        inx  d
        inx  d
        mvi  m, 37h
        stax b
        dcr  d
        dcr  d
        mvi  m, 37h
        stax b
        stax d
        stax d
        db   38h
        dad  sp
        stax b
        inr  d
        inr  d
        db   38h
        dad  sp
        stax b
        inx  d
        inx  d
        lda  023Bh
        dcr  d
        dcr  d
        lda  003Bh
        dcr  d
        inr  b
        nop
        rlc
        nop
        db   38h
        nop
        nop
        nop
        nop
        stax b
        lxi  b, 0120h
        lxi  b, 0017h
        inx  b
        lxi  b, 1716h
        nop
        cmc
        lxi  b, 1701h
        inr  a
        cmc
        dcr  b
        mvi  d, 16h
        inr  e
        inx  h
        mvi  b, 02h
        stax b
        db   18h
        daa
        stax b
        stax b
        dcr  d
        ldax d
        dcx  d
        stax b
        stax b
        dcr  d
        inr  h
        dcr  h
        inr  b
        dcr  d
        dcr  d
        db   08h
        db   08h
        inr  b
        dcr  d
        dcr  d
        ral
        ral
        inr  b
        dcr  d
        dcr  d
        db   28h
        db   28h
        inr  b
        dcr  d
        dcr  d
        stc
        stc
        dcx  b
        stax b
        stax b
        db   08h
        ral
        dcx  b
        inx  b
        inx  b
        db   08h
        dad  b
        dcx  b
        inx  b
        inx  b
        mvi  d, 17h
        dcx  b
        inr  b
        inr  b
        ldax b
        dcr  d
        dcx  b
        dcr  b
        dcr  b
        db   08h
        dad  b
        dcx  b
        dcr  b
        dcr  b
        mvi  d, 17h
        dcx  b
        mvi  b, 06h
        ldax b
        dcr  d
        dcx  b
        rlc
        rlc
        db   08h
        dad  b
        dcx  b
        rlc
        rlc
        mvi  d, 17h
        dcx  b
        db   08h
        db   08h
        ldax b
        dcr  d
        dcx  b
        dad  b
        dad  b
        db   08h
        dad  b
        dcx  b
        dad  b
        dad  b
        mvi  d, 17h
        dcx  b
        ldax b
        ldax b
        ldax b
        dcr  d
        dcx  b
        dcx  b
        dcx  b
        db   08h
        dad  b
        dcx  b
        dcx  b
        dcx  b
        mvi  d, 17h
        dcx  b
        inr  c
        inr  c
        ldax b
        dcr  d
        dcx  b
        rrc
        rrc
        db   08h
        dad  b
        dcx  b
        rrc
        rrc
        mvi  d, 17h
        dcx  b
        dcr  c
        dcr  c
        db   08h
        dad  b
        dcx  b
        dcr  c
        dcr  c
        mvi  d, 17h
        dcx  b
        mvi  c, 0Eh
        ldax b
        dcr  d
        dcx  b
        db   10h
        db   10h
        ldax b
        dcr  d
        dcx  b
        stax d
        stax d
        ldax b
        dcr  d
        dcx  b
        lxi  d, 0811h
        dad  b
        dcx  b
        lxi  d, 1611h
        ral
        dcx  b
        inx  d
        inx  d
        db   08h
        dad  b
        dcx  b
        inx  d
        inx  d
        mvi  d, 17h
        dcx  b
        inr  d
        inr  d
        db   08h
        ral
        rlc
        inx  b
        inx  b
        mvi  c, 11h
        rlc
        dcr  b
        dcr  b
        mvi  c, 11h
        rlc
        rlc
        rlc
        mvi  c, 11h
        rlc
        dad  b
        dad  b
        mvi  c, 11h
        rlc
        dcx  b
        dcx  b
        mvi  c, 11h
        rlc
        dcr  c
        dcr  c
        mvi  c, 11h
        rlc
        rrc
        rrc
        mvi  c, 11h
        rlc
        lxi  d, 0E11h
        lxi  d, 1307h
        inx  d
        mvi  c, 11h
        db   08h
        inx  d
        inx  d
        rrc
        rrc
        dcx  b
        stax b
        stax b
        db   28h
        stc
        dcx  b
        inr  b
        inr  b
        lhld 0B35h
        mvi  b, 06h
        lhld 0B35h
        db   08h
        db   08h
        lhld 0B35h
        ldax b
        ldax b
        lhld 0B35h
        inr  c
        inr  c
        lhld 0B35h
        mvi  c, 0Eh
        lhld 0B35h
        db   10h
        db   10h
        lhld 0B35h
        stax d
        stax d
        lhld 0B35h
        inr  d
        inr  d
        db   28h
        stc
        dcx  b
        inx  b
        inx  b
        db   28h
        dad  h
        dcx  b
        dcr  b
        dcr  b
        db   28h
        dad  h
        dcx  b
        rlc
        rlc
        db   28h
        dad  h
        dcx  b
        dad  b
        dad  b
        db   28h
        dad  h
        dcx  b
        dcx  b
        dcx  b
        db   28h
        dad  h
        dcx  b
        dcr  c
        dcr  c
        db   28h
        dad  h
        dcx  b
        rrc
        rrc
        db   28h
        dad  h
        dcx  b
        lxi  d, 2811h
        dad  h
        dcx  b
        inx  d
        inx  d
        db   28h
        dad  h
        dcx  b
        inx  b
        inx  b
        mvi  m, 37h
        dcx  b
        dcr  b
        dcr  b
        mvi  m, 37h
        dcx  b
        rlc
        rlc
        mvi  m, 37h
        dcx  b
        dad  b
        dad  b
        mvi  m, 37h
        dcx  b
        dcx  b
        dcx  b
        mvi  m, 37h
        dcx  b
        dcr  c
        dcr  c
        mvi  m, 37h
        dcx  b
        rrc
        rrc
        mvi  m, 37h
        dcx  b
        lxi  d, 3611h
        stc
        dcx  b
        inx  d
        inx  d
        mvi  m, 37h
        rlc
        inx  b
        inx  b
        mvi  l, 31h
        rlc
        dcr  b
        dcr  b
        mvi  l, 31h
        rlc
        rlc
        rlc
        mvi  l, 31h
        rlc
        dad  b
        dad  b
        mvi  l, 31h
        rlc
        dcx  b
        dcx  b
        mvi  l, 31h
        rlc
        dcr  c
        dcr  c
        mvi  l, 31h
        rlc
        rrc
        rrc
        mvi  l, 31h
        rlc
        lxi  d, 2E11h
        lxi  sp, 1307h
        inx  d
        mvi  l, 31h
        lxi  b, 1414h
        lda  0A3Bh
        dcr  d
        dcr  d
        lda  023Ah
        lxi  b, 3C15h
        inr  a
        nop
        dcr  b
        inr  b
        nop
        lxi  d, 2E00h
        nop
        nop
        nop
        nop
        stax b
        lxi  b, 003Ch
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        lxi  b, 1701h
        nop
        dcr  b
        lxi  b, 1716h
        nop
        cmc
        lxi  b, 1701h
        inr  a
        cmc
        dcr  b
        mvi  d, 16h
        mvi  b, 13h
        rlc
        inr  d
        inr  d
        inr  b
        dcr  b
        mvi  b, 15h
        dcr  d
        mvi  b, 13h
        stax b
        dcr  d
        dcr  d
        inr  d
        dcr  d
        dcr  b
        mvi  d, 16h
        mvi  l, 3Bh
        stax b
        dcr  d
        dcr  d
        inr  l
        dcr  l
        mvi  b, 15h
        dcr  d
        mvi  l, 31h
        stax b
        inr  c
        inr  d
        db   30h
        lxi  sp, 0C06h
        inr  c
        sta  0239h
        stax b
        dcx  b
        db   38h
        dad  sp
        mvi  b, 02h
        stax b
        inr  h
        stc
        dcx  b
        stax b
        mvi  d, 1Eh
        inx  h
        dcx  b
        db   08h
        ldax b
        inr  d
        dcr  l
        rlc
        inx  b
        dcr  d
        db   20h
        lxi  h, 0907h
        dad  b
        mvi  d, 2Bh
        mvi  b, 08h
        db   08h
        db   20h
        lxi  h, 0A06h
        ldax b
        db   20h
        lxi  h, 0E08h
        mvi  c, 20h
        db   20h
        mvi  b, 0Eh
        mvi  c, 34h
        dcr  m
        lxi  b, 0E0Eh
        mvi  m, 39h
        dcx  b
        rrc
        rrc
        mvi  m, 37h
        ldax b
        rrc
        rrc
        dad  sp
        dad  sp
        lxi  b, 1010h
        inr  m
        dad  sp
        mvi  b, 10h
        db   10h
        lda  023Bh
        lxi  b, 3C10h
        inr  a
        mvi  b, 0Ah
        ldax b
        mvi  l, 33h
        nop
        dcr  d
        mvi  d, 00h
        inr  d
        nop
        dcr  l
        nop
        nop
        nop
        nop
        stax b
        lxi  b, 013Ch
        lxi  b, 0017h
        inx  b
        lxi  b, 1717h
        nop
        cmc
        lxi  b, 1701h
        dcx  sp
        cmc
        stax b
        lxi  b, 3A16h
        lda  0101h
        dcr  d
        db   38h
        dad  sp
        stax b
        inr  d
        mvi  d, 06h
        rlc
        stax b
        dad  b
        inr  d
        inr  b
        dcr  b
        stax b
        dcr  b
        dad  b
        mvi  b, 07h
        rlc
        inr  b
        inr  b
        rlc
        rlc
        lxi  b, 110Fh
        mvi  b, 11h
        lxi  b, 1612h
        inr  c
        lxi  d, 0F05h
        rrc
        db   08h
        rrc
        ldax d
        db   10h
        db   10h
        db   08h
        rrc
        inr  e
        lxi  d, 0E16h
        mvi  c, 1Dh
        lxi  d, 0F16h
        rrc
        lxi  b, 0E0Eh
        ldax b
        dcr  c
        mvi  b, 0Eh
        mvi  c, 0Eh
        rrc
        mvi  b, 0Fh
        rrc
        stax d
        inx  d
        stax b
        inx  b
        inr  b
        dcx  b
        dcx  b
        dcx  b
        inr  b
        inr  b
        inr  c
        dad  d
        dcx  b
        mvi  b, 06h
        db   10h
        dad  d
        mvi  b, 06h
        mvi  b, 12h
        inx  d
        db   08h
        dcr  b
        dcr  b
        db   10h
        db   10h
        rlc
        dcr  b
        dcr  b
        inr  d
        inr  d
        rlc
        dcr  b
        dcr  b
        dad  d
        dad  d
        mvi  b, 08h
        db   08h
        db   08h
        dad  d
        lxi  b, 0604h
        ldax d
        dcx  d
        dcx  b
        ldax b
        ldax b
        ldax b
        dcr  e
        lxi  b, 0C0Bh
        inr  c
        daa
        lxi  b, 0404h
        inr  e
        inx  h
        lxi  b, 0605h
        shld 0123h
        mvi  b, 08h
        mvi  e, 1Fh
        lxi  b, 0808h
        mvi  e, 25h
        mvi  b, 08h
        db   08h
        mvi  h, 27h
        stax b
        mvi  b, 09h
        inr  e
        dcr  e
        stax b
        mvi  b, 07h
        db   20h
        lxi  h, 040Bh
        inr  b
        inr  h
        daa
        lxi  b, 0606h
        inr  h
        dcr  h
        stax b
        inx  b
        rlc
        db   28h
        dad  h
        lxi  b, 0707h
        lhld 022Dh
        dcr  b
        mvi  b, 2Ch
        dcr  l
        stax b
        inr  b
        dcr  b
        mvi  l, 2Fh
        stax b
        inx  b
        inr  b
        db   30h
        lxi  sp, 0402h
        dcr  b
        sta  0233h
        dcr  b
        dcr  b
        inr  m
        dcr  m
        lxi  b, 0606h
        inr  m
        stc
        stax b
        rlc
        inr  d
        mvi  m, 37h
        mvi  b, 09h
        dad  b
        inr  l
        dcr  m
        lxi  b, 0C0Bh
        mvi  l, 33h
        dcr  b
        dcx  b
        dcx  b
        db   30h
        lxi  sp, 0A07h
        ldax b
        shld 0B25h
        ldax b
        ldax b
        mvi  h, 27h
        mvi  b, 0Ah
        ldax b
        db   28h
        dad  h
        mvi  b, 0Bh
        dcx  b
        mvi  e, 21h
        dcr  b
        inr  c
        inr  c
        mvi  e, 21h
        dcr  b
        inr  c
        inr  c
        inr  h
        dad  h
        lxi  b, 0D0Dh
        ldax d
        lhld 0E01h
        mvi  c, 1Ch
        daa
        lxi  b, 0C0Ah
        lhld 1A2Bh
        dcr  c
        dcr  c
        db   20h
        daa
        dcx  b
        mvi  c, 0Eh
        db   28h
        dad  h
        dcx  b
        rrc
        rrc
        db   20h
        dcr  h
        lxi  b, 100Fh
        lhld 0231h
        rrc
        db   10h
        inr  l
        cma
        dcx  b
        mvi  c, 0Eh
        inr  l
        dcr  l
        dcx  b
        rrc
        rrc
        db   30h
        lxi  sp, 100Bh
        db   10h
        mvi  l, 2Fh
        mvi  b, 0Fh
        lxi  d, 3332h
        rlc
        mvi  c, 0Eh
        sta  0733h
        db   10h
        db   10h
        sta  0533h
        dcr  d
        dcr  d
        stax d
        inx  d
        ldax d
        mvi  d, 16h
        stax d
        inx  d
        mvi  b, 11h
        lxi  d, 1F14h
        stax b
        db   10h
        lxi  d, 2524h
        lxi  b, 1010h
        mvi  e, 23h
        stax b
        db   10h
        lxi  d, 2120h
        stax b
        db   10h
        db   10h
        inr  e
        dcr  e
        rlc
        db   10h
        db   10h
        inr  d
        dcx  d
        lxi  b, 1615h
        inr  d
        mvi  d, 0Ah
        inr  d
        inr  d
        mvi  d, 16h
        lxi  b, 1312h
        mvi  d, 17h
        lxi  b, 1313h
        db   18h
        rar
        lxi  b, 1515h
        ldax d
        db   38h
        lxi  b, 1414h
        ldax d
        dcx  d
        rlc
        inr  d
        inr  d
        inr  e
        inr  e
        dcx  b
        stax d
        inr  d
        db   20h
        lxi  sp, 1206h
        stax d
        shld 0223h
        inx  d
        inx  d
        db   20h
        lxi  h, 1402h
        inr  d
        shld 0223h
        inx  d
        inx  d
        inr  h
        dcr  h
        mvi  b, 12h
        stax d
        mvi  h, 27h
        stax b
        inr  d
        inr  d
        mvi  h, 27h
        stax b
        inx  d
        inx  d
        db   28h
        dad  h
        mvi  b, 12h
        stax d
        lhld 022Bh
        inr  d
        inr  d
        lhld 022Bh
        inx  d
        inx  d
        inr  l
        dcr  l
        mvi  b, 12h
        stax d
        mvi  l, 2Fh
        stax b
        inr  d
        inr  d
        mvi  l, 2Fh
        stax b
        inx  d
        inx  d
        db   30h
        lxi  sp, 1402h
        inr  d
        sta  0B33h
        inx  d
        inx  d
        sta  0B33h
        db   10h
        db   10h
        mvi  h, 27h
        nop
        dcr  d
        inr  b
        rlc
        dcr  h
        inr  d
        mvi  e, 00h
        nop
        nop
        nop
        stax b
        lxi  b, 013Ah
        lxi  b, 0017h
        cmc
        db   18h
        dcr  b
        dcx  b
        stax b
        dcr  b
        dcx  b
        lxi  b, 0201h
        ral
        db   18h
        stax b
        inr  b
        stax b
        inx  b
        mvi  c, 03h
        inx  b
        mvi  b, 0Fh
        rlc
        inx  b
        inx  b
        mvi  b, 06h
        rlc
        inx  b
        inx  b
        rrc
        rrc
        stax b
        inr  b
        dcr  c
        db   08h
        dad  b
        mvi  c, 0Dh
        dcr  c
        inr  b
        rlc
        stax b
        mvi  c, 15h
        inr  b
        dcr  b
        mvi  c, 15h
        dcr  d
        mvi  b, 0Fh
        stax b
        inr  d
        dcr  d
        db   10h
        lxi  d, 1307h
        inx  d
        db   10h
        lxi  d, 0F0Eh
        rrc
        mvi  b, 1Bh
        stax b
        dcr  b
        rrc
        mvi  d, 17h
        mvi  c, 09h
        dad  b
        ldax b
        dcr  d
        db   18h
        dcx  b
        dcr  c
        inr  c
        inx  d
        db   18h
        dcr  b
        rlc
        inr  c
        inx  d
        db   18h
        stax b
        inr  b
        stax d
        inx  d
        db   18h
        stax b
        stax b
        inr  d
        ral
        db   18h
        mvi  b, 0Dh
        ldax d
        dcx  d
        db   18h
        lxi  d, 0813h
        dcr  c
        db   18h
        lxi  d, 0E11h
        lxi  h, 0F18h
        db   10h
        mvi  e, 21h
        mvi  c, 04h
        inr  b
        mvi  d, 1Fh
        stax b
        inr  b
        inr  b
        ldax d
        dcx  d
        mvi  c, 01h
        inx  b
        ldax d
        dcx  d
        stax b
        dcr  b
        dcr  c
        mvi  e, 1Fh
        mvi  c, 09h
        dad  b
        db   20h
        daa
        rlc
        dad  b
        dad  b
        db   28h
        db   28h
        mvi  c, 0Dh
        dcr  c
        db   20h
        daa
        rlc
        dcr  c
        dcr  c
        daa
        daa
        mvi  c, 13h
        inx  d
        db   18h
        lxi  sp, 1405h
        inr  d
        db   18h
        dad  d
        stax b
        mvi  c, 13h
        inr  h
        dcr  h
        rlc
        inx  d
        inx  d
        ldax d
        ldax d
        mvi  c, 14h
        inr  d
        db   30h
        dcx  sp
        stax b
        inr  d
        inr  d
        db   30h
        lxi  sp, 0F02h
        inr  d
        lda  0E3Bh
        mvi  c, 0Eh
        lda  083Dh
        mvi  c, 0Eh
        dcr  a
        dcr  a
        stax b
        db   10h
        inx  d
        mvi  l, 2Fh
        mvi  c, 0Fh
        rrc
        mvi  l, 31h
        stax b
        ldax b
        rrc
        sta  0E33h
        dad  b
        dad  b
        sta  053Bh
        ldax b
        ldax b
        lda  073Bh
        dad  b
        dad  b
        dad  sp
        dad  sp
        stax b
        mvi  b, 09h
        db   30h
        lxi  sp, 050Eh
        dcr  b
        db   30h
        dcx  sp
        mvi  c, 03h
        inx  b
        db   28h
        cma
        mvi  c, 01h
        stax b
        db   28h
        dad  h
        stax b
        inr  b
        dcr  b
        mvi  l, 2Fh
        ldax b
        dcr  b
        dcr  b
        inr  m
        inr  m
        stax b
        lxi  b, 3905h
        dad  sp
        db   18h
        stax d
        mvi  d, 14h
        dcr  d
        db   18h
        mvi  d, 16h
        mvi  d, 3Dh
        db   18h
        dcr  d
        dcr  d
        inr  e
        dcr  l
        db   18h
        stax b
        stax b
        mvi  e, 25h
        dcx  b
        lxi  b, 1E01h
        dcr  h
        db   18h
        inx  b
        rlc
        shld 1825h
        dcr  b
        rlc
        mvi  h, 2Bh
        db   18h
        rlc
        dcx  b
        inr  l
        dcr  l
        db   18h
        dcx  b
        dcx  b
        shld 182Fh
        inr  c
        dcr  c
        lhld 182Fh
        mvi  c, 11h
        lhld 182Bh
        rrc
        lxi  d, 2928h
        dcx  b
        lxi  b, 2C01h
        mvi  m, 18h
        stax b
        inx  b
        sta  0B36h
        lxi  b, 3C01h
        dcr  a
        db   18h
        stax b
        inx  b
        inr  a
        dcr  a
        db   18h
        rlc
        rlc
        inr  m
        dcr  a
        db   18h
        dcx  b
        stax d
        mvi  m, 37h
        db   18h
        inr  c
        inr  c
        db   38h
        dcr  a
        db   18h
        lxi  d, 3211h
        dcr  m
        db   18h
        stax d
        stax d
        inr  m
        stc
        nop
        dcr  d
        mvi  b, 00h
        ldax d
        nop
        db   28h
        nop
        nop
        nop
        nop
        stax b
        lxi  b, 0039h
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        lxi  b, 1701h
        nop
        inx  b
        lxi  b, 1716h
        nop
        cmc
        lxi  b, 1501h
        inr  a
        cmc
        ldax d
        mvi  d, 16h
        inr  d
        daa
        ldax d
        mvi  d, 16h
        inr  l
        inx  sp
        lxi  b, 1515h
        stax d
        cmc
        dcr  b
        dcr  d
        dcr  d
        inr  d
        daa
        dcr  b
        dcr  d
        dcr  d
        inr  l
        inx  sp
        dcx  b
        lxi  b, 0601h
        dcr  e
        dcx  b
        lxi  b, 2001h
        dcx  sp
        dcx  b
        inx  d
        inx  d
        mvi  b, 23h
        mvi  b, 13h
        inx  d
        db   18h
        dcx  d
        mvi  b, 13h
        inx  d
        inr  h
        daa
        dcx  b
        lxi  d, 0612h
        dcx  b
        dcx  b
        dcr  c
        db   10h
        mvi  b, 09h
        dcx  b
        dcr  b
        inr  c
        mvi  b, 07h
        dcx  b
        lxi  d, 0E11h
        dcr  h
        mvi  b, 11h
        lxi  d, 1918h
        stax b
        lxi  d, 1015h
        lxi  d, 0E01h
        rrc
        inr  c
        lxi  d, 0E05h
        mvi  c, 0Eh
        rrc
        dcx  b
        ldax b
        dcr  c
        inr  c
        dcr  c
        mvi  b, 0Ah
        ldax b
        db   08h
        dcx  b
        dcx  b
        mvi  c, 0Fh
        stax d
        ral
        stax b
        mvi  c, 10h
        inr  d
        dcr  d
        dcx  b
        inx  b
        inx  b
        inr  c
        dcr  l
        dcx  b
        dcr  b
        dcr  b
        inr  c
        dcr  c
        dcx  b
        db   08h
        db   08h
        inr  c
        dcr  c
        mvi  b, 04h
        inr  b
        db   08h
        dad  b
        stax b
        inx  b
        db   08h
        ldax b
        dcx  b
        mvi  b, 08h
        db   08h
        mvi  c, 0Fh
        stax b
        db   08h
        dcr  c
        db   10h
        lxi  d, 0B0Bh
        dcx  b
        stax d
        ral
        dcx  b
        inr  c
        inr  c
        mvi  d, 17h
        mvi  b, 09h
        dad  b
        stax d
        inx  d
        dcx  b
        dad  b
        dad  b
        inr  d
        dcx  d
        dcx  b
        ldax b
        inr  c
        ldax d
        dcx  d
        dcx  b
        inr  c
        inr  c
        inr  e
        rar
        dcx  b
        dcr  c
        dcr  c
        mvi  e, 1Fh
        mvi  b, 0Eh
        mvi  c, 18h
        dad  d
        dcx  b
        mvi  c, 0Eh
        ldax d
        dcx  d
        dcx  b
        rrc
        rrc
        ldax d
        dad  h
        mvi  b, 0Fh
        rrc
        db   20h
        lxi  h, 050Bh
        dcr  b
        db   10h
        dcx  d
        stax b
        inx  b
        inr  b
        ldax d
        dcx  d
        dcx  b
        dcr  b
        dcr  b
        mvi  e, 1Fh
        dcx  b
        rlc
        rlc
        inr  d
        dcr  m
        dcx  b
        db   08h
        ldax b
        mvi  e, 1Fh
        mvi  b, 07h
        rlc
        stax d
        inx  d
        mvi  b, 07h
        rlc
        inr  e
        dcr  e
        mvi  b, 07h
        rlc
        db   20h
        lxi  h, 0702h
        db   08h
        inr  l
        dcr  l
        mvi  b, 07h
        rlc
        mvi  l, 33h
        dcx  b
        dcr  b
        dcr  b
        inr  h
        inx  sp
        dcx  b
        mvi  b, 06h
        lhld 022Bh
        dcr  b
        mvi  b, 22h
        inx  h
        stax b
        inr  b
        dcr  b
        lhld 062Bh
        dcr  b
        dcr  b
        mvi  l, 2Fh
        dcx  b
        dad  b
        dad  b
        inr  h
        dcx  sp
        stax b
        dad  b
        ldax b
        shld 0123h
        dcx  b
        dcr  c
        shld 062Bh
        dcx  b
        dcx  b
        inr  h
        daa
        dcr  b
        inr  c
        inr  c
        inr  h
        dad  h
        mvi  b, 09h
        dad  b
        mvi  l, 2Fh
        mvi  b, 09h
        dad  b
        sta  0B33h
        dcx  b
        dcx  b
        db   28h
        dcr  l
        dcx  b
        dcx  b
        mvi  c, 2Eh
        lxi  sp, 0B06h
        dcx  b
        mvi  l, 2Fh
        mvi  b, 0Bh
        dcx  b
        sta  0B33h
        dcx  b
        inr  c
        inr  m
        stc
        dcx  b
        mvi  c, 11h
        inr  m
        stc
        stax b
        dcx  b
        inr  d
        db   38h
        dad  sp
        dcx  b
        db   10h
        db   10h
        db   28h
        lxi  sp, 1006h
        db   10h
        lhld 012Dh
        stax d
        inx  d
        db   28h
        dad  h
        stax b
        stax d
        inr  d
        lhld 062Bh
        stax d
        stax d
        inr  l
        dcr  l
        dcx  b
        stax d
        stax d
        mvi  l, 2Fh
        dcx  b
        inx  d
        inr  d
        mvi  l, 31h
        mvi  b, 13h
        inx  d
        sta  0B33h
        inx  d
        inr  d
        inr  m
        dcr  m
        dcx  b
        stax b
        inx  b
        db   30h
        lxi  sp, 0302h
        inr  b
        sta  0B33h
        inx  b
        inr  b
        inr  m
        dcx  sp
        dcx  b
        dcr  b
        rlc
        db   38h
        dad  sp
        stax b
        inr  b
        mvi  b, 36h
        stc
        dcx  b
        dcr  b
        dcr  b
        lda  023Bh
        lxi  b, 3902h
        dad  sp
        ldax b
        stax b
        stax b
        inr  m
        inr  m
        rlc
        inr  b
        inr  b
        mvi  b, 07h
        rlc
        inr  c
        inr  c
        db   08h
        dad  b
        rlc
        db   10h
        db   10h
        ldax b
        dcx  b
        rlc
        ldax b
        ldax b
        mvi  d, 17h
        rlc
        stax d
        stax d
        mvi  e, 1Eh
        rlc
        inr  d
        inr  d
        db   28h
        dad  h
        rlc
        inr  c
        inr  c
        mvi  l, 2Fh
        rlc
        stax b
        stax b
        inr  l
        inr  l
        rlc
        inr  b
        inr  b
        mvi  d, 17h
        rlc
        inr  b
        inr  b
        lda  083Bh
        inr  b
        inr  b
        mvi  d, 16h
        nop
        lxi  b, 0104h
        mvi  e, 00h
        nop
        nop
        nop
        nop
        nop
        lxi  b, 3900h
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        lxi  b, 1701h
        nop
        inx  b
        lxi  b, 1717h
        nop
        cmc
        dcx  b
        mvi  d, 16h
        inr  b
        dcx  b
        lxi  b, 1601h
        inr  a
        cmc
        dcr  b
        mvi  d, 16h
        inr  c
        dcx  sp
        stax b
        inr  d
        dcr  d
        ldax b
        dcx  b
        mvi  b, 14h
        inr  d
        inr  c
        dcr  d
        stax b
        inr  d
        inr  d
        mvi  d, 17h
        mvi  b, 15h
        dcr  d
        db   18h
        dcr  h
        stax b
        inr  d
        inr  d
        mvi  h, 27h
        mvi  b, 14h
        inr  d
        db   28h
        stc
        stax b
        stax d
        inx  d
        db   38h
        dad  sp
        mvi  b, 12h
        stax d
        mvi  h, 37h
        stax b
        stax d
        stax d
        inr  h
        dcr  h
        mvi  b, 13h
        inx  d
        ldax d
        inx  h
        stax b
        stax d
        stax d
        db   18h
        dad  d
        mvi  b, 12h
        stax d
        inr  c
        ral
        stax b
        db   10h
        stax d
        ldax b
        dcx  b
        mvi  b, 10h
        db   10h
        inr  c
        dad  d
        stax b
        db   10h
        db   10h
        ldax d
        dcx  d
        mvi  b, 11h
        lxi  d, 211Ch
        stax b
        db   10h
        db   10h
        shld 0623h
        db   10h
        db   10h
        inr  h
        stc
        stax b
        stax b
        db   10h
        db   38h
        dad  sp
        mvi  b, 0Eh
        mvi  c, 36h
        stc
        dcx  b
        mvi  c, 0Eh
        inr  m
        dcr  m
        mvi  b, 02h
        stax b
        inr  h
        stc
        mvi  b, 03h
        inx  b
        inr  e
        rar
        stax b
        inx  b
        inr  b
        db   20h
        lxi  h, 0502h
        dcr  b
        mvi  e, 1Fh
        stax b
        mvi  b, 07h
        inr  e
        dcr  e
        stax b
        db   08h
        db   08h
        mvi  e, 1Fh
        stax b
        dad  b
        ldax b
        db   20h
        lxi  h, 0B02h
        dcr  c
        shld 0B23h
        mvi  c, 0Eh
        inr  h
        dcr  h
        mvi  b, 0Eh
        mvi  c, 26h
        cma
        stax b
        inr  c
        mvi  c, 30h
        lxi  sp, 0C06h
        inr  c
        db   28h
        cma
        stax b
        ldax b
        inr  c
        mvi  h, 27h
        mvi  b, 0Ah
        ldax b
        db   28h
        cma
        stax b
        db   08h
        ldax b
        db   30h
        lxi  sp, 0806h
        db   08h
        db   28h
        cma
        stax b
        mvi  b, 08h
        mvi  h, 27h
        mvi  b, 06h
        mvi  b, 28h
        lxi  sp, 0502h
        mvi  b, 32h
        inx  sp
        stax b
        inr  b
        inr  b
        db   30h
        lxi  sp, 0406h
        inr  b
        db   28h
        cma
        rlc
        inr  b
        inr  b
        daa
        daa
        rlc
        db   08h
        db   08h
        inr  m
        inr  m
        rlc
        ldax b
        ldax b
        inr  m
        inr  m
        rlc
        inr  c
        inr  c
        inr  m
        inr  m
        stax b
        rrc
        rrc
        mvi  e, 1Fh
        stax b
        mvi  c, 0Eh
        inr  e
        dcr  e
        stax b
        mvi  c, 0Eh
        db   20h
        lxi  h, 0E06h
        mvi  c, 0Eh
        dcx  d
        dcx  b
        mvi  c, 0Eh
        inr  c
        dcr  c
        rlc
        dcr  c
        dcr  c
        inr  c
        dcr  d
        mvi  b, 0Dh
        dcr  c
        db   18h
        dcx  d
        dcx  b
        inr  c
        inr  c
        ldax b
        dcx  b
        mvi  b, 0Ch
        inr  c
        inr  c
        dcr  d
        rlc
        dcx  b
        dcx  b
        ldax b
        dcr  d
        rlc
        inr  c
        inr  c
        db   18h
        dad  d
        stax b
        dcx  b
        inr  c
        ldax d
        dcx  d
        stax b
        inr  c
        inr  c
        mvi  e, 1Fh
        stax b
        dcx  b
        dcx  b
        inr  e
        dcr  e
        stax b
        ldax b
        ldax b
        db   18h
        dad  d
        stax b
        dad  b
        dad  b
        mvi  d, 17h
        stax b
        db   08h
        db   08h
        inr  d
        dcr  d
        stax b
        rlc
        rlc
        stax d
        inx  d
        stax b
        mvi  b, 06h
        db   10h
        lxi  d, 0502h
        dcr  b
        mvi  c, 0Fh
        stax b
        inr  b
        inr  b
        inr  c
        dcr  c
        stax b
        inx  b
        inx  b
        ldax b
        dcx  b
        stax b
        lxi  b, 0902h
        dad  b
        dcx  b
        inr  b
        dcr  b
        mvi  b, 09h
        ldax b
        mvi  b, 06h
        db   08h
        db   08h
        stax b
        rlc
        dcr  c
        mvi  b, 07h
        dcx  b
        rlc
        rlc
        db   08h
        dad  b
        mvi  b, 07h
        rlc
        ldax b
        lxi  d, 0907h
        dad  b
        db   08h
        dad  b
        dcx  b
        ldax b
        ldax b
        db   08h
        dad  b
        rlc
        dcr  c
        dcr  c
        db   08h
        dad  b
        dcx  b
        mvi  c, 0Eh
        db   08h
        dad  b
        rlc
        stax b
        stax b
        inr  e
        dcr  e
        db   08h
        dad  b
        dad  b
        dad  b
        dad  b
        nop
        db   10h
        inr  b
        lxi  b, 000Bh
        nop
        nop
        nop
        nop
        nop
        lxi  b, 0900h
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        lxi  b, 1701h
        nop
        inx  b
        lxi  b, 1715h
        inr  b
        cmc
        lxi  b, 1401h
        lda  053Fh
        mvi  d, 16h
        inr  b
        dad  sp
        mvi  b, 15h
        dcr  d
        ldax b
        dcr  m
        mvi  b, 03h
        inx  b
        dcr  b
        dcr  e
        stax b
        inx  b
        inr  d
        inr  b
        inr  b
        stax b
        lxi  b, 3914h
        dad  sp
        lxi  b, 1414h
        db   08h
        dad  b
        lxi  b, 1313h
        mvi  m, 38h
        ldax b
        inr  d
        inr  d
        mvi  m, 36h
        dcx  b
        inx  b
        inr  b
        mvi  e, 1Fh
        dcx  b
        dcr  b
        dcr  b
        ldax d
        inx  h
        dcx  b
        mvi  b, 06h
        db   18h
        dcr  e
        dcx  b
        mvi  b, 06h
        db   20h
        dcr  h
        dcx  b
        rlc
        rlc
        inr  e
        lxi  h, 080Bh
        db   08h
        db   18h
        dcr  h
        dcx  b
        dad  b
        dad  b
        mvi  d, 1Bh
        dcx  b
        dad  b
        dad  b
        shld 0B27h
        ldax b
        ldax b
        ldax d
        inx  h
        dcx  b
        dcx  b
        dcx  b
        db   18h
        dcr  h
        dcx  b
        inr  c
        inr  c
        mvi  d, 1Bh
        dcx  b
        inr  c
        inr  c
        shld 0B27h
        dcr  c
        dcr  c
        ldax d
        inx  h
        dcx  b
        mvi  c, 0Eh
        mvi  d, 27h
        dcx  b
        rrc
        rrc
        inr  d
        dcx  d
        dcx  b
        rrc
        rrc
        shld 0B29h
        db   10h
        db   10h
        ldax d
        inx  h
        dcx  b
        lxi  d, 1411h
        dad  h
        dcx  b
        stax d
        stax d
        stax d
        dcx  d
        dcx  b
        stax d
        stax d
        shld 0B2Bh
        inx  d
        inr  d
        db   18h
        dad  d
        dcx  b
        inx  d
        inr  d
        inr  h
        dcr  h
        dcx  b
        dcr  d
        mvi  d, 12h
        dcx  h
        rlc
        rlc
        rlc
        mvi  e, 1Fh
        rlc
        ldax b
        ldax b
        inr  e
        lxi  h, 0D07h
        dcr  c
        inr  e
        lxi  h, 1007h
        db   10h
        inr  e
        lxi  h, 1407h
        inr  d
        inr  e
        lxi  h, 0802h
        inr  d
        mvi  e, 1Fh
        db   08h
        inr  d
        inr  d
        inr  e
        inr  e
        nop
        inr  d
        rlc
        stax d
        inr  e
        stax d
        lxi  h, 0000h
        nop
        nop
        stax b
        nop
        dad  sp
        nop
        nop
        nop
        nop
        nop
        lxi  b, 1701h
        nop
        inx  b
        lxi  b, 1717h
        inr  b
        cmc
        lxi  b, 1601h
        inr  a
        cmc
        lxi  b, 0101h
        inr  b
        inx  d
        lxi  b, 0101h
        mvi  d, 2Bh
        lxi  b, 0101h
        mvi  l, 3Bh
        dcx  b
        inx  d
        mvi  d, 14h
        dcr  l
        dcr  b
        inx  d
        inx  d
        ldax b
        inx  d
        dcr  b
        inx  d
        inx  d
        ldax d
        daa
        dcr  b
        inx  d
        inx  d
        mvi  l, 37h
        ldax d
        inr  d
        mvi  d, 0Ah
        inx  d
        ldax d
        inr  d
        mvi  d, 1Ah
        daa
        ldax d
        inr  d
        mvi  d, 2Eh
        dcx  sp
        lxi  b, 1312h
        inr  b
        dcr  b
        lxi  b, 1612h
        db   08h
        dad  b
        lxi  b, 1616h
        inr  b
        rlc
        stax b
        stax d
        dcr  d
        mvi  b, 07h
        mvi  b, 04h
        inr  b
        inr  c
        dcr  m
        mvi  b, 06h
        mvi  b, 0Ch
        dcx  d
        mvi  b, 06h
        mvi  b, 26h
        dcr  m
        mvi  b, 08h
        db   08h
        inr  c
        dcr  m
        mvi  b, 0Ah
        ldax b
        inr  c
        inx  d
        mvi  b, 0Ch
        inr  c
        inr  c
        inx  d
        mvi  b, 0Eh
        mvi  c, 0Ch
        inx  d
        mvi  b, 10h
        db   10h
        inr  c
        inx  d
        mvi  b, 12h
        stax d
        inr  c
        rrc
        mvi  b, 0Ah
        ldax b
        mvi  l, 35h
        mvi  b, 0Ch
        inr  c
        mvi  l, 35h
        mvi  b, 0Eh
        mvi  c, 2Eh
        dcr  m
        mvi  b, 10h
        db   10h
        mvi  l, 35h
        mvi  b, 12h
        stax d
        sta  0B35h
        ldax b
        ldax b
        ldax d
        daa
        mvi  b, 0Ah
        ldax b
        inr  e
        dcr  h
        mvi  b, 0Ch
        inr  c
        db   20h
        inx  h
        mvi  b, 0Eh
        mvi  c, 1Eh
        lxi  h, 0F06h
        rrc
        ldax d
        dcx  d
        mvi  b, 0Fh
        rrc
        mvi  h, 27h
        mvi  b, 10h
        db   10h
        db   20h
        inx  h
        mvi  b, 12h
        stax d
        ldax d
        lxi  h, 1206h
        stax d
        mvi  h, 27h
        dcx  b
        inr  b
        dcr  b
        db   20h
        lxi  h, 060Bh
        rlc
        mvi  e, 1Fh
        dcx  b
        mvi  b, 07h
        shld 0B23h
        db   08h
        dad  b
        inr  e
        dcr  e
        dcx  b
        db   08h
        dad  b
        inr  h
        dcr  h
        dcx  b
        inr  c
        dcr  c
        db   28h
        dad  h
        dcx  b
        inr  c
        dcr  c
        db   18h
        dad  d
        dcx  b
        mvi  c, 0Eh
        mvi  d, 17h
        dcx  b
        mvi  c, 0Eh
        lhld 0B2Bh
        db   10h
        db   10h
        inr  d
        dad  d
        dcx  b
        db   10h
        db   10h
        db   28h
        dcr  l
        dcx  b
        stax d
        stax d
        inr  d
        dcr  d
        dcx  b
        stax d
        stax d
        inr  l
        dcr  l
        stax b
        inr  b
        stax d
        ldax b
        dcx  b
        stax b
        inr  b
        stax d
        db   10h
        lxi  d, 0402h
        dcr  c
        mvi  d, 17h
        stax b
        inr  b
        rlc
        inr  e
        dcr  e
        stax b
        inr  b
        rlc
        inr  h
        dcr  h
        stax b
        inr  b
        dcr  c
        lhld 022Bh
        inr  b
        stax d
        db   30h
        lxi  sp, 0402h
        stax d
        mvi  m, 37h
        stax b
        inr  c
        stax d
        inr  e
        dcr  e
        stax b
        inr  c
        stax d
        inr  h
        dcr  h
        lxi  b, 1402h
        db   38h
        dcx  sp
        mvi  c, 11h
        lxi  d, 3B38h
        stax b
        lxi  b, 3B11h
        dcx  sp
        ldax b
        lxi  d, 3911h
        dad  sp
        rlc
        rlc
        rlc
        db   20h
        lxi  h, 0907h
        dad  b
        db   20h
        lxi  h, 0B07h
        dcx  b
        db   20h
        lxi  h, 0D07h
        dcr  c
        db   20h
        lxi  h, 0F07h
        rrc
        db   20h
        lxi  h, 1107h
        lxi  d, 2120h
        db   08h
        rrc
        rrc
        db   20h
        db   20h
        inx  b
        rrc
        rrc
        mvi  d, 16h
        inr  b
        rrc
        rrc
        dcx  h
        dcx  h
        nop
        inr  d
        inr  b
        lxi  b, 0114h
        dcr  l
        nop
        nop
        nop
        nop
        stax b
        nop
        dcx  sp
        nop
        nop
        nop
        nop
        nop
        nop
        lxi  b, 1701h
        nop
        inx  b
        lxi  b, 1716h
        inr  b
        cmc
        lxi  b, 1501h
        inr  a
        cmc
        dcr  b
        mvi  d, 16h
        mvi  c, 33h
        stax b
        inr  b
        dcr  d
        mvi  b, 07h
        mvi  b, 04h
        inr  b
        db   08h
        lxi  h, 020Bh
        stax b
        db   20h
        lxi  h, 040Bh
        inr  b
        mvi  e, 1Fh
        dcx  b
        inr  b
        inr  b
        shld 0B23h
        mvi  b, 06h
        inr  e
        dcr  h
        mvi  b, 06h
        mvi  b, 20h
        lxi  h, 080Bh
        db   08h
        ldax d
        dcx  d
        dcx  b
        db   08h
        db   08h
        mvi  e, 23h
        dcx  b
        db   08h
        db   08h
        mvi  h, 27h
        dcx  b
        ldax b
        ldax b
        db   18h
        dcx  d
        dcx  b
        ldax b
        ldax b
        mvi  e, 23h
        dcx  b
        ldax b
        ldax b
        mvi  h, 29h
        dcx  b
        inr  c
        inr  c
        mvi  d, 19h
        dcx  b
        inr  c
        inr  c
        inr  e
        dcr  h
        dcx  b
        inr  c
        inr  c
        db   28h
        dcx  h
        dcx  b
        mvi  c, 0Eh
        inr  d
        ral
        dcx  b
        mvi  c, 0Eh
        ldax d
        daa
        dcx  b
        mvi  c, 0Eh
        lhld 0B2Dh
        db   10h
        db   10h
        stax d
        dcr  d
        dcx  b
        db   10h
        db   10h
        db   18h
        dad  h
        dcx  b
        db   10h
        db   10h
        inr  l
        cma
        dcx  b
        stax d
        stax d
        db   10h
        inx  d
        dcx  b
        stax d
        stax d
        mvi  d, 2Bh
        dcx  b
        stax d
        stax d
        mvi  l, 31h
        dcx  b
        inr  d
        inr  d
        mvi  c, 33h
        rlc
        dcr  b
        dcr  b
        mvi  e, 23h
        rlc
        rlc
        rlc
        mvi  e, 23h
        rlc
        dad  b
        dad  b
        mvi  e, 23h
        rlc
        dcx  b
        dcx  b
        mvi  e, 23h
        rlc
        dcr  c
        dcr  c
        mvi  e, 23h
        rlc
        rrc
        rrc
        mvi  e, 23h
        rlc
        lxi  d, 1E11h
        inx  h
        rlc
        inx  d
        inx  d
        mvi  e, 23h
        mvi  c, 07h
        inr  d
        db   20h
        lxi  h, 1401h
        inr  d
        db   38h
        dcx  sp
        stax b
        lxi  b, 3B15h
        dcx  sp
        ldax b
        dcr  d
        dcr  d
        dad  sp
        dad  sp
        mvi  c, 05h
        dcr  b
        db   20h
        lxi  h, 0908h
        dad  b
        inx  h
        inx  h
        nop
        inr  d
        inr  b
        lxi  b, 011Ch
        dcr  h
        nop
        nop
        nop
        nop
        stax b
        nop
        dcx  sp
        nop
        nop
        nop
        nop
        nop
        nop
        lxi  b, 1701h
        nop
        inx  b
        lxi  b, 1717h
        inr  b
        cmc
        lxi  b, 1601h
        lda  0E3Fh
        lxi  d, 3A11h
        inr  a
        dcr  b
        inx  d
        inx  d
        inr  b
        dad  sp
        dcx  d
        inr  d
        mvi  d, 04h
        dad  sp
        stax b
        stax b
        lxi  d, 0302h
        mvi  b, 03h
        inx  b
        inr  b
        stc
        stax b
        inx  b
        db   08h
        db   38h
        dad  sp
        mvi  b, 07h
        rlc
        db   08h
        stc
        rlc
        dad  b
        lxi  d, 2120h
        mvi  b, 0Ch
        inr  c
        mvi  b, 39h
        mvi  b, 09h
        ldax b
        db   30h
        stc
        stax b
        dad  b
        dad  b
        db   30h
        lxi  sp, 0A02h
        dcx  b
        db   38h
        dad  sp
        mvi  b, 09h
        ldax b
        db   08h
        lxi  d, 0702h
        db   08h
        mvi  b, 07h
        stax b
        dad  b
        dad  b
        db   10h
        lxi  d, 0A02h
        dcx  b
        mvi  b, 07h
        mvi  b, 12h
        stax d
        inr  b
        inx  d
        mvi  b, 12h
        stax d
        mvi  l, 39h
        dcx  b
        inr  b
        dcr  b
        db   20h
        lxi  h, 060Bh
        rlc
        mvi  e, 23h
        dcx  b
        db   08h
        dad  b
        inr  e
        rar
        dcx  b
        ldax b
        dcx  b
        ldax d
        dcr  e
        dcx  b
        inr  c
        dcr  c
        db   18h
        dcx  d
        dcx  b
        mvi  c, 0Fh
        mvi  d, 19h
        dcx  b
        db   10h
        db   10h
        inr  d
        ral
        dcx  b
        lxi  d, 1413h
        dcr  d
        dcx  b
        inx  d
        inx  d
        mvi  d, 19h
        dcx  b
        stax d
        stax d
        db   18h
        dad  d
        dcx  b
        db   08h
        dad  b
        shld 0B25h
        ldax b
        dcx  b
        inr  h
        daa
        dcx  b
        inr  c
        dcr  c
        mvi  h, 29h
        dcx  b
        mvi  c, 0Fh
        db   28h
        dcx  h
        dcx  b
        db   10h
        db   10h
        lhld 0B2Bh
        lxi  d, 2C13h
        dcr  l
        dcx  b
        inx  d
        inx  d
        db   28h
        dcx  h
        dcx  b
        stax d
        stax d
        db   28h
        dad  h
        mvi  b, 0Ah
        ldax b
        mvi  e, 23h
        mvi  b, 0Eh
        mvi  c, 1Ah
        lxi  h, 0E06h
        mvi  c, 26h
        daa
        mvi  b, 10h
        db   10h
        ldax d
        dcx  d
        mvi  b, 10h
        db   10h
        db   20h
        daa
        mvi  b, 12h
        stax d
        ldax d
        lxi  h, 1206h
        stax d
        mvi  h, 27h
        stax b
        mvi  c, 12h
        inr  e
        dcr  e
        stax b
        mvi  c, 12h
        inr  h
        dcr  h
        ldax b
        lxi  d, 3B11h
        dcx  sp
        stax b
        lxi  b, 3D11h
        dcr  a
        db   08h
        lxi  d, 2111h
        lxi  h, 0101h
        lxi  b, 1D04h
        lxi  b, 0101h
        db   20h
        lxi  h, 0101h
        lxi  b, 3A24h
        nop
        stax b
        stax b
        lxi  b, 011Fh
        shld 0000h
        nop
        nop
        stax b
        nop
        dcr  a
        nop
        nop
        nop
        nop
        lxi  b, 1701h
        nop
        inx  b
        lxi  b, 1716h
        inr  b
        cmc
        lxi  b, 1701h
        inr  a
        cmc
        stax b
        inx  d
        dcr  d
        dad  b
        dad  b
        stax b
        inr  b
        stax d
        ldax b
        ldax b
        mvi  b, 04h
        inr  b
        dcx  b
        dcr  e
        dcx  b
        stax b
        stax b
        db   20h
        lxi  h, 040Bh
        inr  b
        mvi  e, 23h
        dcx  b
        mvi  b, 06h
        inr  e
        dcr  h
        mvi  b, 06h
        mvi  b, 1Eh
        rar
        mvi  b, 06h
        mvi  b, 22h
        inx  h
        rlc
        dcr  b
        dcr  b
        db   20h
        lxi  h, 080Bh
        db   08h
        ldax d
        dcx  d
        dcx  b
        db   08h
        db   08h
        mvi  e, 23h
        dcx  b
        db   08h
        db   08h
        mvi  h, 27h
        rlc
        dad  b
        dad  b
        inr  e
        dcr  e
        rlc
        dad  b
        dad  b
        inr  h
        dcr  h
        dcx  b
        ldax b
        ldax b
        db   18h
        dad  d
        dcx  b
        ldax b
        ldax b
        inr  e
        rar
        dcx  b
        ldax b
        ldax b
        shld 0B25h
        ldax b
        ldax b
        db   28h
        dad  h
        rlc
        dcx  b
        dcx  b
        ldax d
        dcx  d
        rlc
        dcx  b
        dcx  b
        mvi  h, 27h
        dcx  b
        inr  c
        inr  c
        mvi  d, 17h
        mvi  b, 0Ch
        inr  c
        ldax d
        dcx  d
        lxi  b, 0E0Ch
        inr  e
        dcr  e
        lxi  b, 0E0Eh
        mvi  e, 25h
        lxi  b, 0D0Ch
        inr  h
        dcr  h
        dcx  b
        inr  c
        inr  c
        mvi  h, 2Bh
        mvi  b, 0Ch
        inr  c
        db   28h
        dad  h
        stax b
        mvi  c, 0Eh
        db   18h
        dad  d
        dcx  b
        mvi  c, 0Eh
        inr  d
        dcr  d
        dcr  b
        dcr  c
        dcr  c
        mvi  e, 23h
        stax b
        mvi  c, 0Eh
        db   28h
        dad  h
        dcx  b
        mvi  c, 0Eh
        inr  l
        dcr  l
        dcx  b
        db   10h
        db   10h
        stax d
        inx  d
        dcx  b
        db   10h
        db   10h
        mvi  d, 1Fh
        mvi  b, 10h
        db   10h
        db   18h
        dcx  d
        dcx  b
        db   10h
        db   10h
        shld 0B2Bh
        db   10h
        db   10h
        mvi  l, 2Fh
        dcx  b
        stax d
        stax d
        db   10h
        ral
        mvi  b, 12h
        stax d
        stax d
        inx  d
        dcx  b
        stax d
        stax d
        ldax d
        rar
        mvi  b, 12h
        stax d
        db   20h
        lxi  h, 120Bh
        stax d
        inr  h
        daa
        dcx  b
        stax d
        stax d
        lhld 0631h
        stax d
        stax d
        mvi  l, 2Fh
        dcx  b
        inr  d
        inr  d
        mvi  c, 15h
        dcx  b
        inr  d
        inr  d
        db   18h
        dad  d
        dcx  b
        inr  d
        inr  d
        inr  e
        rar
        dcx  b
        inr  d
        inr  d
        shld 0B29h
        inr  d
        inr  d
        inr  l
        cma
        dcx  b
        inr  d
        inr  d
        sta  0133h
        inr  d
        inr  d
        db   38h
        dcx  sp
        ldax b
        dcr  d
        dcr  d
        dad  sp
        dad  sp
        stax b
        lxi  b, 3B15h
        dcx  sp
        rlc
        rrc
        rrc
        mvi  d, 17h
        inr  b
        rrc
        rrc
        ldax d
        dcx  d
        rlc
        rrc
        rrc
        lhld 072Bh
        lxi  d, 1411h
        dcr  d
        rlc
        lxi  d, 1E11h
        rar
        rlc
        lxi  d, 2C11h
        dcr  l
        inx  b
        inx  d
        inx  d
        db   10h
        db   10h
        rlc
        inx  d
        inx  d
        shld 0823h
        lxi  d, 1E11h
        mvi  e, 00h
        dcr  d
        inr  b
        lxi  b, 011Ah
        daa
        nop
        nop
        nop
        nop
        stax b
        nop
        dcx  sp
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        lxi  b, 1701h
        nop
        inx  b
        lxi  b, 1716h
        inr  b
        cmc
        lxi  b, 1501h
        inr  a
        cmc
        dcr  b
        mvi  d, 16h
        db   10h
        dcx  sp
        mvi  b, 15h
        dcr  d
        db   08h
        dcx  sp
        stax b
        inx  b
        dcr  d
        inr  b
        dcr  b
        lxi  b, 1404h
        mvi  b, 07h
        lxi  b, 1514h
        mvi  c, 0Fh
        mvi  b, 03h
        inx  b
        mvi  b, 0Bh
        mvi  b, 02h
        stax b
        stax d
        dcx  h
        mvi  b, 03h
        inx  b
        mvi  c, 29h
        mvi  b, 04h
        inr  b
        inr  d
        dad  h
        mvi  b, 05h
        dcr  b
        ldax b
        dcr  h
        stax b
        lxi  b, 0E02h
        mvi  c, 02h
        stax b
        stax b
        db   28h
        dad  h
        mvi  b, 07h
        rlc
        ldax b
        dad  d
        mvi  b, 07h
        rlc
        db   20h
        dcr  h
        stax b
        dcr  b
        mvi  b, 08h
        dad  b
        stax b
        db   08h
        dad  b
        db   08h
        dad  b
        mvi  b, 09h
        dad  b
        ldax b
        dcr  c
        lxi  b, 0906h
        mvi  c, 0Fh
        stax b
        rlc
        dad  b
        db   10h
        lxi  d, 0A06h
        ldax b
        db   10h
        inx  d
        lxi  b, 0C0Ch
        inr  c
        rrc
        stax b
        dcr  c
        dcr  c
        ldax b
        dcx  b
        lxi  b, 0F0Eh
        db   08h
        dcx  b
        dcr  b
        mvi  c, 0Eh
        db   08h
        dad  b
        stax b
        lxi  d, 0814h
        dad  b
        lxi  b, 1311h
        ldax b
        dcx  b
        stax b
        mvi  c, 10h
        inr  c
        dcr  c
        lxi  b, 1111h
        inr  c
        rrc
        lxi  b, 100Eh
        mvi  c, 0Fh
        mvi  b, 0Eh
        mvi  c, 10h
        ral
        lxi  b, 0F0Fh
        db   10h
        dad  d
        mvi  b, 0Fh
        rrc
        stax d
        inx  d
        stax b
        ldax b
        dcr  c
        inr  d
        dcr  d
        lxi  b, 0D09h
        mvi  d, 17h
        stax b
        dad  b
        mvi  c, 18h
        dad  d
        stax b
        rlc
        rlc
        mvi  e, 1Fh
        stax b
        rlc
        rlc
        mvi  h, 27h
        mvi  b, 09h
        dad  b
        ldax d
        lxi  h, 0902h
        dad  b
        mvi  e, 1Fh
        stax b
        inr  b
        dad  b
        lhld 062Bh
        ldax b
        ldax b
        inr  h
        dcx  h
        stax b
        ldax b
        mvi  c, 22h
        inx  h
        dcx  b
        dcx  b
        dcx  b
        inr  e
        dcr  e
        dcx  b
        dcr  c
        dcr  c
        inr  e
        dcr  e
        dcx  b
        rrc
        rrc
        db   20h
        inx  h
        mvi  b, 0Fh
        rrc
        mvi  e, 1Fh
        stax b
        rrc
        rrc
        inr  e
        dcr  e
        mvi  b, 10h
        db   10h
        mvi  e, 23h
        lxi  b, 1010h
        inr  e
        dcr  e
        stax b
        db   10h
        lxi  d, 1B1Ah
        lxi  b, 1111h
        inr  e
        daa
        stax b
        inr  c
        mvi  c, 26h
        daa
        mvi  b, 11h
        lxi  d, 2524h
        mvi  b, 0Ch
        inr  c
        db   28h
        dad  h
        lxi  b, 0F0Fh
        mvi  h, 27h
        mvi  b, 0Fh
        rrc
        db   28h
        cma
        mvi  b, 11h
        lxi  d, 2F28h
        mvi  b, 12h
        stax d
        stax d
        dad  d
        lxi  b, 1313h
        stax d
        daa
        mvi  b, 13h
        inx  d
        mvi  c, 11h
        mvi  b, 13h
        inx  d
        inr  d
        dad  d
        mvi  b, 13h
        inx  d
        inr  h
        dcr  h
        mvi  b, 13h
        inx  d
        db   28h
        dad  h
        stax b
        inx  d
        inr  d
        inr  e
        dcr  e
        dcx  b
        dcr  c
        dcr  c
        lhld 0B2Bh
        rrc
        rrc
        lhld 0B2Bh
        lxi  d, 2A11h
        dcx  h
        dcx  b
        inx  d
        inx  d
        lhld 022Bh
        lxi  d, 3011h
        lxi  sp, 110Bh
        lxi  d, 3332h
        dcx  b
        lxi  d, 3611h
        stc
        stax b
        lxi  d, 3812h
        dad  sp
        dcx  b
        inx  d
        inx  d
        mvi  m, 39h
        mvi  b, 13h
        inx  d
        inr  m
        dcr  m
        stax b
        inx  d
        inr  d
        sta  0733h
        stax b
        mvi  c, 34h
        dcr  m
        dcx  b
        inx  b
        inx  b
        db   30h
        stc
        dcx  b
        dcr  b
        dcr  b
        sta  0B37h
        dad  b
        dad  b
        sta  0B37h
        rlc
        rlc
        sta  0B37h
        dcx  b
        dcx  b
        sta  0B37h
        dcr  c
        dcr  c
        sta  0B37h
        rrc
        rrc
        db   30h
        stc
        stax b
        stax b
        inx  b
        mvi  l, 2Fh
        stax b
        inx  b
        inx  b
        inr  m
        dcr  m
        stax b
        inx  b
        inr  b
        db   38h
        dad  sp
        stax b
        dcr  b
        mvi  b, 30h
        lxi  sp, 0502h
        dcr  b
        inr  m
        dcr  m
        stax b
        rlc
        rlc
        inr  m
        dcr  m
        stax b
        rlc
        db   08h
        db   38h
        dad  sp
        stax b
        dad  b
        dad  b
        inr  m
        dcr  m
        stax b
        dad  b
        ldax b
        db   30h
        lxi  sp, 0B02h
        dcx  b
        inr  m
        dcr  m
        stax b
        dcx  b
        inr  c
        db   38h
        dad  sp
        stax b
        dcr  c
        dcr  c
        inr  m
        dcr  m
        stax b
        dcr  c
        mvi  c, 30h
        lxi  sp, 0F02h
        rrc
        inr  m
        dcr  m
        lxi  b, 0101h
        sta  0133h
        lxi  b, 3601h
        dcx  sp
        lxi  b, 0202h
        inr  l
        dcr  l
        rlc
        stax b
        stax b
        ldax b
        dcx  b
        rlc
        stax b
        stax b
        db   10h
        lxi  d, 0107h
        lxi  b, 1312h
        rlc
        mvi  b, 06h
        inr  c
        dcr  c
        rlc
        db   08h
        db   08h
        inr  c
        dcr  c
        rlc
        mvi  b, 06h
        db   18h
        dad  d
        rlc
        mvi  b, 06h
        mvi  e, 1Fh
        rlc
        mvi  b, 06h
        mvi  h, 27h
        rlc
        db   08h
        db   08h
        inr  e
        dcr  e
        rlc
        db   08h
        db   08h
        db   20h
        lxi  h, 0A07h
        ldax b
        inr  e
        dcr  e
        rlc
        inr  c
        inr  c
        inr  e
        dcr  e
        rlc
        dcx  b
        dcx  b
        mvi  c, 0Fh
        rlc
        inr  c
        inr  c
        ldax b
        dcx  b
        rlc
        inr  c
        inr  c
        lhld 072Bh
        mvi  c, 0Eh
        lhld 072Bh
        db   10h
        db   10h
        lhld 072Bh
        stax d
        stax d
        lhld 072Bh
        stax d
        stax d
        inr  e
        dcr  e
        rlc
        stax d
        stax d
        db   20h
        lxi  h, 1407h
        inr  d
        db   10h
        lxi  d, 1208h
        stax d
        inr  e
        inr  e
        inx  b
        lxi  d, 1211h
        inx  d
        inr  b
        stax d
        stax d
        ldax d
        dcx  d
        inr  b
        stax d
        stax d
        mvi  e, 1Eh
        inx  b
        stax d
        stax d
        sta  0933h
        stax b
        stax b
        inx  sp
        inx  sp
        nop
        dcr  d
        mvi  b, 00h
        lxi  d, 3400h
        nop
        nop
        nop
        nop
        stax b
        nop
        mvi  c, 00h
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        lxi  b, 1701h
        nop
        dcr  b
        lxi  b, 1716h
        nop
        cmc
        lxi  b, 1701h
        inr  a
        cmc
        dcr  b
        mvi  d, 16h
        mvi  b, 09h
        dcr  b
        mvi  d, 16h
        db   38h
        dcx  sp
        lxi  b, 140Eh
        inr  c
        dcr  m
        stax b
        mvi  c, 15h
        ldax b
        dcx  b
        stax b
        inr  b
        mvi  c, 06h
        rlc
        mvi  b, 0Fh
        rrc
        mvi  b, 09h
        dcr  b
        rrc
        rrc
        mvi  c, 1Fh
        dcr  b
        rrc
        rrc
        shld 0B33h
        inr  b
        db   08h
        db   08h
        lxi  d, 0402h
        inr  b
        db   10h
        lxi  d, 0501h
        rlc
        db   08h
        dad  b
        lxi  b, 0605h
        db   10h
        lxi  d, 0507h
        rlc
        ldax b
        rrc
        lxi  b, 0C09h
        db   08h
        dad  b
        mvi  b, 09h
        dad  b
        ldax b
        rrc
        lxi  b, 0C09h
        db   10h
        lxi  d, 0A07h
        inr  c
        ldax b
        rrc
        mvi  b, 08h
        db   08h
        stax d
        dcx  d
        dcx  b
        dad  b
        dad  b
        inr  d
        dcr  d
        lxi  b, 0D0Ah
        inr  d
        dcr  d
        stax b
        ldax b
        dcr  c
        mvi  d, 17h
        lxi  b, 0D0Dh
        db   18h
        dcx  d
        mvi  b, 0Eh
        mvi  c, 1Eh
        inx  h
        stax b
        lxi  b, 200Eh
        lxi  h, 0806h
        db   08h
        mvi  h, 2Fh
        dcx  b
        dad  b
        dad  b
        inr  l
        dcr  l
        stax b
        ldax b
        dcr  c
        lhld 012Bh
        dcr  c
        dcr  c
        mvi  h, 29h
        lxi  b, 0D0Ah
        inr  l
        dcr  l
        dcx  b
        inr  b
        db   08h
        db   30h
        dad  sp
        stax b
        inr  b
        inr  b
        db   30h
        lxi  sp, 0501h
        mvi  b, 30h
        lxi  sp, 0501h
        rlc
        db   38h
        dad  sp
        rlc
        dcr  b
        rlc
        sta  0237h
        inr  b
        mvi  c, 3Ah
        dcx  sp
        mvi  b, 0Fh
        rrc
        db   38h
        dcx  sp
        lxi  b, 0C09h
        db   30h
        dad  sp
        mvi  b, 09h
        dad  b
        sta  0737h
        ldax b
        inr  c
        sta  0237h
        mvi  c, 15h
        mvi  m, 37h
        dcx  d
        db   10h
        stax d
        mvi  c, 33h
        lxi  b, 0101h
        mvi  b, 1Fh
        lxi  b, 0101h
        lxi  h, 003Bh
        dcr  d
        db   20h
        stax b
        db   18h
        stax b
        dad  h
        nop
        nop
        nop
        nop
        stax b
        nop
        db   20h
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
