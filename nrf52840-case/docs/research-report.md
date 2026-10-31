# Fitting a fully-headered nRF52840 Pro Micro case

The board is **33.02 × 17.78 mm** on both variants. Its two long rows of 2.54 mm pins are identical on the nice!nano v2 and the SuperMini / "Pro Micro nRF52840" clones: rows at **Y = 1.27 and Y = 16.51**, pins at **X = 3.81 … 31.75**, and the B−/B+ battery holes at X = 1.27. The only layout difference that matters for a case is the **3 extra pins** (P1.01/P1.02/P1.07). On the nice!nano they sit at **X = 26.67, Y = 3.81/6.35/8.89**. On the SuperMini they sit at **X = 28.655, Y = 4.35/6.89/9.43**, about 2 mm further from the USB and 0.54 mm further across the board. One cut-out spanning **X 25.0–30.3, Y 2.1–11.1** fits the 3-pin header plastic of either board. With standard headers soldered plastic-down (breadboard orientation), the assembly runs from the long pin tips at **Z ≈ −8.5** to the top of the USB-C shell at **Z ≈ +3.2**. The case therefore needs an inside depth of about **13 mm**: a floor at Z ≤ −9.0 and a lid ceiling at Z ≈ +4.0. The inside footprint is roughly **34.5 × 18.5 mm**. The SuperMini figures come from the vendor's own Altium footprint. The nice!nano figures come from three community CAD sources that agree to within 0.06 mm. **PCB thickness, header plastic height and pin lengths are unpublished or vary by kit**, so measure those four or five numbers with calipers before the final print.

## As built: measured board and print results

The case was built and test-fitted on 2026-10-31 for the Elecrow-style "Pro Micro NRF52840 compatible with nice!nano V2.0" board. Caliper measurements of that board differed from the researched defaults in three ways that mattered. The final values are the defaults in `nrf52840_case.scad`:

| Value | Researched default | Measured / final | Effect on the case |
|---|---|---|---|
| PCB thickness `pcb_t` | 1.6 (unconfirmed) | **1.6** | confirmed |
| Header plastic `hdr_plastic` | 2.5 | **2.5** | confirmed |
| Long pin below plastic `hdr_long` | 6.0 | **6.0** | confirmed |
| Board length `pcb_l` | 33.02 | **32.9** | case 0.12 mm shorter |
| Pins per long row `row_pins` | 12 (B−/B+ holes for wires only) | **13**: the header also goes through B−/B+ | pin slots start at X = 1.27, not 3.81 |
| Tallest solder joint above PCB top `tail_above` | 1.4 | **2.0** | tails reach Z 3.6; below the USB-C, so not limiting |
| USB-C shell top above PCB underside `usb_top` | 3.2 (mid-mount, sunk into the PCB) | **4.0**: the receptacle sits on top of the PCB | receptacle axis at Z ≈ 2.4; lid ceiling at 4.3 |
| USB plug opening | 12.5 × 7.0 rectangle | **11.0 × 6.0, 2 mm corner radius** | neater; fits slim cables (check yours) |

So **this board does not use the mid-mount USB-C described in the Z-stack section below**, and **its B−/B+ holes accept header pins**. Both points contradict the research notes for the official boards. Clones vary, so measure. The finished case measures **38.75 × 22.88 × 16.8 mm** on the outside, with the split line at Z ≈ 0.1.

Results of the prints (Anycubic Kobra S1, 0.4 mm nozzle, 0.2 mm layers, Anycubic PLA+ black, textured PEI plate):

- **Board fit:** good. All 13 + 13 + 3 pins drop into their slots, and the USB-C lines up with the opening.
- **First lid: about 0.4 mm of vertical play,** audible when shaken. The snap windows had about 0.3 mm of free travel before the bump engaged, plus layer rounding. The fix is `snap_preload = 0.15`: the lower edge of each window now rests on the bump's 45° lower face, which pulls the lid down onto the base.
- **First engraving: unreadable.** It used a one-line 5 mm "OpenPuck" with a 0.5 mm first-layer line width. The squished first layer filled the strokes, and "P" closed into an "F". The fix had three parts:
  - two lines ("Open" / "Puck") at size 6.8 with 1.05 letter spacing;
  - `first_layer_comp = 0.15`, which widens the engraving in the first layer;
  - a slicer first-layer line width of 0.42.
  
  The result is clearly readable. The logo was replaced by a bold primitive-drawn mark (`logo = "simple"`) whose islands and gaps are all ≥ 1 mm.
- **Remaining cosmetic issue:** stringing and small blobs at the free ends of the base tongue on either side of the USB opening. Trim them with a knife, or reduce them with wipe-on-retract or about 200 °C.

## One frame for a 33.02 × 17.78 mm board

All values below use one coordinate frame, in millimetres. Look at the board from the component side, with the USB-C on the left. The **origin is the board corner at the USB end, on the long edge next to the B− / P0.06 row**. **+X runs along the length away from the USB**, **+Y runs across the width toward the B+ / RAW row**, and **Z = 0 is the bottom face of the PCB**, with +Z toward the components. The board centreline is Y = 8.89.

The research notes used three other origins. This is how each maps onto the frame above:

| Source frame | Conversion to this frame |
|---|---|
| B− hole origin, X across, Y along (BlueDrink9 KiCad, notes on components) | X = Y_src + 1.27, Y = X_src + 1.27 |
| Vendor Altium PcbDoc | X = X_alt − 95.631, Y = Y_alt − 86.995 |
| marbastlib footprint centre (KiCad y down) | X = y + 17.78, Y = x + 8.89 |
| ceoloide grid centre | X = y + 16.51, Y = x + 8.89 |

Every converted coordinate in this report was cross-checked across at least two of these frames. For example, the SuperMini extra pins come out at the same place from the vendor PcbDoc and from the B−-origin values (3.08/5.62/8.16, 27.39).

The SuperMini vendor publishes a dimension drawing showing **33.00 × 17.78 mm** with a 30.48 mm span from the first to the last hole in each row ([ICBbuy wiki](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)). Its official footprint file (PcbDoc) has a **sharp-cornered 33.02 × 17.78 rectangle**. It also has a 9.40 × 5.80 mm notch at the USB end (X 0–5.80, Y 4.19–13.59) that holds the mid-mount USB-C ([vendor footprint ZIP](https://wiki.icbbuy.com/lib/exe/fetch.php?media=developmentboard:qs-nrf52840_v1.2-pcb_footprint.zip)). One of the notes reports a ±0.3 mm uncertainty in the outline. That figure came from the KiCad conversion, whose Edge.Cuts rectangles are conversion artifacts ([BlueDrink9](https://github.com/BlueDrink9/supermini-nrf52840-kicad)). The directly parsed PcbDoc overrides it.

Nice!Keyboards publishes no length or width for the nice!nano v2, only that the mid-mount USB-C makes it **3.2 mm thick overall** ([nice!nano docs](https://nicekeyboards.com/docs/nice-nano/)). A community STEP model gives the nice!nano as **17.78 × 33.00 × 1.60 mm with 0.5 mm corner radii**. In that model the USB notch is 9.5 mm wide and 7.18 mm deep ([infused-kim/kb_ergogen_fp](https://github.com/infused-kim/kb_ergogen_fp/tree/main/3d_models)). Keyboard footprints draw the board at 33.02 and 33.08 mm long ([marbastlib](https://github.com/ebastler/marbastlib/blob/main/footprints/marbastlib-xp-promicroish.pretty/nice_nano_AH_USBup.kicad_mod); [ceoloide](https://github.com/ceoloide/ergogen-footprints/blob/main/mcu_nice_nano.js)). Elecrow lists the board this question is about as **17.8 × 33 mm** ([Elecrow](https://www.elecrow.com/pro-micro-nrf52840-development-board-compatible-with-nice-nano-v2-0.html)). All of these values fall within 0.1 mm of each other, so **model 33.02 × 17.78** and let the pocket clearance absorb the rest.

**PCB thickness is the weakest number.** It is 1.6 mm in the community nice!nano model, and a Keeb.io listing summary claims 1.6 mm for the SuperMini but could not be verified. The official 3.2 mm total is consistent with a 1.6 mm board because the USB shell sits flush with the back face, as explained in the Z-stack section. Use 1.6 mm, but **measure it**: some clones may use 1.0–1.2 mm boards.

## Twenty-six main holes share a grid; the three extras do not

The main grid is the Pro Micro standard, and both boards follow it exactly. In the vendor PcbDoc, the B−/P0.06 row is at **Y = 1.27** and the B+/RAW row is at **Y = 16.51**, 15.24 mm apart. Holes are at **X = 1.27 + 2.54·k for k = 0..12**, leaving a 1.27 mm margin at each end ([vendor footprint ZIP](https://wiki.icbbuy.com/lib/exe/fetch.php?media=developmentboard:qs-nrf52840_v1.2-pcb_footprint.zip)). Position k = 0 is the battery hole (B− or B+). Positions k = 1..12 are the 12 header pins. The SuperMini pin holes are **Ø0.9144 mm on Ø1.6 mm pads**. The battery holes are smaller, **Ø0.762 mm**. The marbastlib footprint and the Joe Scotto STEP place the nice!nano pins identically, at X = 3.81 … 31.75 with Ø≈0.9 holes ([marbastlib](https://github.com/ebastler/marbastlib/blob/main/footprints/marbastlib-xp-promicroish.pretty/nice_nano_AH_USBup.kicad_mod); [infused-kim](https://github.com/infused-kim/kb_ergogen_fp/tree/main/3d_models)).

| k | X | P0.06 row (Y = 1.27) | RAW row (Y = 16.51) |
|---|---|---|---|
| 0 | 1.27 | B− (GND), battery only | B+, battery only |
| 1 | 3.81 | P0.06 | RAW / BAT+ |
| 2 | 6.35 | P0.08 | GND |
| 3 | 8.89 | GND | **RST** |
| 4 | 11.43 | GND | VCC 3.3 V |
| 5 | 13.97 | P0.17 | P0.31 |
| 6 | 16.51 | P0.20 | P0.29 |
| 7 | 19.05 | P0.22 | P0.02 |
| 8 | 21.59 | P0.24 | P1.15 |
| 9 | 24.13 | P1.00 | P1.13 |
| 10 | 26.67 | P0.11 | P1.11 |
| 11 | 29.21 | P1.04 | P0.10 |
| 12 | 31.75 | P1.06 | P0.09 |

Labels come from the vendor drawing and the official nice!nano pinout ([ICBbuy wiki](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840); [nice!nano pinout](https://nicekeyboards.com/docs/nice-nano/pinout-schematic)). Nice!Keyboards tells users to "ignore the B+ and B- pins when adding sockets or headers" ([getting_started.md](https://github.com/Nice-Keyboards/nice-keyboards-docs/blob/master/docs/nice!nano/getting_started.md)). On the SuperMini, a square 0.64 mm header post (0.905 mm across the diagonal) cannot pass through a Ø0.762 hole. A 12-pin row covering X 3.81–31.75 is therefore the physical reality. The battery holes at X = 1.27 only ever take wires.

**The extra pins are where the boards diverge.** Three independent sources put the nice!nano's P1.01/P1.02/P1.07 at **X = 26.67** (in line with pin 10) and **Y = 3.81 / 6.35 / 8.89**. P1.07 sits exactly on the centreline, and the pins stay on the main 2.54 grid ([marbastlib](https://github.com/ebastler/marbastlib/blob/main/footprints/marbastlib-xp-promicroish.pretty/nice_nano_AH_USBup.kicad_mod); [ceoloide](https://github.com/ceoloide/ergogen-footprints/blob/main/mcu_nice_nano.js); [infused-kim STEP](https://github.com/infused-kim/kb_ergogen_fp/tree/main/3d_models)). The SuperMini vendor PcbDoc puts them at **X = 28.655, Y = 4.35 / 6.89 / 9.43**, on Ø0.889 drills with Ø1.575 pads. That position is off the main grid ([vendor footprint ZIP](https://wiki.icbbuy.com/lib/exe/fetch.php?media=developmentboard:qs-nrf52840_v1.2-pcb_footprint.zip)). The ceoloide and marbastlib SuperMini footprints confirm these coordinates. Ceoloide warns that the nice!nano's extra pins are "*ONLY* compatible with nice!nano boards and not with clones like the Supermini" ([ceoloide SuperMini](https://github.com/ceoloide/ergogen-footprints/blob/main/mcu_supermini_nrf52840.js)).

| Extra pin | nice!nano v2 (X, Y) | SuperMini (X, Y) |
|---|---|---|
| P1.01 | 26.67, 3.81 | 28.655, 4.35 |
| P1.02 | 26.67, 6.35 | 28.655, 6.89 |
| P1.07 | 26.67, 8.89 | 28.655, 9.43 |

**Checking your board takes one glance.** If the 3-hole row lines up with the 10th header pin from the USB end (P0.11), it is nice!nano geometry. If it sits almost in line with the 11th pin (P1.04, 0.55 mm short of it), it is SuperMini geometry. The notes do not establish which layout the Elecrow "compatible with nice!nano V2.0" board uses. Generic clones usually follow the SuperMini. The Elecrow board also ships with only **2 × 13-pin headers** ([Elecrow](https://www.elecrow.com/pro-micro-nrf52840-development-board-compatible-with-nice-nano-v2-0.html)). After the two 12-pin rows, one spare pin is left from each strip. The 3-pin strip was therefore either cut from a separate header or put together from leftover pieces, and its plastic may sit higher or lower than the long rows. Measure it.

## Soldered headers turn a 3.2 mm board into an 11.7 mm stack

In Z, both boards use a **mid-mount (sink) USB-C** that sits in the PCB notch rather than on top of the board. The community nice!nano STEP has the shell spanning **±1.58 mm about the component face**: on a 1.6 mm PCB that is **Z ≈ 0.02 to 3.18**. The shell is flush with the back face, which gives the official 3.2 mm total ([infused-kim](https://github.com/infused-kim/kb_ergogen_fp/tree/main/3d_models); [nice!nano docs](https://nicekeyboards.com/docs/nice-nano/)). The shell is about **8.94 mm wide** and protrudes **0.8 mm** past the USB edge in that model. In the SuperMini PcbDoc it protrudes 0.68 mm, and the keep-out runs X −0.684 → 5.598, Y 4.39 → 13.39 ([vendor footprint ZIP](https://wiki.icbbuy.com/lib/exe/fetch.php?media=developmentboard:qs-nrf52840_v1.2-pcb_footprint.zip)). One of the notes gave a different Z split (0.8 mm above and 0.8 mm below the PCB). That was an estimate with no geometry behind it, and the parsed STEP overrides it. Still, the SuperMini's Z position is unconfirmed, so the case should keep 0.3 mm of margin below Z = 0 at the USB end.

Everything else on the boards is single-sided. The top carries a bare nRF52840 QFN, crystals, SOT-23 regulators, LEDs and, on the SuperMini, a ceramic chip antenna. The back has only flush pads: the BOOST jumper, the SWD pads and the extra-pin holes ([ICBbuy wiki](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840); [nice!nano pinout image](https://nicekeyboards.com/static/1788ac663060fd510f4894b286cd97b1/a6d36/pinout-v2.png)). Top-side parts of these package types are typically ≤1.2 mm tall. Modelling a 1.5 mm block over the whole top face (Z 1.6–3.1) is safe, and the USB shell sets the true maximum at Z ≈ 3.2. On the back there are four plated USB-shell tab slots, at Y ≈ 3.31 / 14.47 and X ≈ 1.42 / 5.42. Their solder fillets stick out about 0.3–0.5 mm below Z = 0, between the header rows ([BlueDrink9](https://github.com/BlueDrink9/supermini-nrf52840-kicad)).

**The headers dominate the envelope.** No manufacturer drawing could be read that states every dimension of a male header. The convergent typical values are a **0.64 mm square post** ([JLCPCB/Harwin M20](https://jlcpcb.com/partdetail/Harwin-M209990346/C5355646)), **2.5 mm plastic**, a **6.0 mm long side** and a **3.0 mm short side**, for **11.5–11.6 mm overall** ([Amtek datasheet snippet](https://static.chipdip.ru/lib/159/DOC041159199.pdf); [Core Electronics](https://core-electronics.com.au/header-male-pin-01x20.html.plain.md); [JLCPCB M20-9990345](https://jlcpcb.com/partdetail/Harwin-M209990345/C3337081)). Plastic heights of 1.5–3.0 mm also exist, and connector drawings allow ±0.2–0.3 mm ([Sullins 10492](https://drawings-pdf.s3.amazonaws.com/10492.pdf)). A 12-pin body is 12 × 2.54 = 30.48 mm long ([Würth WR-PHD](https://www.we-online.com/en/components/products/BTB_WR_PHD_2_54_MM_PIN_HEADER_SINGLE)). Centred on X = 3.81…31.75, it covers **X 2.54 → 33.02**, ending flush with the far edge of the board. The two 2.54 mm-wide bodies sit **flush with the long edges**, at Y 0–2.54 and 15.24–17.78.

In the default breadboard orientation the plastic sits under the board. The plastic occupies **Z −2.5 → 0**, the long pins reach **Z −8.5**, and the short tails stop at **Z +3.0**. That is 1.4 mm above a 1.6 mm board's top face, below the USB top. If the tails are trimmed flush they matter even less. The solder fillet is a cone around the tail, about Ø1.5–2 mm, and does not rise above the pin tip. The 3-pin strip sits between the rows at the same Z levels. Its plastic covers **X 25.40–27.94, Y 2.54–10.16** on the nice!nano and **X 27.385–29.925, Y 3.08–10.70** on the SuperMini. On the nice!nano the 3-pin plastic butts directly against the P0.06-row plastic at Y = 2.54. Together the three headers form a "U" open toward the USB end. Note that keyboard builders often mount the board the other way, face-down with the long pins up ([Typeractive](https://docs.typeractive.xyz/build-guides/corne-wireless/nice-nano)). For that reason the parameters below include a `hdr_side` switch.

| Z level (header plastic on the bottom, 1.6 mm PCB) | Z (mm) | Status |
|---|---|---|
| Long pin tips | −8.5 | measure (±0.3) |
| Header plastic bottom: the natural resting datum | −2.5 | **measure** (1.5–3.0 exist) |
| USB-tab solder fillets | ≈ −0.5 | estimate |
| PCB bottom / origin | 0 | — |
| PCB top / component face / USB axis | 1.6 | **measure** |
| Header short-tail tips | 3.0 | measure after soldering |
| Top-side component keep-out top | 3.1 | estimate |
| USB-C shell top | 3.18–3.2 | official 3.2 total |

## Clearances that fit both variants in one case

**Use the header plastic, not the PCB, as the support.** The long-row bodies cover both long edges from X 2.54 to 33.02, so no ledge can reach the PCB's bottom edges there. The obvious datum is a shelf or ribs under the plastic at Z = −2.5. Below that, the floor can either sit at Z ≤ −9.0, enclosing the pins fully, or have slots for the pins to pass through, which gives a breadboard "sleeve". Existing Printables dongle cases for this board appear to assume a bare board with no headers. No OpenSCAD source for a headered case was found, so this design fills a real gap ([Printables 1285346](https://www.printables.com/model/1285346-pro-micro-nicenano-nrf52840-dongle-case); [Printables 1464325](https://www.printables.com/model/1464325-promicro-nicenano-nrf52840-dongle-case-with-reset)).

The clearances below combine published defaults with connector tolerances. YAPP_Box defaults to 0.2 mm lid-ridge slack, 1.6 mm floor and lid planes, and a 1.0 mm standoff "for solderings" ([YAPP_Box v3](https://raw.githubusercontent.com/mrWheel/YAPP_Box/main/YAPPgenerator_v3.scad)). BOSL2's `$slop` defaults to 0 and should be calibrated to about 0.1–0.2 ([BOSL2 constants](https://raw.githubusercontent.com/BelfrySCAD/BOSL2/master/constants.scad)). Header tolerances of ±0.2–0.3 mm stack on top of print error ([Sullins 10492](https://drawings-pdf.s3.amazonaws.com/10492.pdf)). A SuperMini case designer has also reported that boards from different vendors differ slightly in size ([circuit.rocks](https://blog.circuit.rocks/a-snap-fit-3d-printed-case-for-the-esp32-c3-super-mini)).

| Feature | Recommended default | Notes |
|---|---|---|
| PCB pocket | 0.25 mm per side → 33.52 × 18.28 | 0.2–0.3; raise to 0.35 for unknown clones |
| Header plastic pockets | 0.35 mm per side | covers the ±0.25 moulding tolerance plus FDM |
| Pin slots / holes | 1.2 mm wide (0.905 mm post diagonal) | Ø1.2 holes if you want each pin located |
| Long-row slot | X 2.19–33.37, Y −0.35–2.89 and 14.89–18.13 | starting at X = 0.0 also clears a 13-pin strip at no cost |
| **3-pin cut-out (both variants)** | **X 25.05–30.28, Y 2.19–11.05** | union of both plastic bodies + 0.35; merges into the P0.06-row slot |
| Floor below pins | Z ≤ −9.0 (tips −8.5 + 0.5) | or slot the floor for a breadboard sleeve |
| Lid ceiling | Z = 4.0 | USB top 3.2 + tails 3.0 + 0.5–0.8 margin |
| USB shell keep-out | X −1.1 → 6.1, Y 4.1 → 13.7, Z −0.3 → 3.5 | 0.3 mm around the 8.94 × 3.18 shell |
| USB plug opening in wall | 12.5 × 7.0 centred at Y 8.89, Z 1.6 | 12.34 × 6.50 overmold + about 0.1 per side |
| Lid-to-base slack | 0.15–0.2 mm | YAPP default 0.2 |
| Walls | 1.2–1.6 mm; thin to ≤1.2 at the USB face | a thick wall stops plugs from seating |

The USB plug opening follows the commonly cited **12.34 × 6.50 mm** overmold envelope ([Glenair 804-388](https://draft.glenair.com/superseal/series-801-804-805/usb-3-2/pdf/804-388.pdf)). Center it on the **receptacle axis at Z = 1.6** (the component face), not on the middle of the PCB. The opening then spans Z −1.9 to 5.1, so it crosses the base/lid split. Many aftermarket cables exceed this envelope. One designer of a recessed port settled on 12.5 mm ([Digi-Key forum](https://forum.digikey.com/t/overmold-size-of-the-usb-c-male-end/70874)). With these values the inside of the case measures about **34.5 × 18.5 × 13.0 mm** (X −1.1→33.37, Y −0.35→18.13, Z −9.0→4.0). With 1.6 mm walls the outside is about **37.7 × 21.7 × 16.2 mm**.

Four smaller features are worth planning for. **Neither board has a reset button.** Reset, and bootloader entry by double-tap, means shorting **RST (X 8.89, Y 16.51)** to the adjacent **GND (X 6.35, Y 16.51)** ([nice!nano troubleshooting](https://nicekeyboards.com/docs/nice-nano/troubleshooting); [Tindie SuperMini](https://www.tindie.com/products/adz1122/supermini-nrf52840-development-board-for-nicenano/)). A side slot or bottom hole at those long-pin positions allows tweezer access. The **battery holes B−/B+ at (1.27, 1.27) and (1.27, 16.51)** take wires, not headers. They need about 2 mm of wire exit on each side of the USB opening ([nice!nano docs](https://nicekeyboards.com/docs/nice-nano/)). The **antenna is at the end opposite the USB**: a ceramic chip on the SuperMini and a PCB trace on the nice!nano ([joric wiki](https://github.com/joric/nrfmicro/wiki/Alternatives)). Keep metal such as screws, inserts and magnets more than 7 mm from X ≈ 28–33 ([Microchip guidelines](https://onlinedocs.microchip.com/oxy/GUID-9DEF0110-B60A-445F-B120-FC5000EE0D2F-en-US-2/GUID-624CFF30-02D2-4443-95F9-5159CACA5DB3.html)). A plain PLA or PETG wall is fine. **LED positions are not dimensioned anywhere.** The SuperMini's red LED appears near the RAW/GND pins, which is roughly X 5–8, Y 13–15 in this frame (±1.5 mm, estimated from the vendor render) ([ICBbuy wiki](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)). A lid window at about X 5–9, Y 4–15 would likely show both LEDs on either board. Confirm the position on your board.

## Ready-to-paste OpenSCAD parameters

*This block is the research-stage starting point. It is superseded by `nrf52840_case.scad`, which contains the measured values from the as-built section.*

The block below encodes everything above. It uses the frame defined earlier. Values marked `MEASURE` should be replaced with caliper readings. `board_envelope()` produces the solid you subtract from the case body. It already includes clearances, so `difference() { case_body(); board_envelope(); }` gives the cavity.

```openscad
// ===== Pro Micro nRF52840 (nice!nano v2 / SuperMini) — case parameters =====
// Frame: origin = PCB bottom face, board corner at USB end on the B-/P0.06 edge.
// +X along length away from USB, +Y across toward B+/RAW row, +Z up (component side).

/* [Board] */
variant = "both";      // "nicenano" | "supermini" | "both" (cut-out fits either)
pcb_l   = 33.02;       // MEASURE (vendor 33.00-33.02)
pcb_w   = 17.78;       // MEASURE
pcb_t   = 1.6;         // MEASURE (unconfirmed; clones may be 1.0-1.2)
pcb_r   = 0.5;         // nice!nano 0.5; SuperMini CAD is sharp (0)

/* [Pin grid] */
pitch   = 2.54;
row_y   = [1.27, 16.51];                          // P0.06 row, RAW row
bat_x   = 1.27;                                   // B-/B+ holes (wires only)
pin_x   = [for (k = [1:12]) 1.27 + k * pitch];    // 3.81 ... 31.75
rst_xy  = [8.89, 16.51];  gnd_rst_xy = [6.35, 16.51];
extra_nn = [[26.67, 3.81], [26.67, 6.35], [26.67, 8.89]];      // P1.01, P1.02, P1.07
extra_sm = [[28.655, 4.35], [28.655, 6.89], [28.655, 9.43]];
extra_sets = variant == "nicenano"  ? [extra_nn]
           : variant == "supermini" ? [extra_sm]
           : [extra_nn, extra_sm];

/* [USB-C, mid-mount] */
usb_w   = 8.94;        // shell width
usb_h   = 3.18;        // shell height, centred on component face
usb_x0  = -0.8;        // front face (protrudes 0.68-0.8)
usb_x1  = 5.82;        // rear of shell
usb_cy  = pcb_w / 2;   // 8.89
usb_cz  = pcb_t;       // axis at component face
plug_w  = 12.5;  plug_h = 7.0;   // overmold opening in wall

/* [Headers] */
hdr_side    = "bottom"; // "bottom" = plastic under PCB, long pins down (breadboard)
hdr_plastic = 2.5;      // MEASURE (1.5 / 2.5 / 3.0 exist)
hdr_long    = 6.0;      // MEASURE long side beyond plastic
hdr_short   = 3.0;      // MEASURE short side incl. PCB (tail top = Z 3.0)
hdr_post    = 0.64;

/* [Clearances] */
clr_pcb   = 0.25;
clr_hdr   = 0.35;
clr_usb   = 0.3;
clr_pin_z = 0.5;
pin_slot  = 1.2;
top_keep  = 1.5;        // component block above PCB top
lid_ceiling_z = 4.0;
floor_z   = -(hdr_plastic + hdr_long) - clr_pin_z;   // -9.0 with defaults

module board_envelope() {
    // PCB pocket + top-side keep-out up to the lid ceiling
    translate([-clr_pcb, -clr_pcb, 0])
        cube([pcb_l + 2*clr_pcb, pcb_w + 2*clr_pcb, lid_ceiling_z]);
    // USB-C shell
    translate([usb_x0 - clr_usb, usb_cy - usb_w/2 - clr_usb, usb_cz - usb_h/2 - clr_usb])
        cube([usb_x1 - usb_x0 + 2*clr_usb, usb_w + 2*clr_usb, usb_h + 2*clr_usb]);
    // Plug overmold path through the -X wall
    translate([usb_x0 - clr_usb - 10, usb_cy - plug_w/2, usb_cz - plug_h/2])
        cube([10, plug_w, plug_h]);
    if (hdr_side == "bottom") {
        // Long rows (start at X=0 so a 13-pin strip also fits)
        for (y = row_y) {
            translate([0, y - pitch/2 - clr_hdr, -hdr_plastic - clr_hdr])
                cube([pcb_l + clr_hdr, pitch + 2*clr_hdr, hdr_plastic + clr_hdr]);
            translate([0, y - pin_slot/2, floor_z])
                cube([pcb_l, pin_slot, -floor_z]);
        }
        // 3-pin end header(s)
        for (s = extra_sets) {
            translate([s[0][0] - pitch/2 - clr_hdr, s[0][1] - pitch/2 - clr_hdr, -hdr_plastic - clr_hdr])
                cube([pitch + 2*clr_hdr, 3*pitch + 2*clr_hdr, hdr_plastic + clr_hdr]);
            translate([s[0][0] - pin_slot/2, s[0][1] - pin_slot/2, floor_z])
                cube([pin_slot, 2*pitch + pin_slot, -floor_z]);
        }
    }
}
```

With `variant = "both"` the two 3-pin blocks merge into one opening covering X 25.05–30.28, Y 2.19–11.05. For `hdr_side = "top"`, mirror the header geometry in Z about the PCB. The plastic then occupies Z 1.6 → 4.1 and the pins reach about Z 10.1, so the lid must rise accordingly. The tails then protrude below the board, to roughly Z −1.4.

## The two-part snap-fit case (`nrf52840_case.scad`)

The case file next to this report implements the design above for the header-plastic-down orientation. With the measured values it measures **38.75 × 22.88 × 16.8 mm** on the outside.

- **Base.** A floor plus a solid "bed" whose top sits at Z = −`hdr_plastic`. Both long header strips and the 3-pin strip rest on it. Each row of long pins drops into a 1.2 mm slot. `row_pins` sets 12 or 13 pins per row. The slots stop 0.6 mm past the first and last pin, so the pins also stop the board from sliding when a USB cable is pushed in or pulled out. A 1.0 mm tongue rises 4 mm above the split line and carries one snap bump on each long side.
- **Lid.** A roof plus a skirt that slides over the tongue with 0.2 mm clearance per side. The bumps catch in rectangular windows in the skirt. The lower edge of each window is preloaded 0.15 mm onto the bump's 45° lower face (`snap_preload`), which pulls the lid tight against the base. The lid can still be pried off using the notch at the antenna end. The ceiling sits 0.3 mm above the tallest of the USB shell and the solder tails. A small pad over the USB shell stops the board lifting when a cable is pulled.
- **Split line.** It falls at Z ≈ 0.1. The rounded USB plug opening (`plug_w` × `plug_h`, default 11 × 6 mm) is centred on the receptacle axis, `usb_top − 1.59`. It is cut through both halves as open notches, so it needs no bridges.
- **Engraving** (lid top): a logo plus a two-line label (`label`, default "Open" / "Puck"), 0.6 mm deep. `logo` can be `"simple"` (a bold mark drawn from primitives), `"svg"` (the file set in `logo_file`) or `"none"`. The lid prints roof-down, so the engraving sits in the first layers. `first_layer_comp` widens it by 0.15 mm in the first layer so the squished layer doesn't close it.
- **RST/GND access** (`rst_access`):
  - `"side"` (default): a 4.5 × 5 mm window in the RAW-side wall, at the long pins of **GND (X 6.35) and RST (X 8.89)**. Bridge the two pins with tweezers to reset; double-tap to enter the bootloader.
  - `"bottom"`: a 1.6 mm slot through the floor under both pin tips, for a bent paper clip.
  - `"none"`: a closed case.
- **Board variant** (`variant`): `"both"` cuts slots for both 3-pin positions. Once you know which board you have, `"nicenano"` or `"supermini"` gives a tighter fit.
- **Output** (`part`):
  - `print`: both parts laid out in print orientation.
  - `base` and `lid`: each part on its own.
  - `assembly`: both parts in place, with a ghost of the board.
  - `test`: a 3 mm slice of the bed with the pin slots. Print it first (about 10 minutes) to check pin fit and the `hdr_plastic` seat.

### What to measure with calipers

Enter these in the `[Board: MEASURE these]` block:

1. **`pcb_t`**: thickness of the bare PCB, measured at an edge with no header.
2. **`hdr_plastic`**: height of the black header plastic. Check the 3-pin strip too; if it differs from the long strips, use the larger value.
3. **`hdr_long`**: long pin length from the underside of the plastic to the pin tip.
4. **`tail_above`**: height of the tallest solder joint or pin tail above the PCB top face.
5. **`usb_top`**: height of the USB-C shell top above the PCB underside. It is about 3.2 for a mid-mount receptacle; 4.0 was measured on the as-built board, which has a top-mount one.
6. **`pcb_l` / `pcb_w`**: board length and width (expect 32.9–33.0 × 17.8).
7. **`row_pins`**: count the header pins in one long row. Use 13 if the strip also goes through the B−/B+ holes at the USB end, otherwise 12.
8. **Which 3-pin layout**: if the 3-pin row lines up with the 10th pin from the USB end, set `variant = "nicenano"`. If it sits about 2 mm further out, almost in line with pin 11, set `variant = "supermini"`. Leaving it at `"both"` also works.
9. **`plug_w` / `plug_h`**: the moulded plastic body of your USB-C cable plug, plus about 0.4 mm.

As-built values: `pcb_t` 1.6, `hdr_plastic` 2.5, `hdr_long` 6.0, `tail_above` 2.0, `usb_top` 4.0, `pcb_l` 32.9, `row_pins` 13.

## Printing on a 0.4 mm nozzle

A 0.4 mm nozzle typically lays lines about 0.45 mm wide. At 0.2 mm layers, a wall of n perimeters is about 0.45 + 0.41·(n−1) mm thick. That gives 0.86 mm for 2 lines, 1.27 mm for 3 and 2.08 mm for 5. The case parameters are chosen around those steps:

| Feature | Value | Why |
|---|---|---|
| Outer wall | 2.2 mm | Must hold a tongue + gap + skirt; about 5 lines in total |
| Tongue / skirt | 1.0 mm each | About 2 lines + gap fill: stiff enough to hold, thin enough to flex for the snap |
| Fit gap | 0.2 mm per side | Standard sliding fit at 0.4 nozzle; use 0.25 if the lid binds, 0.15 if it rattles |
| Snap interference | 0.4 mm | One line width; smaller bumps print as blobs and barely catch |
| Pin slots | 1.2 mm | About 3 line widths; small slots and holes print 0.1–0.2 mm undersize, and 1.2 still clears the 0.9 mm post diagonal |
| Floor / roof | ≥ 1.2 mm | 6 layers at 0.2 mm, enough for solid top/bottom skins |
| Minimum feature | 0.8 mm | Anything thinner than 2 lines is dropped or printed as a single weak line |

Print settings and tips:

- **Layer height:** 0.2 mm is fine. 0.16 mm makes the 45° snap bumps and the bump windows cleaner.
- **Orientation:** print the base upright (floor on the bed) and the lid upside down (roof on the bed). The `print` layout already does this. No supports are needed: the USB notches are open-topped, and the snap windows (10 mm) and the side RST window (4.5 mm) are short bridges.
- **Slicer:** use a variable-width wall generator so the 1.0 mm tongue and skirt fill completely instead of leaving gaps. That is Arachne in PrusaSlicer, OrcaSlicer and Cura 5, or "detect thin walls" in older slicers.
- **Elephant foot:** this only affects the outer bottom edge and the lid's top face, not any fit. Enable the slicer's elephant-foot compensation; 0.1 mm on 1 layer worked on the as-built print.
- **First layer of the lid:** the engraving is printed against the build plate. Use a first-layer line width of about 0.42, not a wide one such as the 0.5 default in some profiles, and avoid heavy first-layer squish. Both fill engraved strokes. A smooth plate gives sharper, higher-contrast letters than textured PEI. Textured PEI still produced readable text.
- **Wall loops:** use 3–4 loops so the 2.2 mm base walls print solid rather than as 2 perimeters around sparse infill.
- **Material:** PETG is the better choice for snap-fits because it flexes without cracking. With PLA the snap works, but expect the bumps to wear after many openings; reduce `bump_int` to 0.3 if the lid is too hard to remove.
- **Calibration:** print `part = "test"` first. If the pins drag in the slots, raise `pin_slot` to 1.3. If the header plastic doesn't sit flat on the bed, re-measure `hdr_plastic`.

## Conclusion

In a fully headered case, the board's own outline barely matters. The parts that set the cavity are the header plastic, which sits flush with three of the four board edges, and the long pins, which add 8.5 mm below the PCB. Treating the header bodies as the mechanical datum is what makes one case work for both variants: support them on a shelf at Z = −2.5 and cut a single merged pocket for the two possible 3-pin positions. The 2 mm offset between the nice!nano and SuperMini extra pins then costs only about 2 mm of extra pocket length.

The remaining risk is concentrated in a few numbers no source publishes: PCB thickness, header plastic height, long-pin length, and which extra-pin layout your board actually uses. All of them can be read with calipers in about two minutes. Before the full print, print a 3 mm-tall test slice of the floor and shelf to check these values. A misjudged plastic height of ±0.5 mm moves every Z value above it, while the X/Y grid is fixed by the Pro Micro standard and will not move.

The as-built board showed why measuring matters. Two of its features, a top-mount USB-C and header pins through the B−/B+ holes, contradicted what the research found for the official boards. Neither was visible in the published footprints. Both were caught by calipers and a test print, and needed only a parameter change each.
