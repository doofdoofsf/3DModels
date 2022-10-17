$fn=100;

actual_core_dia = 27.7;
core_dia = actual_core_dia * 1.02;
core_thickness = 6;

core_ext_dia = core_dia * 1.3;
body_thickness = core_thickness * 1.6;

module power_cutout() {
    cylinder(body_thickness, d = core_dia * 0.4);
    hull() {
        cylinder(body_thickness, d = core_dia * 0.1);
        translate([0, core_dia * 0.6, 0]) cylinder(body_thickness, d = core_dia * 0.1);
    }
}

module gravestone() {
    cylinder(body_thickness, d = core_ext_dia);
    translate([-core_ext_dia/2, 0, 0]) cube([core_ext_dia, core_ext_dia, body_thickness]);
}

module body() {
    difference() {
        gravestone();
        translate([0, 0, body_thickness - core_thickness]) cylinder(core_thickness, d = core_dia);
        #power_cutout();
    }
}

body();