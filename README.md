# {{NAME}} disassembly

Reverse-engineered Intel 8080 source for `tape/{{NAME}}.{{EXT}}`,
an RK86 program loading at `{{ORG}}`. The `.asm` file in this
directory assembles to a byte-exact reproduction of the original
tape; verified by `just ci`.

## Layout

```text
tape/{{NAME}}.{{EXT}}    original tape file (do not modify)
{{NAME}}.bin             extracted payload (regenerable from tape)
{{NAME}}.asm             annotated source (the actual work product)
disasm.py                linear i8080 disassembler
tobin.py                 tape envelope stripper
Justfile                 build/test pipeline
```

## Common commands

```bash
just ci          # assemble {{NAME}}.asm and byte-diff vs the tape
                 # empty diff = green
just initial     # rebuild {{NAME}}.bin from tape/ (rare)
just disasm      # regenerate {{NAME}}.asm from {{NAME}}.bin
                 # WARNING: overwrites your annotations — commit first
just clean       # remove generated files
```

## Status

- [ ] Pass 0 — round-trip baseline (`just ci` clean against
      unedited linear disasm)
- [ ] Pass 1 — code/data split (no garbled instruction sequences;
      every byte classified)
- [ ] Pass 2 — semantic labels (every routine named; key
      variables identified)
- [ ] Pass 3 — annotations (idioms decoded, char comments on
      printable byte literals, video-memory writes commented)

Mark each pass complete only when `just ci` is clean.

## Tools

- `bunx asm8080` — assembler (https://github.com/begoon/asm8)
- `python3` — for `disasm.py` and `tobin.py`
- `just` — task runner
- `xxd` and `diff` — round-trip verification

## Reference

The reversing workflow, idioms cookbook, and RK86 hardware
reference live in the skill repo under
`rk86-skills/rk86-reversal/`. Consult them when in doubt about
a routine's role or a tape-format quirk.
