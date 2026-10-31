# Soldered 2.54 mm headers on Pro Micro-format nRF52840 boards, and existing case designs

Scope: header and socket dimensions needed to model the soldered pins in OpenSCAD; header orientation and the 3 extra end pins; existing cases for nice!nano, Pro Micro nRF52840 and SuperMini nRF52840; FDM enclosure guidance; useful OpenSCAD libraries. All units are mm. Research date 2026-10-31.

Note on sources: Printables (and Core Electronics) returned HTTP 403 to automated fetches, so Printables model details come from search-engine snippets only. Several header datasheets are image-only PDFs. Values marked **[unverified]** come from general industry knowledge or aggregator snippets, not from a primary datasheet I could read. Measure your own parts with calipers before finalising.

## 1. Standard 2.54 mm male and female header dimensions, and low-profile (Mill-Max) sockets

### Takeaway
Plan for a male header with a 2.54 × 2.54 mm plastic spacer per pin that is about 2.5 mm tall, a 0.64 mm (0.025") square post, and an overall length of about 11.5–11.6 mm (≈6 mm long side, ≈3 mm short side). The usual straight female header is 8.5 mm tall with a ≈3.2 mm tail. The Mill-Max 315 "super low profile" socket sits 2.11 mm above the board, but its holes take only 0.38–0.56 mm round pins, so standard square header pins do not fit it.

### Cited Findings
**Male header (generic and branded)**
- Post size on Samtec TSW-series 2.54 mm headers: 0.025" (0.635 mm) square. Insulator: black glass-filled polyester. — [mymectronic Samtec TSW listing (aggregator)](https://www.mymectronic.com/part-detail/Samtec/TSW11025TS)
- A generic 1×20 2.54 mm male header has an overall pin length of 11.5 mm and overall dimensions of 50.8 × 3.5 × 11.5 mm (L × W × H). — [Core Electronics CE08367 (search snippet; page returned 403)](https://core-electronics.com.au/header-male-pin-01x20.html.plain.md)
- An Amtek 2.54 mm straight pin-header datasheet offers plastic heights of 1.5, 1.7 and 2.5 mm. Its "standard" row is total 11.60, A = 6.00, B = 3.00. This matches the common 6 mm mating side + 2.5 mm plastic + 3 mm tail. The snippet did not label the dimensions explicitly. — [Amtek/chipdip datasheet (search snippet; PDF is image-only)](https://static.chipdip.ru/lib/159/DOC041159199.pdf)
- The JLCPCB listing for the Harwin M20-9990345 (3-pin M20 male header) gives "3mm" and "6.1mm" dimensions, consistent with a ≈3 mm tail and ≈6.1 mm mating length. — [JLCPCB part C3337081](https://jlcpcb.com/partdetail/Harwin-M209990345/C3337081)
- Harwin M20-series headers use 0.64 mm square pins. — [JLCPCB/Harwin M20-9990646 snippet](https://jlcpcb.com/partdetail/Harwin-M209990346/C5355646)
- For Würth WR-PHD single-row straight headers (61301x11121), the body length is pins × 2.54 (12-pin = 30.48 mm, 3-pin = 7.62 mm). — [Würth WR-PHD product page](https://www.we-online.com/en/components/products/BTB_WR_PHD_2_54_MM_PIN_HEADER_SINGLE)
- **[unverified]** Body (insulator) cross-section is about 2.5 × 2.5 mm per pin. Each pin's plastic is slightly less than 2.54 mm long so that broken-off pieces butt together. The Core Electronics "3.5 mm" width above probably includes moulding flash or a measurement convention. Model the plastic as 2.54 wide with about 0.3 mm clearance.
- **[unverified]** Common variants: plastic heights of 1.5 / 2.5 / 3.0 mm, and long-tail or "stacking" pins of 15–19 mm total. Cheap kit headers that ship with Pro Micro clones are generally the 11.5 mm / 2.5 mm-plastic type. Diagonal of a 0.64 mm square pin = 0.905 mm.

**Female header**
- EVE/Rapid straight single-row 2.54 mm female header: height 8.5 mm. Tolerances: .X ±0.25, .XX ±0.20. — [Rapid 02-6979 datasheet (PDF)](https://static.rapidonline.com/pdf/02-6979_v1.pdf)
- Sullins female header drawing 10492: body height 8.50 mm, body width 2.54 mm, tail 3.20 ±0.30 mm, tail 0.40 mm thick × 0.75 mm wide, recommended PCB hole 1.02 mm. — [Sullins drawing 10492 (PDF)](https://drawings-pdf.s3.amazonaws.com/10492.pdf)

**Low-profile sockets (Mill-Max)**
- Mill-Max 315-43-1XX-41-00x000 single-row sockets are 0.083" (2.11 mm) above the board, using 0.050" (1.27 mm) thick insulators. Total length is 0.149" (3.78 mm), with a 0.067" tail below the board for boards up to 1.57 mm. The 0.072" (1.83 mm) sleeve diameter fits a 0.029" (0.74 mm) PCB hole. Accepted lead diameter is 0.015–0.022" (0.38–0.56 mm). — [Mill-Max PR685 / Series 315 datasheet (PDF)](https://www.mill-max.com/sites/default/files/external/assets/2018-03/PR685%20-%20Super%20Low%20Profile%20sockets%20315%20-%20415.pdf)
- When mated with Mill-Max 335-10-1XX-00-160000 low-profile headers, the board-to-board height is 0.155" (3.94 mm). — same source
- The keyboard community pairs Mill-Max 315 sockets with thin Mill-Max 3320 pins. This is the lowest option and leaves no room for a battery under the controller. — [42keebs socketing guide](https://42keebs.eu/build-guides/socketing-the-frood-nice-nano-controllers/); [splitkb Mill-Max low profile sockets](https://splitkb.com/products/mill-max-low-profile-sockets)
- splitkb lists 315-43-112-41-003000 (12-pin) for nice!nano. — [splitkb](https://splitkb.com/products/mill-max-low-profile-sockets); part description "CONN RCPT 12POS 0.1 GOLD PCB" at [smbom](https://www.smbom.com/product/315-43-112-41-003000-3798957)
- 42keebs describes three socketing tiers: (a) Mill-Max 315 with 3320 pins, lowest, no battery; (b) generic medium-profile sockets with thin pins, which fit a battery up to 3 mm; (c) high-profile sockets with the standard square header pins included with the controller, which fit a battery of 4.5–5 mm. — [42keebs](https://42keebs.eu/build-guides/socketing-the-frood-nice-nano-controllers/)
- Typeractive: Mill-Max pins "sit about 2mm above the top of the socket when fully inserted". — [Typeractive nice!nano guide](https://docs.typeractive.xyz/build-guides/corne-wireless/nice-nano)
- nice!nano: total board thickness is 3.2 mm thanks to the mid-mount USB-C port, and a 301230 battery (3 mm) fits under a socketed nice!nano. — [nice!nano docs](https://nicekeyboards.com/docs/nice-nano/)

### Inferences
- Suggested OpenSCAD header model per pin: plastic `cube([2.54, 2.54, 2.5])` on the PCB face; post `0.64 × 0.64`, about 6.0 mm beyond the plastic on the long side and about 3.0 mm on the short side. With a 1.0–1.6 mm PCB, the short side's protrusion beyond the far PCB face is about 1.4–2.0 mm, plus a solder fillet (dome ≈1.5–2 mm dia). See section 2.
- Envelope from the PCB face on the header side: 2.5 (plastic) + 6.0 (pins) ≈ 8.5 mm. The case needs at least about 9 mm under the board if the pins are fully enclosed.
- Standard square pins (0.64 mm square, 0.9 mm diagonal) will not enter Mill-Max 315 receptacles (max 0.56 mm). This matters only if the user ever wants to socket the board.

### Gaps
- I could not read a primary manufacturer drawing that states the male header insulator height of exactly 2.5 mm and the 6/3 split together. The Amtek drawing is image-only, and the Sullins PRPC and Samtec TSW drawings were not retrieved. Treat 2.5 / 6.0 / 3.0 / 11.5–11.6 as typical, and measure the user's actual kit headers, because cheap clone kits vary by ±0.3 mm or more.
- The Mill-Max 3320 pin dimensions were not retrieved.

## 2. Typical header orientation on these boards and top-side protrusion

### Takeaway
For breadboard or dev use, the plastic spacer normally goes on the underside (component side up, long pins downward), and only the short tails plus solder show through on top. In keyboards the controller is often mounted "face down" instead. I found no source that measures the tail protrusion after soldering. Estimate about 1.5–3 mm above the PCB including the solder fillet, and measure the actual board.

### Cited Findings
- In keyboard builds, headers go into the keyboard PCB with the short side in, and the nice!nano is placed face down (chips and logo facing the keyboard PCB). — [Typeractive guide](https://docs.typeractive.xyz/build-guides/corne-wireless/nice-nano)
- Controllers are "traditionally installed upside down, with the component side toward the PCB". 42keebs also advises trimming the excess pins as close to the controller PCB as possible with flush cutters, and optionally filing them. — [42keebs](https://42keebs.eu/build-guides/socketing-the-frood-nice-nano-controllers/)
- nice!nano docs warn about "flipped nice!nanos with pins poking out underneath" puncturing batteries. Pin protrusion on the far side is a known hazard. — [nice!nano docs](https://nicekeyboards.com/docs/nice-nano/)
- SparkFun's Pro nRF52840 Mini hookup guide shows male headers soldered in and plugged into a breadboard. — [SparkFun hookup guide](https://learn.sparkfun.com/tutorials/sparkfun-pro-nrf52840-mini-hookup-guide/hardware-assembly)

### Inferences
- Short-side tail of 3.0 mm minus PCB thickness gives the protrusion. Clone boards are commonly 1.0–1.2 mm thick: (3.2 mm total for the nice!nano including the mid-mount USB-C [nice!nano docs](https://nicekeyboards.com/docs/nice-nano/), but the bare PCB is thinner), so expect about 1.8–2.0 mm of pin above the top copper, plus a solder cone up to about 2 mm diameter. Design a top-side clearance of 3 mm, or a 2.5–3 mm deep pocket or slot over each pin row about 2.6–3 mm wide. **[inference; verify with calipers]**
- Untrimmed pin tails may also have been soldered so that the plastic sits on the top side (pins up). The case code should parametrise `header_side = "bottom" | "top"`.

### Gaps
- I found no measured value for post-solder tail protrusion on these specific clone boards.
- The exact PCB thickness of the user's clone board was not found (Elecrow lists only 17.8 × 33 mm). — [Elecrow product page](https://www.elecrow.com/pro-micro-nrf52840-development-board-compatible-with-nice-nano-v2-0.html)

## 3. The 3 extra pins at the board's end: are they supplied, and in which orientation?

### Takeaway
Unclear. The Elecrow version of the user's board ships with only 2 × 13-pin headers (26 pins). Two 12-pin rows use 24 of these, which leaves 2, not the 3 a 3-pin header needs. So the user probably cut or used a separate 3-pin strip. Any orientation would normally match the long rows (same side) so that the board can sit flat on a breadboard.

### Cited Findings
- Elecrow "Pro Micro NRF52840 Development Board compatible with nice!nano V2.0" contents: 1 × board and 2 × 13-pin headers. Board dimensions are 17.8 × 33 mm and weight 10 g. The page has no text describing the 3 end pins. — [Elecrow product page](https://www.elecrow.com/pro-micro-nrf52840-development-board-compatible-with-nice-nano-v2-0.html)
- Typeractive notes that in Corne keyboards the top B+/B- pins get no headers and only the bottom 12 per column are used. — [Typeractive](https://docs.typeractive.xyz/build-guides/corne-wireless/nice-nano)

### Inferences
- The 3 end pins sit inboard of the two long rows, between them near the short edge opposite USB-C. With headers on the same side as the long rows, a 3-pin plastic block (7.62 × 2.54 × 2.5) sits between the rows. Long rows plus end header together form a "U". A case that fully encloses the pins must clear this U; a breadboard-exposing case must leave it open. If the end pins don't land on the 2.54 grid of the long rows, they would short or straddle on a breadboard. Check this.

### Gaps
- No source found that confirms which header kits include a dedicated 3-pin strip, or the exact position and pitch of the end pins on the clone (they are P1.01/P1.02/P1.07 on the nice!nano v2 layout; positions not verified here). Measure.

## 4. Existing case designs (Printables, Thingiverse, MakerWorld, GitHub)

### Takeaway
Prior art is thin. The only cases found for this exact board are two Printables "dongle" cases with snap-on lids and LED holes, and they appear to assume a bare board with no headers. No OpenSCAD source for a nice!nano or SuperMini nRF52840 case was found. ESP32 SuperMini cases (a similar small form factor) show common patterns: two-piece snap fit, button and LED holes, and parametric source files.

### Cited Findings
- "Pro-micro nicenano nrf52840 dongle case" (Printables 1285346): a case for an nRF52840 board used as a wireless-keyboard dongle. The lid snaps in place, and two small holes line up with the SuperMini/Pro Micro LEDs. — [Printables 1285346](https://www.printables.com/model/1285346-pro-micro-nicenano-nrf52840-dongle-case) (details from search snippet; page returned 403)
- A remix, "Promicro nicenano nrf52840 dongle case with reset button" (Printables 1464325), adds a lid opening for a soldered reset button and reduces the case height by 0.5 mm. Updated 2025-10-30. — [Printables 1464325](https://www.printables.com/model/1464325-promicro-nicenano-nrf52840-dongle-case-with-reset)
- A ZMK dongle config notes that its dongles use Seeed XIAO BLE in a 3D-printed case rather than a nice!nano. — [eigatech/zmk-config](https://github.com/eigatech/zmk-config)
- MakerWorld ESP32-S3/C3 SuperMini cases: a two-piece snap-fit, screwless case with boot/reset button openings and LED openings, an opener tool, and wall-mount options (screw or 8 × 2 mm magnets). Another is friction fit. One commenter reported a bad fit, and the designer said SuperMini boards from different vendors vary slightly in size and tolerance, so a parametric Fusion (.f3d) file is included. — [MakerWorld 2851590](https://www.makerworld.com/en/models/2851590); [circuit.rocks snap-fit ESP32-C3 SuperMini case](https://blog.circuit.rocks/a-snap-fit-3d-printed-case-for-the-esp32-c3-super-mini)
- The SlimeVR "Smol" trackers use an nRF52840 SuperMini clone in a 3D-printed enclosure; their enclosure files were not examined. — [PCBWay SlimeVR Smol Trackers](https://www.pcbway.com/project/shareproject/SlimeVR_Smol_Trackers_27d7922a.html)
- Nordic DevZone: there are no official housings for nRF eval boards. — [Nordic DevZone](https://test-devzone.nordicsemi.com/f/nordic-q-a/86140/housing-for-eval-boards/359599)
- Generic OpenSCAD case projects that could be adapted: Juerd/picoglitcher-case (single file, reversible lid) and robertmeisner/modular-3d-printed-case (parametric, CC BY-NC-SA). — [picoglitcher-case](https://zff.dev/Juerd/picoglitcher-case); [modular-3d-printed-case](https://github.com/robertmeisner/modular-3d-printed-case/blob/master/README.md)

### Inferences
- No found design deliberately exposes the headers for breadboard use. Existing dongle cases appear to be for header-less boards (the remix reduces the height, which suggests a tight enclosure). A case for a board with headers on all pins is a gap the user would be filling.
- Two viable topologies: (a) "breadboard sleeve": an open-bottom tray that hugs the PCB and lets the pins plus plastic spacer pass through a slot, with a lid over the top side that has pockets over the solder tails. (b) Fully enclosed box with ≥9 mm of internal depth under the PCB.
- Board-to-board variation is a real issue (MakerWorld comment). Make the PCB pocket parametric with about 0.2–0.3 mm per side of clearance.

### Gaps
- I could not read the Printables pages, so wall thickness, USB-C opening size and tolerances of the dongle cases are unknown.
- No Thingiverse result specific to nice!nano or SuperMini nRF52840 cases was found. No GitHub OpenSCAD model for these boards was found.

## 5. FDM small-enclosure design guidance and OpenSCAD libraries

### Takeaway
YAPP_Box defaults give a good, citable baseline: wall 2.8 mm (thinner walls such as 1.2–1.6 mm are common for tiny cases), floor and lid 1.6 mm, lid-to-base ridge slack 0.2 mm, and PCB standoff 1.0 mm. BOSL2 provides `$slop`-aware snap pins, rabbit clips, joiners and dovetails, but its `$slop` defaults to 0 and must be calibrated (about 0.1–0.2).

### Cited Findings
- YAPP_Box v3 default parameters: `wallThickness = 2.8`, `basePlaneThickness = 1.6`, `lidPlaneThickness = 1.6`, `ridgeHeight = 5.0`, `ridgeSlack = 0.2` ("Gap between the inside of the lid and the outside of the base"), `pcbThickness = 1.6`, `standoffHeight = 1.0` ("room for solderings"), `paddingFront = 1`, `roundRadius = wallThickness + 1`, `printerLayerHeight = 0.2`. — [YAPPgenerator_v3.scad](https://raw.githubusercontent.com/mrWheel/YAPP_Box/main/YAPPgenerator_v3.scad)
- YAPP_Box features: the design starts from the PCB dimensions and padding, and adds standoffs, a base/lid ridge with slack, screw inserts (e.g. Ruthex), snap joins (including symmetric ones), and per-plane cutouts (left/right/front/back/base/lid) with rotation. — [mrWheel/YAPP_Box](https://github.com/mrWheel/YAPP_Box); [Hackaday](https://hackaday.io/project/186808/log/214868)
- BOSL2 `joiners.scad` provides `snap_pin(..., clearance=0.2)`, `snap_pin_socket`, `rabbit_clip(..., compression=0.1, clearance=.1, lock=false)`, `dovetail`, `joiner` and `half_joiner`. — [BOSL2 joiners.scad](https://raw.githubusercontent.com/BelfrySCAD/BOSL2/master/joiners.scad)
- BOSL2 `$slop` is "`0.0` by default". It enlarges internal features so that joiners and partitions mate, but its effect varies with printer, material, orientation and small holes. The docs suggest passing a custom value (e.g. `$slop=0.17`) and point to a test print in issue #1679. — [BOSL2 constants.scad](https://raw.githubusercontent.com/BelfrySCAD/BOSL2/master/constants.scad)
- Header tolerances in connector drawings run from ±0.20 to ±0.30 mm (Sullins tail 3.20 ±0.30; EVE .X ±0.25). The case must absorb at least this much on top of print error. — [Sullins 10492](https://drawings-pdf.s3.amazonaws.com/10492.pdf); [Rapid 02-6979](https://static.rapidonline.com/pdf/02-6979_v1.pdf)

### Inferences
- Suggested starting values (inferred from the above plus typical FDM practice with a 0.4 mm nozzle; **[not from a single cited source]**):
  - Walls of 1.2–1.6 mm (3–4 perimeters) for a case this small.
  - PCB pocket clearance of 0.2–0.3 mm per side; 0.3–0.4 mm around header plastic.
  - Lid lip/ridge slack of 0.15–0.2 mm.
  - USB-C opening about 9.5 × 3.8 mm. The receptacle shell is about 8.94 × 3.26 mm, and a plug overmould needs more, often 11–12 × 6–7 mm with a chamfer.
  - Print the base floor-down and the lid top-down; avoid supports in the header slots.
- For snap fits on walls this thin, a continuous lip (ridge) with a small 0.3–0.5 mm bump, or BOSL2 `rabbit_clip`, works better than cantilever snaps. Alternatively, a friction-fit lid with a 0.1–0.15 mm interference.

### Gaps
- I found no source-backed FDM guide giving numeric clearances specifically for small electronics enclosures, beyond YAPP and BOSL2 defaults.
- USB-C receptacle and plug overmould dimensions were not researched here (likely covered by an adjacent researcher).
