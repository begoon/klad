# Build/test pipeline for an RK86 disassembly project.
#
# Workflow:
#   1. Drop the original tape file into tape/<NAME>.<EXT>.
#   2. `just initial` — extract <NAME>.bin from the tape envelope.
#   3. `just disasm` — produce <NAME>.asm via linear disassembler.
#   4. Edit <NAME>.asm by hand, splitting code/data and adding labels.
#   5. `just ci` — assemble and byte-diff against tape/<NAME>.<EXT>.
#      Empty diff = green. Run after every edit.
#
# Customise NAME and EXT for your tape file. ORG is the load
# address printed by tobin.py during `just initial`.

NAME := "KLAD"
EXT  := "RK"            # one of: rk, rkr, pki, gam
ORG  := "0x3000"        # update to match the file header

ext  := lowercase(EXT)

ci: build test

build:
    bunx asm8080 --split -l --trailer-padding --format {{ ext }} {{ NAME }}.asm

test:
    xxd tape/{{ NAME }}.{{ EXT }} >tape/{{ NAME }}.{{ EXT }}.hex
    xxd {{ NAME }}.{{ ext }} >{{ NAME }}.{{ ext }}.hex
    diff tape/{{ NAME }}.{{ EXT }}.hex {{ NAME }}.{{ ext }}.hex

# Convert the tape file (envelope + trailer) to a raw binary file.
# Run this once when starting a new disassembly.
initial:
    uv run tobin.py tape/{{ NAME }}.{{ EXT }}
    mv tape/{{ NAME }}.bin {{ NAME }}.bin

# Linear disassembly. Re-run if the .bin changes (rarely needed).
# Beware: re-running overwrites your annotated .asm — commit first.
disasm:
    python3 disasm.py {{ NAME }}.bin {{ ORG }} >{{ NAME }}.asm

clean:
    rm -f {{ NAME }}.bin {{ NAME }}.{{ ext }} {{ NAME }}.bin.hex
    rm -f {{ NAME }}.{{ ext }}.hex {{ NAME }}.lst {{ NAME }}.sym
    rm -f {{ NAME }}.map {{ NAME }}.json
    rm -f tape/{{ NAME }}.{{ EXT }}.hex
