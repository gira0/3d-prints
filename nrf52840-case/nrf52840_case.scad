// Two-part snap-fit case for a Pro Micro nRF52840 (nice!nano v2 / SuperMini clone)
// with ALL headers soldered: 2 x 12-pin rows + the 3 extra pins (P1.01/P1.02/P1.07),
// header plastic under the PCB, long pins pointing down (breadboard orientation).
//
// Frame (same as reports/Pro Micro nRF52840 case dimensions.md):
//   origin = PCB bottom face, board corner at the USB end on the B-/P0.06 edge,
//   +X along the board away from USB, +Y toward the B+/RAW row, +Z component side.
//
// Base: floor + "bed" the header plastic rests on, with slots for the long pins.
// Lid:  roof + skirt that slides over the base's tongue and snaps onto two bumps.
// Print the base upright and the lid upside down (part = "print" lays them out).

/* [Output] */
part       = "print";   // [print, base, lid, assembly, test]
rst_access = "side";    // [none, side, bottom] window to bridge RST+GND with tweezers
variant    = "both";    // [both, nicenano, supermini] position of the 3 extra pins

/* [Board: MEASURE these] */
pcb_l       = 32.9;     // board length (measured)
row_pins    = 13;       // pins per long row: 13 = header also through the B-/B+ holes, 12 = not
pcb_w       = 17.78;    // board width
pcb_t       = 1.6;      // bare PCB thickness
hdr_plastic = 2.5;      // header plastic height (spacer under the PCB)
hdr_long    = 6.0;      // long pin length below the plastic
tail_above  = 2.0;      // highest soldered tail/joint above the PCB top face
usb_top     = 4.0;      // USB-C shell top above the PCB underside (mid-mount ~3.2)

/* [Printer: 0.4 mm nozzle] */
wall     = 2.2;         // outer wall = tongue + fit_gap + skirt (~5 lines)
tongue_t = 1.0;         // base tongue (~2 lines + gap fill)
fit_gap  = 0.2;         // tongue-to-skirt clearance per side
floor_t  = 1.2;         // 6 layers at 0.2 mm
roof_min = 1.2;
lip_h    = 4.0;         // tongue height / skirt overlap
bump_int = 0.4;         // snap interference (~1 line width)
bump_h   = 2.0;
bump_l   = 10;
snap_preload = 0.15;    // window edge rides on the bump's lower 45 deg face -> pulls lid down

/* [Clearances] */
clr_hdr   = 0.35;       // around header plastic (also sets PCB pocket)
clr_usb   = 0.3;
clr_pin_z = 0.5;        // below the long pin tips
clr_top   = 0.3;        // above USB shell / tails
pin_slot  = 1.2;        // slot width for 0.64 mm square posts (0.9 mm diagonal)

/* [Engraving on lid top] */
label      = ["Open", "Puck"];   // one entry per line
label_font = "Liberation Sans:style=Bold";
label_size = 6.8;       // font size; caps ~0.72x this, strokes ~1 mm
label_spacing = 1.05;   // letter spacing; wider gaps survive first-layer squish
line_pitch = 1.25;      // baseline-to-baseline, x label_size
logo       = "simple";  // [simple, svg, none] simple = bold primitive-drawn mark, svg = logo_file
logo_file  = "assets/steam.svg";   // used when logo = "svg" (Font Awesome icon, CC BY 4.0)
logo_d     = 11;
engrave_d  = 0.6;       // depth, 3 layers at 0.2 mm
first_layer_comp = 0.15;  // engraving is printed on the bed: widen it in the first layer
first_layer_h    = 0.2;

/* [USB-C] */
plug_w    = 11.0;       // cable overmold opening: MEASURE your plug + ~0.4
plug_h    = 6.0;
plug_r    = 2.0;        // opening corner radius (overmolds are rounded)

/* [Hidden] */
$fn = 48;
eps = 0.01;

// --- Pin grid (Pro Micro standard, identical on both boards) ---
pitch    = 2.54;
row_y    = [1.27, 16.51];                         // P0.06 row, RAW row
pin_x    = [for (k = [13 - row_pins:12]) 1.27 + k * pitch];   // 1.27 or 3.81 ... 31.75
gnd_x    = 6.35;                                  // GND next to RST, RAW row
rst_x    = 8.89;
extra_nn = [26.67, 3.81];                         // P1.01; P1.02/P1.07 follow at +pitch in Y
extra_sm = [28.655, 4.35];
extras   = variant == "nicenano"  ? [extra_nn]
         : variant == "supermini" ? [extra_sm]
         : [extra_nn, extra_sm];

// --- USB-C ---
usb_x0  = -0.8;         // shell front face (protrudes past the PCB edge)
usb_h   = 3.18;
usb_cy  = pcb_w / 2;
usb_cz  = usb_top - usb_h / 2;   // receptacle axis, from the measured shell top

// --- Derived heights ---
tail_top = pcb_t + tail_above;
ceiling  = max(usb_top, tail_top) + clr_top;
split_z  = ceiling - fit_gap - lip_h;
bed_z    = -hdr_plastic;
floor_z  = -(hdr_plastic + hdr_long) - clr_pin_z;
base_bot = floor_z - floor_t;
lid_top  = max(ceiling, usb_cz + plug_h / 2) + roof_min;

// --- Inner cavity outline ---
in_x0 = usb_x0 - clr_usb;
in_x1 = pcb_l + clr_hdr;
in_y0 = -clr_hdr;
in_y1 = pcb_w + clr_hdr;
mid_x = (in_x0 + in_x1) / 2;

bump_p  = fit_gap + bump_int;
bump_zc = split_z + lip_h / 2 + 0.3;

module outline(d = 0)
    offset(r = d) translate([in_x0, in_y0]) square([in_x1 - in_x0, in_y1 - in_y0]);

module slab(d, z0, z1)
    translate([0, 0, z0]) linear_extrude(z1 - z0) outline(d);

module pin_slots() {
    for (y = row_y)
        translate([pin_x[0] - pin_slot / 2, y - pin_slot / 2, floor_z])
            cube([pin_x[len(pin_x) - 1] - pin_x[0] + pin_slot, pin_slot, bed_z - floor_z + eps]);
    for (e = extras)
        translate([e[0] - pin_slot / 2, e[1] - pin_slot / 2, floor_z])
            cube([pin_slot, 2 * pitch + pin_slot, bed_z - floor_z + eps]);
}

// Rounded-rectangle opening through the -X wall, centred on the receptacle axis
module usb_cut()
    translate([in_x0 - wall - 1, usb_cy, usb_cz]) rotate([90, 0, 90])
        linear_extrude(wall + 1 + eps)
            offset(r = plug_r) square([plug_w - 2 * plug_r, plug_h - 2 * plug_r], center = true);

module rst_cut() {
    if (rst_access == "side")       // window in the +Y wall onto the RST and GND pins
        translate([gnd_x - 1, row_y[1], floor_z + clr_pin_z])
            cube([rst_x - gnd_x + 2, in_y1 + wall + 1 - row_y[1], bed_z - 1 - floor_z - clr_pin_z]);
    else if (rst_access == "bottom") // slot through the floor under both pin tips
        translate([gnd_x - pin_slot / 2 - 0.2, row_y[1] - 0.8, base_bot - 1])
            cube([rst_x - gnd_x + pin_slot + 0.4, 1.6, floor_t + 1 + eps]);
}

// Snap bump on the tongue's long faces: 45 deg lead-in and release
module bump(side) {
    yf = side < 0 ? in_y0 - tongue_t : in_y1 + tongue_t;
    translate([mid_x - bump_l / 2, yf, bump_zc])
        rotate([90, 0, 90]) linear_extrude(bump_l)
            polygon([[-side * eps, -bump_h / 2], [side * bump_p, -bump_h / 2 + bump_p],
                     [side * bump_p, bump_h / 2 - bump_p], [-side * eps, bump_h / 2]]);
}

module snap_windows() {
    for (side = [-1, 1]) {
        y0 = side < 0 ? in_y0 - wall - 1 : in_y1 + tongue_t + fit_gap - eps;
        // lower edge sits where the bump's chamfer meets the skirt face, raised by the preload
        z0 = bump_zc - bump_h / 2 + fit_gap + snap_preload;
        translate([mid_x - bump_l / 2 - 0.3, y0, z0])
            cube([bump_l + 0.6, wall + 1 - tongue_t - fit_gap + eps, bump_zc + bump_h / 2 + 0.2 - z0]);
    }
}

module base()
    difference() {
        union() {
            slab(wall, base_bot, split_z);
            slab(tongue_t, split_z - eps, split_z + lip_h);
            bump(-1);
            bump(1);
        }
        slab(0, bed_z, split_z + lip_h + 1);
        pin_slots();
        usb_cut();
        rst_cut();
    }

module lid() {
    difference() {
        slab(wall, split_z, lid_top);
        slab(tongue_t + fit_gap, split_z - eps, split_z + lip_h + fit_gap);
        slab(0, split_z - eps, ceiling);
        usb_cut();
        snap_windows();
        // pry notch at the antenna end
        translate([in_x1 + tongue_t + fit_gap - eps, usb_cy - 2.5, split_z - eps])
            cube([wall, 5, 0.8]);
        engraving();
    }
    // pad that keeps the USB shell from lifting when a cable is pulled
    if (ceiling - usb_top > 0.15)
        translate([0.5, usb_cy - 3, usb_top + 0.05])
            cube([4.5, 6, ceiling - usb_top - 0.05 + eps]);
}

// Simplified mark, drawn at diameter d around the origin. The engraved area is
// the disc; the ring, wheel, arm and rod stay at surface level. Every island and
// gap is >= 1 mm so it survives a 0.4 mm nozzle.
module simple_mark(d) {
    s   = d / 11;                    // designed at d = 11
    big = [1.4, 1.3] * s;
    sml = [-1.7, -1.6] * s;
    difference() {
        circle(d = d);
        translate(big) difference() { circle(r = 2.4 * s); circle(r = 1.0 * s); }
        translate(sml) circle(r = 1.5 * s);
        hull() { translate(sml) circle(r = 0.75 * s); translate(big) circle(r = 0.75 * s); }
        hull() { translate(sml) circle(r = 0.9 * s); translate([-d, -0.9 * s]) circle(r = 0.9 * s); }
    }
}

// Logo left (USB end), text to its right; centred on the lid top
module engraving_2d() {
    has_logo = logo != "none";
    gap      = has_logo ? 1.0 : 0;
    logo_w   = has_logo ? logo_d : 0;
    text_w   = (in_x1 - in_x0) + 2 * wall - 3 - logo_w - gap;
    x0       = mid_x - (logo_w + gap + text_w) / 2;
    n        = len(label);
    lp       = line_pitch * label_size;
    // baselines chosen so the cap-height block is centred on the lid
    b_last   = usb_cy - ((n - 1) * lp + 0.72 * label_size) / 2;
    if (logo == "simple")
        translate([x0 + logo_d / 2, usb_cy]) simple_mark(logo_d);
    else if (logo == "svg")
        translate([x0 + logo_d / 2, usb_cy])
            resize([logo_d, 0], auto = true) import(logo_file, center = true);
    for (i = [0:n - 1])
        translate([x0 + logo_w + gap + text_w / 2, b_last + (n - 1 - i) * lp])
            text(label[i], size = label_size, font = label_font, spacing = label_spacing,
                 halign = "center", valign = "baseline");
}

// The lid prints upside down, so the top face is the first layer: widen the
// engraving there to make up for the squished first layer closing it up.
module engraving() {
    translate([0, 0, lid_top - engrave_d]) linear_extrude(engrave_d + eps) engraving_2d();
    translate([0, 0, lid_top - first_layer_h])
        linear_extrude(first_layer_h + eps) offset(delta = first_layer_comp) engraving_2d();
}

module board_ghost()
    color("seagreen", 0.6) {
        cube([pcb_l, pcb_w, pcb_t]);
        for (y = row_y) translate([pitch, y - pitch / 2, bed_z]) cube([30.48, pitch, hdr_plastic]);
    }

if (part == "base") base();
else if (part == "lid") lid();
else if (part == "assembly") {
    color("lightgray") base();
    color("steelblue", 0.5) lid();
    board_ghost();
}
else if (part == "test")   // bed + pin slots only, to check pin fit before the full print
    translate([0, 0, -(bed_z - 3)]) intersection() {
        base();
        translate([in_x0 - wall - 1, in_y0 - wall - 1, bed_z - 3])
            cube([in_x1 - in_x0 + 2 * wall + 2, in_y1 - in_y0 + 2 * wall + 2, 3 + 1]);
    }
else {  // print layout: base upright, lid upside down next to it
    translate([0, 0, -base_bot]) base();
    translate([0, 2 * (in_y0 - wall) - 5, lid_top]) rotate([180, 0, 0]) lid();
}

echo(str("outer size: ", in_x1 - in_x0 + 2 * wall, " x ", in_y1 - in_y0 + 2 * wall,
         " x ", lid_top - base_bot, " mm; split at Z ", split_z));
