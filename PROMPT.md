# Segment prompt

Paste this into a new agent session. One segment per prompt. Do not edit this prompt.

```text
Read START_HERE.md and SEGMENT_AGENT.md before you write any asm. SEGMENT_AGENT.md is the queue. Take the first segment in its ROM map whose status is incbin. That file is the only segment this session.

NHL 96 Genesis follows NHL 95 Genesis. Names follow the lineage in the Current rules section of SEGMENT_AGENT.md: a routine that matches 95G takes its 95G name (clash rule applies), else 94G, else 93G, else 92G, else a name from what the code does. The reference repos are public GitHub repos listed in START_HERE.md (read them on GitHub; no clone needed).

1. Build first (Windows: npm run build:retail; Linux: tools/build_rom.sh). It must print MATCH before you change anything. If it does not, stop and report.
2. Open lst/nhl96.bin.lst and find your segment's range (SEGMENT_AGENT.md gives start and end; loc_ / sub_ / unk_ names are the address). Confirm the start and end from the listing. Copy the range into src/<segment>.asm in place of its incbin. Do not disassemble lst/nhl96.bin yourself and do not write a disassembler.
3. Find the matching 95G code: python3 tools/find95.py <segment> lists the 95G labels found in your range by their bytes; 95G docs/name_map.csv has every 95 label and address; compare with the 95G source. Where the 96 routine matches, take the 95G names, comments and local labels; where it does not, name it from what it does.
4. Outside addresses: a label in a segment that is still incbin goes in src/externs96.asm (one equate); a label in another converted segment goes as an equate in your stub, src/stubinc/<segment>_stub.asm. Labels inside your range that src/externs96.asm lists move out of it into your file. RAM names go in src/ram96.asm.
5. Follow the style rules (no history, provenance or origin-tag comments, no ROM addresses in comments, no derived counts; history goes in docs/name_map.csv).
6. Build after each batch of edits: the segment (npm run seg:<segment> / tools/verify_segment.sh <segment>) and the full ROM. Both must print MATCH, and the segment MATCH must cover its whole range.
7. In SEGMENT_AGENT.md mark the row matched with the byte count and the main names, and set Current segment to the next row. Add every label to docs/name_map.csv. Update docs/HANDOFF.md. Commit (one segment, MATCH in the message) and push to main (outside contributors: push to your fork and open a PR, see START_HERE.md).

Stop after 5 failed builds in a row. Report the file, the first differing ROM offset, the built byte, the retail byte, and the line you wrote. Do not continue.
```
