#!/usr/bin/env python3
"""Extract intro string and level maps from KLAD.bin into text files."""

from pathlib import Path

ROOT = Path(__file__).resolve().parent
BIN  = (ROOT / "KLAD.bin").read_bytes()
OUT  = ROOT / "extracted"


# ---------------------------------------------------------------------------
# RK86 character map: byte → display char
# 0x60..0x7F maps Latin to Cyrillic (the source string uses lowercase Latin
# letters which render as uppercase Cyrillic on screen).
# ---------------------------------------------------------------------------

CYRILLIC_60_7F = (
    "ЮАБЦДЕФГХИЙКЛМНОПЯРСТУЖВЬЫЗШЭЩЧ█"
)  # exactly 32 chars for 0x60..0x7F

# Block-graphic glyphs in 0x00..0x1F.
BLOCK_00_1F = {
    0x01: "▘", 0x02: "▝", 0x03: "▀", 0x04: "▗", 0x05: "▚", 0x06: "▐", 0x07: "▜",
    0x09: "✿", 0x0B: "↑", 0x0E: "◀", 0x0F: "▼",
    0x10: "▖", 0x11: "▌", 0x12: "▞", 0x13: "▛", 0x14: "▄", 0x15: "▙", 0x16: "▟",
    0x17: "█", 0x1B: "│", 0x1C: "─", 0x1D: "▶", 0x1E: "⌐",
}


def render_char(b: int) -> str:
    if b in BLOCK_00_1F:
        return BLOCK_00_1F[b]
    if 0x20 <= b < 0x60:
        return chr(b)
    if 0x60 <= b < 0x80:
        return CYRILLIC_60_7F[b - 0x60]
    return "·"


# ---------------------------------------------------------------------------
# Intro string at 0x1612.
#
# Encoding:
#   1Fh             = clear screen + home cursor
#   1Bh 59h ROW COL = ESC-Y position cursor (ROW and COL are biased by 0x20
#                     when emitted by curses-style code, but in this game the
#                     row byte is e.g. 0x22 = row 2, 0x36 = col 22 — i.e. the
#                     'tape' encoding is row+0x20, col+0x20 for printable)
#   00h             = string terminator
# ---------------------------------------------------------------------------

def extract_intro() -> None:
    end = BIN.index(0, 0x1612)
    raw = BIN[0x1612:end + 1]

    # Pass 1: dump as-is with control codes escaped.
    src_lines = []
    i = 0
    line = []
    while i < len(raw):
        b = raw[i]
        if b == 0x1F:
            if line:
                src_lines.append("".join(line))
                line = []
            src_lines.append("[CLS]")
            i += 1
        elif b == 0x1B and i + 3 < len(raw) and raw[i + 1] == 0x59:
            if line:
                src_lines.append("".join(line))
                line = []
            row = raw[i + 2] - 0x20
            col = raw[i + 3] - 0x20
            src_lines.append(f"[CURSOR row={row} col={col}]")
            i += 4
        elif b == 0x0D:
            line.append("\\r")
            i += 1
        elif b == 0:
            if line:
                src_lines.append("".join(line))
            src_lines.append("[END]")
            i += 1
        elif b < 0x20:
            line.append(f"\\x{b:02x}")
            i += 1
        else:
            line.append(chr(b))
            i += 1

    # Pass 2: render screen as a 25×64 grid using ESC-Y positioning.
    SCREEN = [[" "] * 64 for _ in range(25)]
    row, col = 0, 0
    i = 0
    while i < len(raw):
        b = raw[i]
        if b == 0:
            break
        if b == 0x1F:
            row, col = 0, 0
            i += 1
        elif b == 0x1B and i + 3 < len(raw) and raw[i + 1] == 0x59:
            row = raw[i + 2] - 0x20
            col = raw[i + 3] - 0x20
            i += 4
        elif b == 0x0D:
            row += 1
            col = 0
            i += 1
        else:
            if 0 <= row < 25 and 0 <= col < 64:
                SCREEN[row][col] = render_char(b)
            col += 1
            i += 1

    rendered = "\n".join("".join(r).rstrip() for r in SCREEN).rstrip("\n") + "\n"

    out_dir = OUT
    out_dir.mkdir(exist_ok=True)
    (out_dir / "intro.raw.txt").write_text("\n".join(src_lines) + "\n", encoding="utf-8")
    (out_dir / "intro.screen.txt").write_text(rendered, encoding="utf-8")
    print(f"wrote {out_dir/'intro.raw.txt'} ({len(src_lines)} lines)")
    print(f"wrote {out_dir/'intro.screen.txt'} (25 rows)")


# ---------------------------------------------------------------------------
# Level data.
#
# Word table at 0x01D0 holds 19 little-endian pointers, indexed by level
# number (0..18). Each level is a stream of 5-byte records terminated by a
# record where byte 0 (type) is zero. Record fields (from the renderer at
# loc_0144):
#   byte 0: type (xlat'd via tbl_01B2 to a glyph)
#   byte 1: row_start  (0..23)
#   byte 2: row_end    (inclusive)
#   byte 3: col_start  (0..63)
#   byte 4: col_end    (inclusive)
# The renderer fills the rectangle (rs..re, cs..ce) with the type's glyph.
# ---------------------------------------------------------------------------

# byte LUT at 0x01B2, 30 entries, type → display byte.
TBL_01B2 = list(BIN[0x01B2:0x01B2 + 30])

# Map type code → ASCII glyph for readable level rendering.
TYPE_ASCII = {
    0:  " ",   # empty / terminator
    1:  "X",   # concrete wall (Х)
    2:  "#",   # ladder
    3:  "]",   # door (closed)
    4:  "[",   # door (open)
    5:  "^",   # water
    6:  "-",   # bridge / horizontal line
    7:  "*",   # chest
    8:  "*",   # chest (alt)
    9:  "]",
    10: "[",
    11: "%",   # breakable wood wall
    12: ":",
    13: ".",
    14: " ",
    15: ".",
    16: ":",
    17: "|",
    18: "$",   # treasure (klad)
    19: "@",   # player
    20: "&",   # ice eater monster
    21: "-",
    22: "Q",
    23: "@",
    24: "&",
    25: "*",
    26: "=",
    27: "+",
    28: ">",
    29: "<",
}


def render_level(start: int) -> tuple[list[list[str]], list[tuple[int, int, int, int, int]]]:
    """Walk the 5-byte records for one level.

    Returns (screen_grid, records) where screen_grid is a 25×64 char grid
    and records is the parsed record list.
    """
    screen = [[" "] * 64 for _ in range(25)]
    records = []
    i = start
    while True:
        rec = BIN[i:i + 5]
        records.append(tuple(rec))
        if rec[0] == 0:
            break
        ty, rs, re_, cs, ce = rec
        glyph = TYPE_ASCII.get(ty, "?")
        for r in range(rs, re_ + 1):
            for c in range(cs, ce + 1):
                if 0 <= r < 25 and 0 <= c < 64:
                    screen[r][c] = glyph
        i += 5
    return screen, records


def extract_levels() -> None:
    out_dir = OUT / "levels"
    out_dir.mkdir(parents=True, exist_ok=True)

    pointers = []
    for n in range(19):
        lo = BIN[0x01D0 + n * 2]
        hi = BIN[0x01D0 + n * 2 + 1]
        pointers.append((n, lo | (hi << 8)))

    # Glyph legend
    legend_lines = ["RK86 glyph LUT (tbl_01B2):", ""]
    for idx, val in enumerate(TBL_01B2):
        ch = render_char(val)
        ascii_ch = TYPE_ASCII.get(idx, "?")
        legend_lines.append(f"  type {idx:2d} → byte 0x{val:02X} ({ch})  rendered as '{ascii_ch}'")
    (OUT / "glyph_lut.txt").write_text("\n".join(legend_lines) + "\n", encoding="utf-8")

    for n, ptr in pointers:
        screen, records = render_level(ptr)

        out_lines = []
        out_lines.append(f"# Level {n}  (data at 0x{ptr:04X}, {len(records)} records, {len(records)*5} bytes)")
        out_lines.append("")
        out_lines.append("Records (type, row_start, row_end, col_start, col_end):")
        for ridx, rec in enumerate(records):
            ty, rs, re_, cs, ce = rec
            ascii_ch = TYPE_ASCII.get(ty, "?")
            note = ""
            if ty == 0:
                note = "  ; END"
            else:
                note = f"  ; '{ascii_ch}'  rows {rs}-{re_} cols {cs}-{ce}"
            out_lines.append(f"  {ridx:3d}: {ty:3d} {rs:3d} {re_:3d} {cs:3d} {ce:3d}{note}")
        out_lines.append("")
        out_lines.append("Screen (25 rows × 64 cols, ASCII rendering):")
        out_lines.append("    " + "0123456789" * 6 + "0123")
        out_lines.append("    " + "0" * 10 + "1" * 10 + "2" * 10 + "3" * 10 + "4" * 10 + "5" * 10 + "6" * 4)
        for r, row in enumerate(screen):
            out_lines.append(f"{r:2d}: " + "".join(row).rstrip())

        path = out_dir / f"level_{n:02d}.txt"
        path.write_text("\n".join(out_lines) + "\n", encoding="utf-8")

    print(f"wrote {len(pointers)} level files to {out_dir}")


if __name__ == "__main__":
    OUT.mkdir(exist_ok=True)
    extract_intro()
    extract_levels()
