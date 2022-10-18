$fn=100;

actual_core_dia = 27.7;
core_dia = actual_core_dia * 1.02;
core_thickness = 6;

stand_height = 80;
stand_width = 50;
stand_depth = 25;

core_ext_dia = core_dia * 1.3;
body_thickness = stand_depth;
cable_allowance = 6;
cable_thickness = 3;

connector_width = 13;



module stand() {
    cube([stand_width, stand_height, stand_depth]);
}

module power_cutout() {
    slot_dia = cable_thickness + 0.5;
    cylinder(body_thickness, d = connector_width+1);
    hull() {
        cylinder(body_thickness, d = slot_dia);
        translate([0, core_dia * 0.5 - slot_dia/2 + cable_allowance, 0]) cylinder(body_thickness, d = slot_dia);
    }
}

module charger_cutout() {
    translate([0, 0, body_thickness - core_thickness]) {
        cylinder(core_thickness, d = core_dia);
    }
    power_cutout();
}

module body() {
    difference() {
        stand();
        translate([stand_width/2, stand_height*0.30, 0]) charger_cutout();
    }
}

body();
