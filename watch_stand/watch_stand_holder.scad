$fn=50;

actual_core_dia = 27.7;
core_dia = actual_core_dia * 1.02;
core_thickness = 6;

core_ext_dia = core_dia * 1.3;
body_thickness = core_thickness * 1.6;
cable_allowance = 6;
cable_thickness = 3;

connector_width = 13;

module rounded_box() {
    minkowski() {
        cube([10, 10, 10]);
        sphere(3);
    }
}

module power_cutout() {
    slot_dia = cable_thickness;
    #cylinder(body_thickness, d = connector_width);
    hull() {
        cylinder(body_thickness, d = slot_dia);
        translate([0, core_dia * 0.5 - slot_dia/2 + cable_allowance, 0]) cylinder(body_thickness, d = slot_dia);
    }
}

module gravestone() {
    cylinder(body_thickness, d = core_ext_dia);
    translate([-core_ext_dia/2, 0, 0]) cube([core_ext_dia, core_ext_dia*0.75, body_thickness]);
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
//rounded_box();