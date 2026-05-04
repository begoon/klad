#!/usr/bin/env python3
"""Strip the tape envelope from .rk / .rkr / .pki / .gam to a raw .bin.

.pki and .gam start with an E6 sync byte before the address header;
.rk and .rkr do not. The format is selected from the file extension
(case-insensitive). Output filename is the input with .bin extension.

Usage: tobin.py <tape-file>
"""

import pathlib
import sys


PKI_GAM = {".pki", ".gam"}
RK_RKR = {".rk", ".rkr"}


def strip_envelope(path: pathlib.Path) -> tuple[bytes, int, int]:
    data = path.read_bytes()
    ext = path.suffix.lower()

    if ext in PKI_GAM:
        if not data or data[0] != 0xE6:
            raise SystemExit(
                f"{path}: expected leading E6 sync byte for {ext} format"
            )
        data = data[1:]
    elif ext in RK_RKR:
        pass
    else:
        raise SystemExit(
            f"{path}: unknown extension {ext!r}; expected one of "
            ".rk, .rkr, .pki, .gam"
        )

    if len(data) < 4 + 3:
        raise SystemExit(f"{path}: file too short for header + trailer")

    start = (data[0] << 8) | data[1]
    end = (data[2] << 8) | data[3]
    if end < start:
        raise SystemExit(
            f"{path}: end address {end:04X}h before start {start:04X}h"
        )

    sz = len(data) - 4 - 3
    raw = data[4 : 4 + sz]
    return raw, start, end


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("usage: tobin.py <tape-file>")
    path = pathlib.Path(sys.argv[1])
    raw, start, end = strip_envelope(path)
    outpath = path.with_suffix(".bin")
    outpath.write_bytes(raw)
    print(f"wrote {len(raw)} bytes to {outpath}")
    print(f"header: start={start:04X}h end={end:04X}h "
          f"(declared payload {end - start + 1} bytes)")
    print(f"org {start:04X}h")


if __name__ == "__main__":
    main()
