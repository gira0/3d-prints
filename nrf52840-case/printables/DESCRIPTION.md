# Printables listing – copy & paste

Everything below is meant to be copied into the matching fields on printables.com.
Fields in [square brackets] still need your input.

---

## Name

OpenPuck – Snap-fit case for Pro Micro nRF52840 / nice!nano with soldered headers (parametric)

## Summary (short text under the title)

Snap-fit case for a Pro Micro nRF52840 (nice!nano v2 clone) with all headers soldered. Parametric OpenSCAD.

(Printables cuts the summary at 120 characters; this one is 107.)

## Description

A two-part, screwless snap-fit case for a **Pro Micro nRF52840** development board (nice!nano v2 compatible, SuperMini-style clones) **with all header pins soldered on**: both long rows and the 3 extra pins (P1.01 / P1.02 / P1.07) at the end of the board.

Most cases for these boards assume a bare board. This one is built around the soldered headers. The header plastic rests on a raised floor, the long pins drop into slots, and the USB-C port stays reachable.

[One or two sentences on what OpenPuck is / what you use the board for.]

**Tested with:** a "Pro Micro NRF52840 Development Board compatible with nice!nano V2.0". It has 13 pins per long row, because the header also goes through the B−/B+ holes, and a USB-C socket that sits on top of the PCB. The board drops in, the cable plugs in fully, and the lid clicks on tight without rattling.

### Features

- **Two parts that click together:** the lid's skirt slides over a rim on the base and catches on a bump on each side. The catch is preloaded, so the lid is pulled down tight and doesn't rattle. To open it, pry at the notch at the end opposite the USB port.
- **Fits all soldered pins:** the slots end right after the first and last pin, so the board can't slide when you plug in or pull out a cable.
- **Fits both 3-pin layouts:** nice!nano v2 and SuperMini clones place the 3 extra pins about 2 mm apart. The default base has slots for both.
- **Reset access:** these boards have no reset button. You reset by bridging RST and GND, and double-tap for the bootloader. Choose one of three bases:
  - `base.stl`: a side window, so you can bridge the two pins with tweezers
  - `base_rst_bottom.stl`: a slot in the floor, for a bent paper clip
  - `base_rst_none.stl`: fully closed
- **Engraved lid:** "Open / Puck" plus a simple logo, sized so it stays readable with a 0.4 mm nozzle. The text, the logo and its size are all settings.

Outside size: **38.75 × 22.88 × 16.8 mm**.

### Measure your board first

Clone boards differ more than you'd expect. Mine had two surprises: the header also goes through the battery holes, and the USB-C sits on top of the PCB instead of in it. The STLs fit my board. If yours differs, check these with calipers and enter them at the top of the `.scad` file:

- PCB thickness (1.6)
- header plastic height (2.5)
- long pin length (6.0)
- tallest solder joint above the board (2.0)
- USB-C top above the PCB underside (4.0)
- board length (32.9)
- pins per row (13)

Print `test.stl` first. It's a 3 mm slice of the base with all the pin slots and takes about 10 minutes, so you can check the fit without printing the whole base.

### Printing

- **Orientation:** base upright, lid upside down (roof on the plate). The STLs are already oriented. No supports needed.
- **Walls:** Arachne (variable-width) walls, 3–4 wall loops.
- **Lid first layer:** the engraving is printed on the plate. Use elephant-foot compensation of about 0.1 mm and a first-layer line width of about 0.42. Wide first-layer lines fill the letters. A smooth plate gives crisper letters than textured PEI.
- 0.4 mm nozzle, 0.2 mm layers, 15 % infill.
- **Material:** PLA+ works well (that's what the tested case is made of). PETG flexes a bit more if you open the case often.

### Customising (OpenSCAD)

`nrf52840_case.scad` is fully parametric. Open it in OpenSCAD and use **Window → Customizer**. Useful settings:

- `rst_access`: `side` / `bottom` / `none`
- `variant`: `both` / `nicenano` / `supermini`
- `row_pins`: 12 or 13 pins per long row
- `plug_w` / `plug_h`: the USB opening. Set it to your cable's plug body + 0.4 mm.
- `snap_preload`: lower it if the lid is too hard to close, raise it if the lid rattles.
- `pin_slot`: raise it to 1.3 if the pins drag.
- `label` / `logo`: the engraving. Use `logo = "none"` for text only, or `"svg"` for your own one-colour SVG.

The GitHub repo includes a research report with all board dimensions, pin coordinates and sources.

### Transparency

I designed this with help from Claude (Anthropic's AI assistant) in Claude Code. I took the measurements with calipers and checked every step against test prints. Claude researched the board dimensions and wrote and refined the OpenSCAD model from them.

Source & full documentation: https://github.com/gira0/3d-prints/tree/main/nrf52840-case

## Files to upload

- `stl/base.stl`: base with the RST/GND side window (default)
- `stl/base_rst_bottom.stl`: base with the floor slot
- `stl/base_rst_none.stl`: closed base
- `stl/lid.stl`: engraved lid
- `stl/test.stl`: pin-fit test slice
- `nrf52840_case.scad`: parametric source

## Images

- **Your own photos first** (Printables shows the first image as the cover). Use the **metadata-free copies** from `../images/` (`photo-1.jpg` … `photo-4.jpg`), not the originals from your phone, which contain GPS data.
  - Suggested order: `photo-3.jpg` (engraved lid) as the cover, then `photo-1.jpg` (board in the base), `photo-4.jpg` (base interior) and `photo-2.jpg` (board next to the parts).
- Then the renders from this folder:
  - `01-assembly.png`
  - `02-lid-top.png`
  - `03-base-inside.png`
  - `04-usb-end.png`
  - `05-print-layout.png`

## Print settings (the form fields)

- Printer: Anycubic Kobra S1
- Rafts: No
- Supports: No
- Resolution: 0.2 mm
- Infill: 15 %
- Filament: Anycubic PLA+ (PETG also fine)

## Category

Hobby & Makers → Electronics  *(or: Gadgets → Computers, whichever fits better)*

## Tags

nrf52840, pro micro, nice!nano, nicenano, supermini, case, enclosure, snap fit, zmk, bluetooth, microcontroller, development board, headers, openscad, parametric

## License

Creative Commons – Attribution – ShareAlike (CC BY-SA 4.0)
(Printables: "Creative Commons — Attribution — Share Alike"; leave "exclude commercial use" off)
