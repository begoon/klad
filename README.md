# KLAD disassembly

Reverse-engineered Intel 8080 source for `tape/KLAD.RK`, the 1987 RK86
maze game **КЛАД** ("treasure") by E. Puysis-Puyshe (Riga, version 1.4).
The program loads at `org 0000h`. `KLAD.asm` assembles to a byte-exact
reproduction of the tape; verified by `just ci`.

## Layout

```text
tape/KLAD.RK           original tape file (do not modify)
KLAD.bin               extracted payload (regenerable from tape)
KLAD.asm               annotated source (the actual work product)
disasm.py              linear i8080 disassembler
tobin.py               tape envelope stripper
extract.py             dumps intro string and level maps as text
Justfile               build/test pipeline
extracted/             text dumps from extract.py
  intro.screen.txt     decoded welcome screen (Cyrillic)
  intro.raw.txt        same with control codes annotated
  glyph_lut.txt        type code → glyph table
  levels/level_NN.txt  ASCII rendering of each level
```

## Common commands

```bash
just ci                # assemble KLAD.asm and byte-diff vs the tape
                       # empty diff = green
just initial           # rebuild KLAD.bin from tape/ (rare)
just disasm            # regenerate KLAD.asm from KLAD.bin
                       # WARNING: overwrites your annotations — commit first
just clean             # remove generated files
python3 extract.py     # regenerate everything under extracted/
```

## Status

- [x] Pass 0 — round-trip baseline (linear disasm + `--trailer-padding 1`
      for the off-by-1 encoder quirk in this tape)
- [x] Pass 1 — code/data split (level data, intro string, BSS, actor
      table, scratch vars all separated)
- [x] Pass 2 — semantic labels (entry points renamed; every variable
      lives at its actual address with a name)
- [ ] Pass 3 — full annotation (most routines still `loc_XXXX`)

## Tape quirk

The original encoder wrote `end_addr = 334Fh` but appended one extra
byte before the trailer, leaving 1 zero between the declared payload
end and `E6 cs_hi cs_lo`. The asm is trimmed to 13136 bytes and
`bunx asm8080 --trailer-padding 1` reproduces that gap.

## Level encoding

Each level is a stream of 5-byte records that the renderer at
`loc_0144` interprets as filled rectangles, plus a 13-byte trailer
holding spawn metadata. The whole format is:

### Pointer table (`tbl_01D0`)

19 little-endian word pointers at `0x01D0`, indexed by `level_num × 2`:

```asm
tbl_01D0:
        dw   level_0      ; entry 0  (0x18B0)
        dw   level_1      ; entry 1  (0x0B35 — parked in a gap)
        dw   level_2      ; entry 2  (0x1987)
        ...
        dw   level_18     ; entry 18 (0x3250)
```

Levels 0 and 2–18 sit contiguously in `0x18B0–0x334F`. Level 1 lives
back at `0x0B35`, in the dead space between the game loop (ends
`0x0B34`) and the helper routine at `0x0E4A` — presumably stuffed
there because the late-address block ran out of room.

### Record format

Each record is 5 bytes:

```text
+0  type       index into tbl_01B2 → glyph byte
+1  row_start  inclusive (0..23)
+2  row_end    inclusive
+3  col_start  inclusive (0..63)
+4  col_end    inclusive
```

The renderer fills the rectangle (rs..re, cs..ce) with the type's
glyph, writing to both video memory (via `plot_char`) and the in-RAM
shadow `maze_map` (so collision tests can read cell state). A record
where `type == 0` ends the stream.

### Type codes (`tbl_01B2`)

The 30-byte LUT at `0x01B2` translates record type → display byte:

| Type   | Glyph | Meaning                              |
|--------|-------|--------------------------------------|
| 0      | —     | terminator                           |
| 1      | Х     | concrete wall (indestructible)       |
| 2      | #     | ladder                               |
| 3      | ]     | door (closing)                       |
| 4      | [     | door (opening)                       |
| 5      | ^     | water                                |
| 6      | ─     | bridge                               |
| 7, 8   | ▄     | chest (treasure container)           |
| 11     | %     | wood wall (breakable with Q / ^)     |
| 18     | ⌐     | gold piece (klad)                    |
| 19     | ✿     | player                               |
| 20     | ↑     | ice eater (monster)                  |

Plus a few entries used for scoreboard / decor glyphs.

### Per-level trailer (13 bytes)

Immediately after the `type=0` byte, `load_level_state` copies 13 bytes
into the live state vars at `0x08B1..0x08BD`:

```text
+0    player_x_init     (re-uses the terminator record's row_start slot)
+1    player_y_init     (terminator record's row_end slot)
+2..3 actor0_init       \
+4..5 actor1_init        | word-pair init xy for up to 4 monsters
+6..7 actor2_init        |
+8..9 actor3_init       /
+A    actor_count       how many of the 4 actors are active
+B    goal_x            chest target column
+C    goal_y            chest target row
```

The first 4 trailer bytes ride along as parameters of the terminator
record (so the end-marker doubles as the spawn point); the remaining
9 bytes sit in the gap before the next level pointer.

### Worked example: level 0

```asm
level_0:                                  ; 0x18B0
        db   01h, 01h, 17h, 00h, 03h      ; wall   rows 1-23  cols  0-3   (left edge)
        db   01h, 16h, 17h, 00h, 3Fh      ; wall   rows 22-23 cols  0-63  (bottom)
        db   01h, 01h, 17h, 3Ch, 3Fh      ; wall   rows 1-23  cols 60-63  (right edge)
        db   05h, 16h, 16h, 12h, 3Bh      ; water  row 22     cols 18-59
        db   02h, 12h, 15h, 0Eh, 0Fh      ; ladder rows 18-21 cols 14-15
        db   0Bh, 12h, 12h, 0Ah, 0Dh      ; wood   row 18     cols 10-13
        db   07h, 11h, 11h, 0Ah, 0Ah      ; chest  row 17     col  10
        ...
        db   00h                          ; terminator (type=0)
        db   0Fh, 04h                     ; player spawn at (15, 4)
        db   01h, 2Eh, 00h, 00h, ...      ; actor / goal trailer
```

Run `python3 extract.py` and read `extracted/levels/level_00.txt` to
see the full record list and an ASCII rendering.

### Loader (`loc_0100`)

```asm
loc_0100:
        mvi  c, 1Fh
        call putc                  ; clear screen
        lxi  h, tbl_01D0
        xra  a
        lda  level_num
        ral                        ; A = level_num × 2
        mov  e, a
        mvi  d, 00h
        dad  d                     ; HL = tbl_01D0 + level_num*2
        mov  a, m
        sta  level_ptr
        inx  h
        mov  a, m
        sta  level_ptr+1
        lxi  h, maze_map
        shld maze_map_base
loc_0120:                          ; record loop (see Record format above)
        ...
```

After the record loop returns, `game_restart` calls `load_level_state`
to read the trailer, then seeds `player_x` / `player_y` and copies the
4 actor init positions into the live `actor0..actor3` records.

## Tools

- `bunx asm8080` — assembler (<https://github.com/begoon/asm8>)
- `python3` — for `disasm.py`, `tobin.py`, `extract.py`
- `just` — task runner
- `xxd` and `diff` — round-trip verification

## Reference

The reversing workflow, idioms cookbook, and RK86 hardware reference
live in the skill repo under `rk86-skills/rk86-reversal/`.
