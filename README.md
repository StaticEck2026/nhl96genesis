# NHL 96 Genesis

Bitwise rebuild of NHL 96 for the Sega Genesis, in the style of [NHL95Genesis](https://github.com/abdulahmad/NHL95Genesis). The full build is byte for byte the retail ROM (SHA-1 `7204633fbb9966ac637e7966d02ba15c5acdee6b`); each segment also builds and verifies on its own. Most segments are still `incbin`s of the ROM; they are converted to source one at a time (`SEGMENT_AGENT.md`).

Start with `START_HERE.md` (setup, build, contributor workflow), then `SEGMENT_AGENT.md` (rules and the ROM map queue) and `PROMPT.md` (the per-segment prompt).

| Path | What it is |
| --- | --- |
| `lst/nhl96.bin`, `lst/nhl96.bin.lst` | The reference ROM (2 MB) and its IDA listing (ASM68K / MRI mode, no address column). |
| `src/nhl96.asm` | Top level: the equates, `org 0`, every segment in ROM order with its start address, the `$FF` fill. |
| `src/<segment>.asm` | One file per segment, no `org`. |
| `src/stubinc/` | `<segment>_stub.asm` (org, equates, outside addresses, the segment) plus `ports.inc` and `equals.inc` (from 95G). |
| `src/ram96.asm`, `src/externs96.asm` | RAM map; equates for addresses still inside incbin segments. |
| `tools/` | `prebuild.js`, `extractSegments96.js`, `segmap96.json`, `make_segmap96.py`, `fixopcodes.js`, `verifyRom.js`, `verifySegment.js`, `build_rom.sh`, `verify_segment.sh`, `verify_all.sh`. |
| `docs/` | `HANDOFF.md`, `name_map.csv`. |

Build: Windows `npm run build:retail` / `npm run seg:<name>`; Linux with wine `tools/build_rom.sh` / `tools/verify_segment.sh <name>` / `tools/verify_all.sh`. Logs go to `output/`.
