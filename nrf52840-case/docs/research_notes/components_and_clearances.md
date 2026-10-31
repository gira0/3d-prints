# Components and 3D clearances: nice!nano v2 and SuperMini / "Pro Micro nRF52840" clones

Coordinate convention used in the inferences below (it matches the BlueDrink9 KiCad footprint, which was converted from the vendor's official .PcbDoc): origin at the B- through-hole (top-left corner pin beside the USB-C). +X runs across the board toward B+ (pin rows at X=0 and X=15.24). +Y runs along the board away from the USB end. Units are mm.

Primary artefacts I downloaded and inspected myself:
- The SuperMini vendor wiki images (pinout front/back and product photo) — [ICBbuy wiki SuperMini nRF52840](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)
- The official vendor footprint `qs-nrf52840_v1.2-pcb_footprint.zip` (contains `ProMicro_NRF52840 V1.2-PCB FootPrint.PcbDoc`, Altium binary, not parsed) — [ICBbuy wiki](https://wiki.icbbuy.com/lib/exe/fetch.php?media=developmentboard:qs-nrf52840_v1.2-pcb_footprint.zip)
- The KiCad conversion `SuperMini NRF52840.kicad_mod`, which I parsed — [BlueDrink9/supermini-nrf52840-kicad](https://github.com/BlueDrink9/supermini-nrf52840-kicad)
- The official nice!nano v2 pinout image (front and back render) — [nicekeyboards pinout & schematic](https://nicekeyboards.com/docs/nice-nano/pinout-schematic)

## USB-C receptacle: size, position, overhang, mounting style, plug clearance

### Takeaway
Both boards use a **mid-mount (sink-through) USB-C receptacle centred across the board width**, between the B-/B+ holes. On the SuperMini footprint the receptacle shell outline is **9.0 mm wide x 6.5 mm deep**. It is centred at X=7.62, which is the board centreline, and it **overhangs the PCB edge by about 0.5–0.7 mm**. The nice!nano's **whole assembly is 3.2 mm thick**, and the connector sets that figure. For the cable, reserve an opening of at least **~12.4 x 6.5 mm** in front of the receptacle (that is the commonly cited USB-IF overmold envelope, but I could only partly verify it). Leave some margin on top of that, because many aftermarket cables exceed the envelope.

### Cited Findings
- nice!nano: "Mid mount USB-C port", "3.2 mm" thick, "thinner than a Pro Micro" — [nicekeyboards nice!nano docs](https://nicekeyboards.com/docs/nice-nano/)
- nice!nano: "board height is about 3.2 mm (0.55mm thinner than Pro Micro)", uses a mid-mount USB-C connector. This implies the classic Pro Micro is ~3.75 mm — [joric/nrfmicro wiki: Alternatives](https://github.com/joric/nrfmicro/wiki/Alternatives)
- SuperMini KiCad footprint (converted from the vendor .PcbDoc): the USB shell outline runs X 3.12→12.12 (9.0 mm wide) and Y −1.95→+4.55 (6.5 mm deep). It has a "USB topside" label at X≈7.75, and an F.Fab rectangle at X 3.08→12.19, Y −1.40→−2.09 that marks the portion beyond the board edge. The USB signal pads are at Y≈5.02. The shell has four oval through-hole tabs at X=2.04/13.2, Y=0.15/4.15 (11.16 mm apart across). — [BlueDrink9/supermini-nrf52840-kicad](https://github.com/BlueDrink9/supermini-nrf52840-kicad) (parsed .kicad_mod)
- SuperMini board-outline rectangles in the same footprint: Cmts.User (−1.14→16.64, −1.49→31.53) = 17.78 x 33.02 mm, and another (−1.40→16.64, −1.49→31.85) = 18.04 x 33.34 mm. The Edge.Cuts rectangles sit 0.11 mm inside and 0.14 mm outside these (17.82 x 33.13 and 18.32 x 33.63). — same source. **The exact outline is therefore uncertain to ±0.3 mm.**
- In the vendor's product photo, the bottom view shows the USB-C body through a notch in the PCB. That is consistent with a mid-mount/sink connector. The receptacle protrudes slightly past the board's top edge. — [ICBbuy wiki photo](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)
- Example mid-mount 16-pin receptacles: GCT USB4510-03-1-A is a 16-pin horizontal mid-mount part with a "1.6MM" designation, which appears to be the offset or board thickness — [Digi-Key listing](https://www.digikey.at/en/products/detail/gct/USB4510-03-1-A/15283202). A Molex 216990-series mid-mount part lists a 0.58 mm centre height and is meant for 0.80 mm PCBs — [Molex datasheet via radioelementy](https://www.radioelementy.ru/upload/iblock/f73/hlamnby3lpuxpcj2av1270k7jq1ud49f.pdf)
- Plug overmold: a Glenair drawing labelled "recommended USB 3.1 Type C plug design" gives **6.50 mm and 12.34 mm** — [Glenair 804-388](https://draft.glenair.com/superseal/series-801-804-805/usb-3-2/pdf/804-388.pdf). A Digi-Key forum user designing a recessed port was limited to a 12.5 mm overmold and says datasheets rarely state this dimension — [Digi-Key forum](https://forum.digikey.com/t/overmold-size-of-the-usb-c-male-end/70874)

### Inferences
- **USB-C keep-out for OpenSCAD:** a box 9.0 (X) x 6.5 (Y) x ~3.2 (Z), centred at X=7.62 (board centreline). Its front face is ~0.5–0.7 mm beyond the PCB edge, at Y≈−1.95 to −2.09 in footprint coordinates. In Z, the receptacle body is ~3.2 mm (typical Type-C shell is ~3.2–3.3 mm tall). Because it is mid-mount, it sits partly below the bottom face of the PCB: on a 1.6 mm PCB roughly 0.8 mm protrudes above and 0.8 mm below. **The nice!nano PCB thickness and the exact Z offset of the shell are not published.** Measure a real board, or model the connector Z-range as [PCB_bottom − 1.0, PCB_bottom + 3.2] to be safe.
- **Cable opening in the case wall:** at least 12.5 x 7.0 mm, centred on the receptacle axis. That allows for a 12.35 x 6.5 mm overmold plus ~0.15–0.25 mm per side for print tolerance. The case wall in front of the connector should be ≤ ~1.0–1.5 mm thick, or the opening should be stepped/recessed. The Type-C plug's metal "tongue" length is short (~6.5 mm), so a thick wall stops many cables from seating fully. That figure comes from general knowledge, not a source fetched here.
- The SuperMini and nice!nano v2 put the connector in the same place: both pinouts show the USB-C between the B- and B+ holes at the same end ([nicekeyboards pinout](https://nicekeyboards.com/docs/nice-nano/pinout-schematic); [ICBbuy wiki](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)). The same keep-out box is a reasonable starting point for both, but neither is verified to 0.1 mm.

### Gaps
- No official mechanical drawing gives the nice!nano v2 USB-C overhang, PCB thickness or connector part number. The nicekeyboards docs give only "3.2 mm" total thickness.
- The exact SuperMini receptacle part number and height datasheet are unknown. The 3.2 mm shell height and the Z split are inferred.
- I could not access the USB-IF Type-C spec. 12.35 x 6.5 mm is the commonly cited overmold recommendation, but the closest public source I found (Glenair) gives 12.34 x 6.50 without explicitly labelling it as the overmold.

## Total thickness / tallest components on top and bottom

### Takeaway
Both boards are **single-sided for components**. All active parts are on top: a bare nRF52840 QFN (**no shield can**), crystals, LDO, charger, LEDs and, on the SuperMini, a ceramic chip antenna. The bottom has **only pads**: the BOOST jumper, SWD pads and the extra-GPIO through-holes. The **USB-C receptacle is the tallest feature** and sets the 3.2 mm overall thickness on the nice!nano.

### Cited Findings
- nice!nano total thickness: 3.2 mm. A 301230 battery (3 mm thick) "fits underneath a socketed nice!nano" — [nicekeyboards docs](https://nicekeyboards.com/docs/nice-nano/)
- On the nice!nano v2 pinout back render, the back side shows only the B+/RAW/… labels, a "BOOST" solder jumper, SWC/SWD pads and the P1.01/P1.02/P1.07 holes. No components are visible — [nicekeyboards pinout image](https://nicekeyboards.com/static/1788ac663060fd510f4894b286cd97b1/a6d36/pinout-v2.png)
- In the SuperMini product photo and back render, the back has silkscreen, a BOOST jumper next to the VCC pin, four SWD pads (VDD/DIO/CLK/GND) and three extra through-holes (P1.07, P1.02, P1.01). The front shows the bare "N52840 QIAAD0" QFN, a 32 MHz crystal, a 32.768 kHz crystal, SOT-23 parts and a red/pink ceramic chip antenna — [ICBbuy wiki](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)
- SuperMini: "charger boost jumper (0R, 0402) on the back side". The charger is LTH7R/TP4054 (SOT-23-6) and the LDO is ME6217C33M5G (SOT-23-5) — [joric wiki](https://github.com/joric/nrfmicro/wiki/Alternatives). If someone bridges the jumper with a 0402 resistor, it adds ~0.35 mm on the back.
- In the SuperMini KiCad footprint, the back-side SMD pads are BOOST at (11.61, 9.37) and (11.61, 10.80), 0.8 x 0.65 mm, and four SWD pads at X=12.22, Y=22.89/24.39/25.89/27.39, 1 x 1 mm. The extra through-holes for pins 25–27 are at Y=27.39, X=3.08/5.62/8.16 — [BlueDrink9 footprint](https://github.com/BlueDrink9/supermini-nrf52840-kicad)

### Inferences
- **Top-side keep-out (excluding USB-C):** components such as the QFN (~0.85–0.9 mm), the 3225 crystal (~0.8 mm) and SOT-23 parts (~1.1–1.2 mm) are typically ≤ 1.2 mm above the PCB. Model a 1.5 mm-tall keep-out block over the whole top face, plus the USB-C box. Package heights are typical values for these packages, not measured on these boards.
- **Bottom-side keep-out:** flat apart from solder joints. Allow ~0.3–0.5 mm for solder fillets on through-hole pins, header pin stubs and any wires soldered to B+/B-. If the board is socketed, the sockets and header pins set the height under the board (e.g. the docs' 3 mm battery space), not the board itself.
- **Total height:** about 3.2 mm (nice!nano, official). The SuperMini is probably similar because it uses the same mid-mount concept, but **no official thickness figure exists for the SuperMini**. Treat it as 3.2–3.5 mm until measured.

### Gaps
- Official PCB thickness is unpublished for both (1.0 mm vs 1.6 mm unknown).
- No measured per-component heights from either vendor.

## Reset button

### Takeaway
**Neither the nice!nano v2 nor the standard SuperMini nRF52840 has an on-board reset button.** Reset (and bootloader entry by double-tap) is done by shorting the RST pin to GND. A case needs either an external button wired to RST/GND or a hole/slot to reach those pins with tweezers.

### Cited Findings
- nice!nano: bootloader entry "using a double-tap reset" — [nicekeyboards troubleshooting](https://nicekeyboards.com/docs/nice-nano/troubleshooting). Neither the pinout front nor the back render shows a button; RST is a header pin (4th pin on the right-hand side from the USB end, after B+, RAW and GND) — [nicekeyboards pinout](https://nicekeyboards.com/docs/nice-nano/pinout-schematic)
- SuperMini: "short RST to GND twice within 0.5 seconds" — [Tindie listing](https://www.tindie.com/products/adz1122/supermini-nrf52840-development-board-for-nicenano/). Neither the vendor photos nor the renders show a button; RST is the header pin next to GND on the right-hand side — [ICBbuy wiki](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)
- A community SuperMini dongle case adds an **external** TC-1109 4.5 x 4.5 x 5.5 mm tactile switch, which confirms that a button has to be added — [themaxbang/shuffle](https://github.com/themaxbang/shuffle)

### Inferences
- In footprint coordinates, RST is the right-hand row (X=15.24) pin at Y≈7.62 (B+ is at Y=0, then RAW, GND, RST). GND is directly above it at Y≈5.08, so a tweezer-access slot over those two pins is easy to place. Check against your board, because the pinout image order is B+, RAW, GND, RST, VCC.

### Gaps
- Some "Pro Micro nRF52840" listings from other sellers may add a reset button. I found no evidence of one for the mainstream SuperMini.

## LEDs (charge LED, user LED)

### Takeaway
On the SuperMini, the only LED shown on the vendor render is a **red LED near the RAW/GND pins on the B+ side, just below the USB-C**. Community reports say the colours are swapped relative to nice!nano: **red = user/BT LED (P0.15), blue = charge LED**. The nice!nano v2 has a **blue programmable LED (P0.15) and an orange charge LED**, but I couldn't determine their exact positions from text sources.

### Cited Findings
- nice!nano: "Programmable blue indicator LED" and "orange charging indicator LED" — [nicekeyboards docs](https://nicekeyboards.com/docs/nice-nano/)
- SuperMini: "LED colors are swapped: Red is Bluetooth (user LED), Blue is charger, should be vice-versa" (still an issue in 2026) — [joric wiki](https://github.com/joric/nrfmicro/wiki/Alternatives)
- The SuperMini pinout render shows a red SMD LED at roughly the RAW/GND row (2nd–3rd pin from the USB end), inboard of the right-hand pin column — [ICBbuy wiki image](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)

### Inferences
- For light pipes or a window on the SuperMini, place the opening at approximately X≈12–14, Y≈4–7 (footprint coordinates). This is estimated from the render, ±1.5 mm. A small top-side window spanning the area below the USB-C (X 3–14, Y 4–8) would probably show both LEDs on either board.

### Gaps
- No dimensioned LED positions are published for either board. The nice!nano v2 render is too small to place the LEDs reliably, so measure a physical board.

## Antenna location and keep-out

### Takeaway
On both boards the antenna is at the **end opposite the USB-C**. The SuperMini uses a **ceramic chip antenna** centred at the far edge. The nice!nano v2 uses a **PCB trace antenna** based on Nordic's reference QIAA layout. A plastic (PLA/PETG) case has negligible effect. Keep **metal (plates, screws, magnets, heat-set inserts, batteries) away from the antenna end**: >7 mm is a common chip-antenna rule and more is better.

### Cited Findings
- SuperMini "uses ceramic antenna", and the red revision keeps the same SMD antenna — [joric wiki](https://github.com/joric/nrfmicro/wiki/Alternatives). It appears as the red/pink rectangular part centred at the far (non-USB) edge, between the P1.06 and P0.09 pins, in the vendor photo and render — [ICBbuy wiki](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)
- nice!nano uses a PCB antenna based on the reference nRF52840 QIAA layout — [joric wiki](https://github.com/joric/nrfmicro/wiki/Alternatives)
- General guidance: keep >7 mm clearance in all directions around a chip antenna (Microchip). Keep metal chassis at least 2.54 cm (1 in) from a PCB antenna (Digi). No copper in the antenna keep-out on any layer — [Microchip module placement guidelines](https://onlinedocs.microchip.com/oxy/GUID-9DEF0110-B60A-445F-B120-FC5000EE0D2F-en-US-2/GUID-624CFF30-02D2-4443-95F9-5159CACA5DB3.html); [Digi PCB antenna design notes](https://docs.digi.com/resources/documentation/Digidocs/90002002/Reference/r_design_notes_pcb.htm)

### Inferences
- **Antenna zone for OpenSCAD:** the last ~4–5 mm of board length at the non-USB end (Y≈27–31.5 in footprint coordinates). Place no metal within ~7–10 mm of that zone, and do not put the board's antenna end against a metal switch plate.
- Thin PLA/PETG walls (1–3 mm) cause minimal detuning at 2.4 GHz. Carbon-fibre-filled or metal-filled filaments should be avoided near the antenna. This is a general RF rule, not sourced to these boards.
- The nice!nano v2 antenna position is inferred from the render: the end opposite the USB, under the "nice!nano v2.0" logo with a wave graphic. No official text confirms this.

### Gaps
- No vendor-specified keep-out distance exists for either board.

## Battery connection and power switch

### Takeaway
There is **no JST connector and no on/off switch** on either board. The battery goes to **B+ / B- through-holes at the USB end**, one on each side of the USB-C (in line with the two pin rows, one pitch above pin 1). The case must route battery wires there. A power switch, if wanted, goes in series with B+ externally.

### Cited Findings
- nice!nano: "+/- pads on the top of the board for hardwiring a battery". The pinout shows B- (GND) top-left and B+ (BATTERY+) top-right, flanking the USB-C — [nicekeyboards docs](https://nicekeyboards.com/docs/nice-nano/); [pinout](https://nicekeyboards.com/docs/nice-nano/pinout-schematic)
- SuperMini: "connect the + stage of the battery to B+ and the negative stage to B-". The render places B- and B+ beside the USB-C, labelled POWER−/POWER+ — [ICBbuy wiki](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)
- SuperMini footprint: through-holes "28"/"29" at (0, 0) and (15.24, 0), which are the B-/B+ positions. The first regular pin is at Y=2.54 — [BlueDrink9 footprint](https://github.com/BlueDrink9/supermini-nrf52840-kicad)

### Inferences
- Leave wire-exit space (~2 mm) above both B-/B+ holes at the USB end, on both sides of the USB-C opening.

### Gaps
- None significant.

## Published STEP/3D models and stated dimensions

### Takeaway
I found **no official STEP model** for either board. A **community "SuperMini / Pro Micro nRF52840 reference model" exists on Printables (model 990134)**, but I couldn't open it (HTTP 403). The vendor provides an Altium footprint for the SuperMini, and a KiCad conversion exists. Community cases (e.g. themaxbang/shuffle STEP files) are another source of reference geometry.

### Cited Findings
- Vendor footprint `qs-nrf52840_v1.2-pcb_footprint.zip` (Altium PcbDoc). The page has no 3D model, and a commenter asked for one. The comments link a 3D reference model on Printables (`printables.com/model/990134-supermini-pro-micro-nrf52840-reference-model`) — [ICBbuy wiki](https://wiki.icbbuy.com/doku.php?id=developmentboard:nrf52840)
- KiCad footprint converted from the official .pcbdoc. It notes that the three extra pins and debug pads differ in location from the nice!nano — [BlueDrink9/supermini-nrf52840-kicad](https://github.com/BlueDrink9/supermini-nrf52840-kicad)
- A SuperMini dongle case with STEP/F3D files (bottom, cover, holder) — [themaxbang/shuffle](https://github.com/themaxbang/shuffle)
- A box model `lib/3d/nice_nano_box.step` exists in the EyalYe/unicorne repo (a simple placeholder box, found via GitHub code search; not inspected) — [EyalYe/unicorne](https://github.com/EyalYe/unicorne)
- Nicekeyboards publishes no length/width; the page states only the 3.2 mm thickness — [nicekeyboards docs](https://nicekeyboards.com/docs/nice-nano/)
- Don't confuse these with the "Super Mini nRF52840 XS" (23.5 x 18.0 mm) or the ESP32-C3 Super Mini (22.5 x 18 mm), which are different boards — [jnsbyr/zephyr-boards](https://github.com/jnsbyr/zephyr-boards)

### Inferences
- **Board outline to model:** about 18.0 x 33.0–33.3 mm (the Pro Micro 0.7" x 1.3" form factor). Pin rows are 15.24 mm apart and centred across the width. The first pin hole (B-/B+) is ~1.4–1.5 mm from the USB-end edge, and the last pin is ~1.0–1.4 mm from the far edge. Taken from the SuperMini footprint outlines; ±0.3 mm. Give the board pocket ≥0.3 mm clearance per side.

### Gaps
- The Printables reference model's stated dimensions couldn't be retrieved (403).
- No verified nice!nano v2 length/width from an official source.
- The PcbDoc wasn't parsed, so its exact outline is unconfirmed.
