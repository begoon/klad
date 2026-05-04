#!/usr/bin/env python3
"""Intel 8080 linear disassembler. Emits asm8080-compatible syntax.
Usage: disasm.py <file> <org-hex>"""

import sys

R = ["b", "c", "d", "e", "h", "l", "m", "a"]
RP = ["b", "d", "h", "sp"]
RP_PSW = ["b", "d", "h", "psw"]
CC = ["nz", "z", "nc", "c", "po", "pe", "p", "m"]


def hexw(n):
    s = f"{n:04X}h"
    return ("0" + s) if s[0].isalpha() else s


def hexb(n):
    s = f"{n:02X}h"
    return ("0" + s) if s[0].isalpha() else s


OPS = {}
OPS[0x00] = ("nop", 1)
for i, rp in enumerate(RP):
    OPS[0x01 + i * 0x10] = (f"lxi  {rp}, {{a16}}", 3)
    OPS[0x03 + i * 0x10] = (f"inx  {rp}", 1)
    OPS[0x09 + i * 0x10] = (f"dad  {rp}", 1)
    OPS[0x0B + i * 0x10] = (f"dcx  {rp}", 1)
OPS[0x02] = ("stax b", 1)
OPS[0x12] = ("stax d", 1)
OPS[0x0A] = ("ldax b", 1)
OPS[0x1A] = ("ldax d", 1)
for i, r in enumerate(R):
    OPS[0x04 + i * 8] = (f"inr  {r}", 1)
    OPS[0x05 + i * 8] = (f"dcr  {r}", 1)
    OPS[0x06 + i * 8] = (f"mvi  {r}, {{d8}}", 2)
OPS[0x07] = ("rlc", 1)
OPS[0x0F] = ("rrc", 1)
OPS[0x17] = ("ral", 1)
OPS[0x1F] = ("rar", 1)
OPS[0x22] = ("shld {a16}", 3)
OPS[0x2A] = ("lhld {a16}", 3)
OPS[0x32] = ("sta  {a16}", 3)
OPS[0x3A] = ("lda  {a16}", 3)
OPS[0x27] = ("daa", 1)
OPS[0x2F] = ("cma", 1)
OPS[0x37] = ("stc", 1)
OPS[0x3F] = ("cmc", 1)
for d in range(8):
    for s in range(8):
        op = 0x40 + d * 8 + s
        if op == 0x76:
            OPS[op] = ("hlt", 1)
        else:
            OPS[op] = (f"mov  {R[d]}, {R[s]}", 1)
ALU = ["add", "adc", "sub", "sbb", "ana", "xra", "ora", "cmp"]
for i, mn in enumerate(ALU):
    for j, r in enumerate(R):
        OPS[0x80 + i * 8 + j] = (f"{mn}  {r}", 1)
for i, cc in enumerate(CC):
    OPS[0xC0 + i * 8] = (f"r{cc}", 1)
for i, rp in enumerate(RP_PSW):
    OPS[0xC1 + i * 0x10] = (f"pop  {rp}", 1)
    OPS[0xC5 + i * 0x10] = (f"push {rp}", 1)
for i, cc in enumerate(CC):
    mn = f"j{cc}"
    OPS[0xC2 + i * 8] = (f'{mn}{" " * (5 - len(mn))}{{a16}}', 3)
    mn = f"c{cc}"
    OPS[0xC4 + i * 8] = (f'{mn}{" " * (5 - len(mn))}{{a16}}', 3)
OPS[0xC3] = ("jmp  {a16}", 3)
OPS[0xCD] = ("call {a16}", 3)
IMM = ["adi", "aci", "sui", "sbi", "ani", "xri", "ori", "cpi"]
for i, mn in enumerate(IMM):
    OPS[0xC6 + i * 8] = (f"{mn}  {{d8}}", 2)
for i in range(8):
    OPS[0xC7 + i * 8] = (f"rst  {i}", 1)
OPS[0xC9] = ("ret", 1)
OPS[0xD3] = ("out  {d8}", 2)
OPS[0xDB] = ("in   {d8}", 2)
OPS[0xE3] = ("xthl", 1)
OPS[0xE9] = ("pchl", 1)
OPS[0xEB] = ("xchg", 1)
OPS[0xF9] = ("sphl", 1)
OPS[0xF3] = ("di", 1)
OPS[0xFB] = ("ei", 1)

BRANCH = {"jmp", "call"} | {f"j{c}" for c in CC} | {f"c{c}" for c in CC}


def disasm(data, org, basename):
    # Pass 1: walk linearly, collecting branch targets that land in
    # range *and* on an instruction boundary. Mid-instruction targets
    # mean the linear pass desynced (data being decoded as code), so
    # they're rendered as raw hex literals instead of loc_XXXX —
    # keeping the output assemblable.
    end = org + len(data)
    boundaries = set()
    branch_targets = set()
    pc = 0
    while pc < len(data):
        boundaries.add(org + pc)
        op = data[pc]
        entry = OPS.get(op)
        if entry is None or pc + entry[1] > len(data):
            pc += 1
            continue
        tmpl, size = entry
        first = tmpl.split()[0]
        if "{a16}" in tmpl and first in BRANCH:
            addr = data[pc + 1] | (data[pc + 2] << 8)
            if org <= addr < end:
                branch_targets.add(addr)
        pc += size

    emitted = branch_targets & boundaries

    out = [f"        org  {hexw(org)}", f"        section {basename}", ""]
    pc = 0
    while pc < len(data):
        addr = org + pc
        if addr in emitted:
            out.append(f"loc_{addr:04X}:")
        op = data[pc]
        entry = OPS.get(op)
        if entry is None or pc + entry[1] > len(data):
            out.append(f"        db   {hexb(op)}")
            pc += 1
            continue
        tmpl, size = entry
        rendered = tmpl
        if "{d8}" in rendered:
            rendered = rendered.replace("{d8}", hexb(data[pc + 1]))
        if "{a16}" in rendered:
            a = data[pc + 1] | (data[pc + 2] << 8)
            first = tmpl.split()[0]
            if first in BRANCH and a in emitted:
                rendered = rendered.replace("{a16}", f"loc_{a:04X}")
            else:
                rendered = rendered.replace("{a16}", hexw(a))
        out.append(f"        {rendered}")
        pc += size
    return "\n".join(out) + "\n"


def main():
    path = sys.argv[1]
    basename = path.rsplit("/", 1)[-1]
    org = int(sys.argv[2], 0)
    with open(path, "rb") as f:
        data = f.read()
    sys.stdout.write(disasm(data, org, basename))


if __name__ == "__main__":
    main()
