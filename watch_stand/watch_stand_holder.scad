$fn=50;

actual_core_dia = 27.7;
core_dia = actual_core_dia * 1.02;
core_thickness = 6;

core_ext_dia = core_dia * 1.3;
body_thickness = core_thickness * 1.6;

module power_cutout() {
    slot_dia = core_dia * 0.1;
    cylinder(body_thickness, d = core_dia * 0.4);
    hull() {
        cylinder(body_thickness, d = slot_dia);
        translate([0, core_dia * 0.5 - slot_dia/2, 0]) cylinder(body_thickness, d = slot_dia);
    }
}

module gravestone() {
    cylinder(body_thickness, d = core_ext_dia);
    translate([-core_ext_dia/2, 0, 0]) cube([core_ext_dia, core_ext_dia, body_thickness]);
}

module charger_cutout() {
    translate([0, 0, body_thickness - core_thickness]) cylinder(core_thickness, d = core_dia);
        power_cutout();
}

module body() {
    difference() {
        gravestone();
        charger_cutout();
    }
}

body();