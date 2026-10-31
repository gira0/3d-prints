# PCB outline and pin/hole layout: nice!nano v2 vs SuperMini / "Pro Micro nRF52840" clones

**Common coordinate frame used in all tables below (for OpenSCAD).** Units are mm. The board is seen from the TOP (component/USB side), with the USB end on the LEFT.
- Origin (0,0) is the board corner at the USB end, on the long edge next to the P0.06 / "pin 1" row (this is also the B- row).
- +X runs along the length, away from the USB end. +Y runs across the width, toward the RAW / B+ row.
- Z = 0 is the bottom face of the PCB.
- Board centreline: Y = 8.89.

In this view the P0.06 row is at the bottom and the RAW row is at the top. This matches the official nice!nano pinout image rotated 90° CCW, and the ICBbuy SuperMini dimension drawing as drawn.

Source frames and how they map to this frame:
- **SuperMini, vendor Altium PcbDoc:** X = X_alt − 95.631, Y = Y_alt − 86.995.
- **marbastlib nice_nano_AH_USBup.kicad_mod:** origin at the footprint centre, KiCad y pointing down. X = y_mb + 17.78, Y = x_mb + 8.89.
- **ceoloide mcu_nice_nano.js:** origin at the centre of the row pitch grid, with pin 1 at y = −12.7. X = y_ce + 16.51, Y = x_ce + 8.89.

---

## Board outline: length, width, thickness, corners, notches

### Takeaway
- **Footprint size:** both boards are 33.0 × 17.78 mm (33.02 mm = 1.3" in the CAD files).
- **SuperMini outline:** the vendor's official CAD outline is a sharp-cornered rectangle. It has a 9.40 × 5.80 mm cut-out at the USB end that holds the mid-mount USB-C receptacle.
- **nice!nano v2 outline:** the community 3D model has 0.5 mm corner radii and a 9.5 × ~7.2 mm USB notch.
- **PCB thickness:** no official figure was found for either board. The best evidence (community STEP model, plus the official "3.2 mm total thickness" with a mid-mount USB-C) points to 1.6 mm FR4 for the nice!nano. Measure a real board before final printing.

### Cited Findings

**SuperMini nRF52840 (official vendor files):**
- The ICBbuy wiki dimension drawing shows the following ([ICBbuy wiki dimension image](https://wiki.icbbuy.com/lib/exe/fetch.php?media=undefined:nrf52840_副本.jpg), linked from the "Dimensions" section of [ICBbuy wiki: nRF52840 SuperMini](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)):
  - Overall length: **33.00 mm**.
  - Width: **17.78 mm**.
  - Span from the first hole centre to the last hole centre along a row: **30.48 mm**.
  - Each long row has 13 hole positions: B+/B- plus 12 pins.
- The wiki links an official footprint file, "ProMicro_NRF52840 V1.2-PCB FootPrint.PcbDoc" (in a ZIP). I parsed it directly. Its KeepOut-layer outline is ([vendor footprint ZIP](https://wiki.icbbuy.com/lib/exe/fetch.php?media=developmentboard:qs-nrf52840_v1.2-pcb_footprint.zip)):
  - **Rectangle:** X 0 → 33.02, Y 0 → 17.78, with sharp corners. The file has no arcs on the outline layers.
  - **USB cut-out** at the USB end, open to the edge:
    - X 0 → 5.80
    - Y 4.19 → 13.59 (9.40 wide, centred on Y = 8.89)
  - **USB receptacle keep-out** (0.254 mm lines): X −0.684 → 5.598, Y 4.391 → 13.39 (≈9.0 mm wide). So the USB-C shell sticks out ≈0.68 mm past the board's USB edge.
  - **USB body outline** on Mechanical 15: X −0.677 → 5.823, Y 4.42 → 13.36 (6.5 × 8.94 mm).
- BlueDrink9 converted the same PcbDoc to KiCad. The conversion has some sloppiness ([BlueDrink9/supermini-nrf52840-kicad](https://github.com/BlueDrink9/supermini-nrf52840-kicad)):
  - Its Cmts.User outline rectangle is 17.78 × 33.02.
  - Its Edge.Cuts rectangles are 17.825 × 33.128 and 18.325 × 33.628. These are conversion artifacts, not the real board.
  - The README says it was "created … from the officially supplied `.pcbdoc` file".
- Thickness: a search-engine summary of the Keeb.io SuperMini listing said "1.6mm thick PCB". I could not verify it because the page returned HTTP 403 ([Keeb.io SuperMini listing](https://keeb.io/products/supermini-nrf52840-pro-micro-bluetooth-le-ble-controller)). Treat it as unconfirmed.

**nice!nano v2:**
- Official docs give only the total thickness ([nicekeyboards.com docs: nice!nano](https://nicekeyboards.com/docs/nice-nano/); [nicekeyboards.com/nice-nano](https://nicekeyboards.com/nice-nano/); [Nice-Keyboards docs repo README](https://github.com/Nice-Keyboards/nice-keyboards-docs/blob/master/docs/nice!nano/README.md)):
  - "Mid mount USB-C port making the board a 3.2mm total thickness (thinner than a Pro Micro)".
  - "the nice!nano is only 3.2mm thick".
  - "2U" ENIG, Tg 170 FR4".
  - No length, width or PCB thickness is published.
- Community STEP model "Nice_Nano_V2.step" by Joe Scotto, headers removed by infused-kim ([infused-kim/kb_ergogen_fp 3d_models](https://github.com/infused-kim/kb_ergogen_fp/tree/main/3d_models), source credited there to [joe-scotto/scottokeebs](https://github.com/joe-scotto/scottokeebs/tree/main/Extras/ScottoKicad/3dmodels/ScottoKeebs_MCU.3dshapes)). I parsed it with OpenCascade:
  - **PCB solid:** 17.78 × 33.00 × **1.60** mm.
  - **Board corners:** cylindrical faces at (±8.39, ±16.0) with r = 0.5 mm, giving **0.5 mm corner radii**.
  - **USB notch:** concave r = 0.5 fillets at the notch mouth, centred at (±5.25, 16.0). Inner corners have r = 0.5, centred at (±4.25, 9.82). So the notch is **9.5 mm wide (Y 4.14 → 13.64) and 7.18 mm deep (X 0 → 7.18)**.
  - **USB receptacle:**
    - 8.94 mm wide.
    - Protrudes **0.8 mm** beyond the board edge.
    - Spans Z −1.58 → +1.58 relative to the component-side PCB face, so it is flush with the back face of a 1.6 mm board.
    - Total thickness is ≈3.18 mm, consistent with the official 3.2 mm.
- marbastlib's footprints draw the controller outline in Cmts.User as **17.78 × 33.02 mm** ([marbastlib nice_nano_AH_USBup.kicad_mod](https://github.com/ebastler/marbastlib/blob/main/footprints/marbastlib-xp-promicroish.pretty/nice_nano_AH_USBup.kicad_mod)):
  - Rect (−8.89, −17.78) → (8.89, 15.24).
  - USB connector drawn 7.1 mm wide, protruding 1.52 mm.
- ceoloide's footprints draw the outline as **17.78 × 33.08 mm** ([ceoloide/ergogen-footprints mcu_nice_nano.js](https://github.com/ceoloide/ergogen-footprints/blob/main/mcu_nice_nano.js)):
  - Rect (−8.89, −16.51) → (8.89, 16.57).
  - USB drawn 7.366 wide, protruding 1.524 mm.
  - The SuperMini variant draws the USB protruding only 0.69 mm ([mcu_supermini_nrf52840.js](https://github.com/ceoloide/ergogen-footprints/blob/main/mcu_supermini_nrf52840.js)).

### Inferences
- **Outline for both boards:** model it as 33.02 × 17.78 mm. The 33.00 / 33.02 / 33.08 values differ by less than 0.1 mm, which is within routing tolerance.
- **Corners:** use r = 0.5 mm for the nice!nano. For the SuperMini, use sharp corners or a small radius; real boards are V-cut/routed, so check a physical board.
- **USB protrusion:** allow ≈0.7–0.8 mm past the board edge for the USB-C shell on both boards. The footprints' 1.52 mm is a coarse drawing, not a measurement.
- **USB height:** both boards use a mid-mount (sink) USB-C. The receptacle straddles the PCB and does not sit on top of it, so the case's USB opening must be centred near the PCB plane, not above it.
- **Total thickness:** model the PCB as 1.6 mm with the USB flush with the back face, for 3.2 mm overall. For the SuperMini this is unconfirmed; some clones may use 1.0 or 1.2 mm boards.

### Gaps
- No official nice!nano mechanical drawing, DXF or STEP model was found. All nice!nano numbers come from community footprints and community 3D models.
- PCB thickness is unconfirmed by any primary source for either board.
- Corner radii of the real SuperMini PCB are unknown. Other AliExpress "Pro Micro nRF52840" (Tenstar etc.) variants were not individually verified; they may differ, for example in thickness, USB connector type or extra-pin placement.

---

## The two long rows of 12 pins (plus B+/B-)

### Takeaway
- **Main rows (both boards):**
  - 2.54 mm pitch; the rows are 15.24 mm (0.6") apart.
  - Each row is 1.27 mm from its long edge.
  - Pin 1 is 3.81 mm from the USB edge, and pin 12 is 1.27 mm from the far edge.
- **B+/B- holes:** each row has a 13th position, B- (P0.06 row) or B+ (RAW row), at X = 1.27 next to the USB.
- **SuperMini module holes:** 0.9144 mm drill with 1.6 mm pads; the B+/B- holes are smaller (0.762 mm drill).

### Cited Findings
- **SuperMini row positions** from the vendor PcbDoc, in the common frame ([vendor footprint ZIP](https://wiki.icbbuy.com/lib/exe/fetch.php?media=developmentboard:qs-nrf52840_v1.2-pcb_footprint.zip)):
  - **Pin-1 / B- row:** Y = 1.27.
  - **RAW / B+ row:** Y = 16.51.
  - **Hole X positions:** 1.27 (B±), then 3.81, 6.35, … 31.75 (12 pins). This means 1.27 mm margins at both ends: 1.27 + 30.48 + 1.27 = 33.02.
  - **Hole sizes:**
    - Pin holes: 0.9144 mm drill (36 mil) on 1.6 mm round pads.
    - B+ and B-: 0.762 mm drill (30 mil) on 1.6 mm pads.
    - BlueDrink9's conversion has the same sizes ([BlueDrink9 kicad_mod](https://github.com/BlueDrink9/supermini-nrf52840-kicad)).
- **SuperMini pin labels** from the ICBbuy drawing, read from the USB end ([ICBbuy dimension image](https://wiki.icbbuy.com/lib/exe/fetch.php?media=undefined:nrf52840_副本.jpg)):
  - Pin-1 row: B-, 006, 008, GND, GND, 017, 020, 022, 024, 100, 011, 104, 106.
  - RAW row: B+, RAW, GND, RST, VCC, 031, 029, 002, 115, 113, 111, 010, 009.
- **nice!nano v2 row positions:**
  - marbastlib: pins at x = ±7.62, y = −13.97 … +13.97 at 2.54 pitch, with the outline from −17.78 to +15.24. That puts pin 1 at X = 3.81 and pin 12 at X = 31.75 ([marbastlib nice_nano_AH_USBup](https://github.com/ebastler/marbastlib/blob/main/footprints/marbastlib-xp-promicroish.pretty/nice_nano_AH_USBup.kicad_mod)).
  - marbastlib also has extra pads 28 (GND/B-) at (−7.62, −16.51) and 29 (BAT+) at (+7.62, −16.51), i.e. X = 1.27. The marbastlib symbol maps 28 = GND and 29 = BAT+ ([marbastlib-promicroish.kicad_sym](https://github.com/ebastler/marbastlib/blob/main/symbols/marbastlib-promicroish.kicad_sym)).
  - Joe Scotto STEP: rows at x = ±7.62, with the first hole 3.79 mm from the USB edge and the last hole 1.27 mm from the far edge. Hole radius is 0.45 mm (0.9 mm drill). The model has no B+/B- holes ([infused-kim/kb_ergogen_fp Nice_Nano_V2.step](https://github.com/infused-kim/kb_ergogen_fp/tree/main/3d_models)).
- **Official nice!nano v2 pinout image** ([nice!nano pinout image](https://nicekeyboards.com/static/1788ac663060fd510f4894b286cd97b1/a6d36/pinout-v2.png), on [nicekeyboards.com pinout page](https://nicekeyboards.com/docs/nice-nano/pinout-schematic)):
  - Left column, USB up: GND (B-) pad next to the USB, then P0.06, P0.08, GND, GND, P0.17, P0.20, P0.22, P0.24, P1.00, P0.11, P1.04, P1.06.
  - Right column: BATTERY+ pad next to the USB, then BATTERY+ (RAW), GND, RESET, 3.3V, P0.31, P0.29, P0.02, P1.15, P1.13, P1.11, P0.10, P0.09.
- **nice!nano B+/B- usage:** official getting-started text says to "ignore the B+ and B- pins when adding sockets or headers" ([nice!nano getting_started.md](https://github.com/Nice-Keyboards/nice-keyboards-docs/blob/master/docs/nice!nano/getting_started.md)).
- **Keyboard-side footprint drills (host PCB, not module holes):** marbastlib uses 1.0 mm drill / 1.8 mm pad, and ceoloide uses 1.0 mm drill / 1.7 mm pad ([marbastlib](https://github.com/ebastler/marbastlib/blob/main/footprints/marbastlib-xp-promicroish.pretty/nice_nano_AH_USBup.kicad_mod); [ceoloide](https://github.com/ceoloide/ergogen-footprints/blob/main/mcu_nice_nano.js)).

### Inferences
- The main 2×12 grid is identical on both boards, as required for Pro Micro compatibility. It sits on the long centreline Y = 8.89 ± 7.62.
- Both boards place B+/B- at X = 1.27 in line with the rows. They are thin battery-wire pads/holes and normally carry no header, so a case only needs clearance for battery wires soldered there.
- On the nice!nano, the official doc calls these "pins" and marbastlib gives them holes, but the community STEP model omits them. Their exact size on the nice!nano is unverified.

### Gaps
- Exact module drill and pad sizes for the nice!nano v2 are not published. The 0.9 mm comes from a community 3D model.

---

## The 3 extra pins (P1.01, P1.02, P1.07)

### Takeaway
- **Location on both boards:** the extras are at the end opposite the USB, in a 2.54 mm-pitch row parallel to the short edge. The row is offset toward the P0.06 row, not centred.
- **They differ between the boards.** The SuperMini's extras are ≈1.985 mm further from the USB and 0.54 mm further toward the RAW side than the nice!nano's. Both ceoloide and BlueDrink9 warn that the two are not interchangeable.

### Cited Findings
- **nice!nano v2 (marbastlib):** pads 25/26/27 = P1.01/P1.02/P1.07 at (−5.08, 8.89), (−2.54, 8.89), (0, 8.89). That gives X = 26.67 (in line with pin 10, P0.11/P0.10), Y = 3.81 / 6.35 / 8.89. So P1.07 sits exactly on the board centreline ([marbastlib nice_nano_AH_USBup](https://github.com/ebastler/marbastlib/blob/main/footprints/marbastlib-xp-promicroish.pretty/nice_nano_AH_USBup.kicad_mod); pin names from [marbastlib-promicroish.kicad_sym](https://github.com/ebastler/marbastlib/blob/main/symbols/marbastlib-promicroish.kicad_sym)).
- **nice!nano v2 (ceoloide):** P101/P102/P107 at x = −5.08 / −2.54 / 0, y = 10.16 (pin 1 at y = −12.7). That gives X = 26.67, Y = 3.81 / 6.35 / 8.89, the same as marbastlib. The footprint notes: "the extra pins are *ONLY* compatible with nice!nano boards and not with clones like the Supermini, which has pins in a slightly different position" ([ceoloide mcu_nice_nano.js](https://github.com/ceoloide/ergogen-footprints/blob/main/mcu_nice_nano.js)).
- **nice!nano v2 (Joe Scotto STEP):** three 0.9 mm holes 2.54 apart, in line with the pin-10 holes and 6.35 mm from the far edge. That gives X = 26.65, Y = 3.81 / 6.35 / 8.89, which agrees ([infused-kim/kb_ergogen_fp](https://github.com/infused-kim/kb_ergogen_fp/tree/main/3d_models)).
- **nice!nano v2 (official pinout image):** the back-side view labels P1.01, P1.02 and P1.07 at three pads near the end opposite the USB, next to the SWC/SWD pads ([nice!nano pinout image](https://nicekeyboards.com/static/1788ac663060fd510f4894b286cd97b1/a6d36/pinout-v2.png)).
- **SuperMini (vendor PcbDoc):** three holes, 0.889 mm drill on 1.5748 mm pads, at X = **28.655**, Y = **4.35 / 6.89 / 9.43**. That is 3.08 / 5.62 / 8.16 mm from the pin-1 row and 4.365 mm from the far edge ([vendor footprint ZIP](https://wiki.icbbuy.com/lib/exe/fetch.php?media=developmentboard:qs-nrf52840_v1.2-pcb_footprint.zip)).
- **SuperMini cross-checks:**
  - BlueDrink9: (3.08 / 5.62 / 8.16, 27.3852) from the B- hole, which is the same ([BlueDrink9 kicad_mod](https://github.com/BlueDrink9/supermini-nrf52840-kicad)).
  - ceoloide SuperMini: x = −4.54 / −2.00 / +0.54, y = −13.2548 + 25.4 = 12.1452, which is the same ([ceoloide mcu_supermini_nrf52840.js](https://github.com/ceoloide/ergogen-footprints/blob/main/mcu_supermini_nrf52840.js)).
  - marbastlib SuperMini: −4.5466 / −2.0066 / 0.5334 at y = 10.87628, giving X = 28.656 ([marbastlib SuperMini_nRF52840_AH_USBup](https://github.com/ebastler/marbastlib/blob/main/footprints/marbastlib-xp-promicroish.pretty/SuperMini_nRF52840_AH_USBup.kicad_mod)).
- **Which hole is which on the SuperMini:**
  - ceoloide and marbastlib assign P1.01 to the hole nearest the P0.06 row, then P1.02, then P1.07 (nearest the centre or past it).
  - On the SuperMini, P1.07 is 0.54 mm on the RAW side of the centreline.
  - An ICBbuy wiki comment notes the extra pins were missing from an earlier pin diagram ("已经更新了" = "has been updated") ([ICBbuy wiki](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)).

### Inferences
- For a case that must fit both boards, make the extra-pin clearance cut-out cover X ≈ 25.6–29.7, Y ≈ 2.8–10.4. That covers both layouts with a 1 mm margin around 1.6 mm pads.

### Gaps
- No official nice!nano CAD exists to confirm the community-derived extra-pin coordinates. Three independent community sources agree to within 0.06 mm.
- The P1.01 → P1.07 ordering on the SuperMini comes from community footprints. The vendor PcbDoc only numbers the holes 1/2/3, with 1 nearest the P0.06 row.

---

## Other pads (battery, reset, SWD) and back-side features

### Takeaway
- **Back-side pads:** both boards have flush SMD debug pads on the back. They stick out < 0.1 mm and only matter if you want access for an SWD probe.
- **USB-C mounting slots:** the SuperMini has four plated slots beside its USB notch. Their solder fillets protrude on the back near the USB end.
- **Biggest clearance items:** the USB-C shell (±1.6 mm around the PCB plane, 0.7–0.8 mm past the edge) and the B+/B- battery wires at X = 1.27.

### Cited Findings
- **SuperMini back-side pads** (vendor PcbDoc, bottom layer, [vendor footprint ZIP](https://wiki.icbbuy.com/lib/exe/fetch.php?media=developmentboard:qs-nrf52840_v1.2-pcb_footprint.zip)):
  - Four 1.0 × 1.0 mm SMD pads at 1.5 mm pitch, at X = 24.158 / 25.657 / 27.157 / 28.657, Y = 13.488. These are almost certainly the SWD debug pads; the PcbDoc names them all "0".
  - Two 0.8 × 0.65 mm pads at (10.642, 12.878) and (12.066, 12.878). Their purpose is unlabelled.
- **SuperMini USB-C shell tabs** (vendor PcbDoc): plated oval slots 0.65 mm wide. They sit just outside the USB cut-out, at Y = 3.31 and Y = 14.47:
  - At X = 1.423: 1.2 × 2.4 pads, slot ≈0.65 × 1.70.
  - At X = 5.423: 1.2 × 2.0 pads, slot ≈0.65 × 1.40.
  - Slot lengths come from [BlueDrink9's conversion](https://github.com/BlueDrink9/supermini-nrf52840-kicad).
- **SuperMini top-side USB-C SMD pads:** a row at X ≈ 6.29, Y 5.68 → 12.10 (PcbDoc).
- **nice!nano v2** ([nice!nano pinout image](https://nicekeyboards.com/static/1788ac663060fd510f4894b286cd97b1/a6d36/pinout-v2.png)):
  - SWC and SWD pads on the back, near the end opposite the USB, next to the extra pins.
  - A "BOOST" solder jumper on the back, near the RST/GND end.
  - Battery+ and GND (B-) pads next to the USB on both sides.
- **nice!nano USB-C shell tabs:** the Joe Scotto STEP shows four plated slots (r = 0.25 mm slot ends) at Y ≈ 3.30 and 14.47. They run X ≈ 0.86 → 1.71 and 5.46 → 6.31 from the USB edge ([infused-kim/kb_ergogen_fp](https://github.com/infused-kim/kb_ergogen_fp/tree/main/3d_models)).
- **Battery fit (official docs):** a 301230 battery "is 3mm thick and fits underneath a socketed nice!nano very nicely" ([Nice-Keyboards docs README](https://github.com/Nice-Keyboards/nice-keyboards-docs/blob/master/docs/nice!nano/README.md)).
- **Module + battery height (official FAQ):** "fitting a battery underneath will make the entire module + battery 6mm tall when hotswapped" ([nice!nano FAQ](https://github.com/Nice-Keyboards/nice-keyboards-docs/blob/master/docs/nice!nano/faq.md)).

### Inferences
- The USB shell tab slots on both boards sit at nearly the same positions (Y ≈ 3.3 / 14.47). This suggests the clone copied the nice!nano's USB-C part and placement.

### Gaps
- The exact positions of the nice!nano's SWD pads, battery pads and reset pads are not available in any CAD source found.
- Reset on the SuperMini is only via the RST pin; I did not verify whether there is a reset button.

---

## Coordinate tables (copy into OpenSCAD)

All values use the common frame defined at the top (top view, USB at X = 0, pin-1 / B- row at Y = 1.27). Hole Ø is the module's own drill.

### Main rows: identical on both boards

| Pos | X | Y (P0.06 row) | label | Y (RAW row) | label |
|---|---|---|---|---|---|
| 0 | 1.27 | 1.27 | B- (GND) | 16.51 | B+ |
| 1 | 3.81 | 1.27 | P0.06 (D1) | 16.51 | RAW / BAT+ |
| 2 | 6.35 | 1.27 | P0.08 (D0) | 16.51 | GND |
| 3 | 8.89 | 1.27 | GND | 16.51 | RST |
| 4 | 11.43 | 1.27 | GND | 16.51 | VCC 3.3V |
| 5 | 13.97 | 1.27 | P0.17 | 16.51 | P0.31 |
| 6 | 16.51 | 1.27 | P0.20 | 16.51 | P0.29 |
| 7 | 19.05 | 1.27 | P0.22 | 16.51 | P0.02 |
| 8 | 21.59 | 1.27 | P0.24 | 16.51 | P1.15 |
| 9 | 24.13 | 1.27 | P1.00 | 16.51 | P1.13 |
| 10 | 26.67 | 1.27 | P0.11 | 16.51 | P1.11 |
| 11 | 29.21 | 1.27 | P1.04 | 16.51 | P0.10 |
| 12 | 31.75 | 1.27 | P1.06 | 16.51 | P0.09 |

Formula: X = 1.27 + 2.54·k for k = 0..12.

Hole sizes:
- **SuperMini:** pins Ø0.9144 drill / Ø1.6 pad; B± Ø0.762 drill / Ø1.6 pad (vendor PcbDoc).
- **nice!nano:** pins ≈Ø0.9 drill (community STEP); B± size unverified.

### Extra pins

| Pin | nice!nano v2 X | nice!nano v2 Y | SuperMini X | SuperMini Y |
|---|---|---|---|---|
| P1.01 | 26.67 | 3.81 | 28.655 | 4.35 |
| P1.02 | 26.67 | 6.35 | 28.655 | 6.89 |
| P1.07 | 26.67 | 8.89 | 28.655 | 9.43 |

Hole sizes: nice!nano ≈Ø0.9 drill (community); SuperMini Ø0.889 drill / Ø1.575 pad (vendor).

### Outline and USB

| Feature | nice!nano v2 (community STEP / footprints) | SuperMini (vendor PcbDoc) |
|---|---|---|
| Board | 33.0–33.08 × 17.78; use 33.02 | 33.02 × 17.78 (drawing: 33.00) |
| PCB thickness | 1.6 (community STEP only) | unconfirmed (1.6 claimed in a listing summary) |
| Corner radius | 0.5 | none in CAD (sharp) |
| USB notch | X 0–7.18, Y 4.14–13.64, r 0.5 fillets | X 0–5.80, Y 4.19–13.59 |
| USB shell | ≈8.94 wide, protrudes 0.8, Z −1.58..+1.58 about the component face | keep-out ≈9.0 wide, protrudes 0.68 |
| Total thickness | 3.2 (official) | n/a |
