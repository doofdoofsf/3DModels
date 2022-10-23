$fn=100;

actual_core_dia = 27.7;
core_dia = actual_core_dia * 1.02;
core_thickness = 6;

core_ext_dia = core_dia * 1.3;
body_thickness = core_thickness * 1.6;
cable_allowance = 6;
cable_thickness = 3;

slot_dia = cable_thickness + 1;

shaft_height = 50;
shaft_width = core_ext_dia/3;

top_of_stone_down_to_bar_top = 35.3;
bar_height = 5-1.27;
bar_depth = 3;

connector_width = 13;

module rounded_box() {
    minkowski() {
        cube([10, 10, 10]);
        sphere(3);
    }
}

module power_cutout() {
    cylinder(body_thickness, d = connector_width+1);
    top_end_y = core_dia * 0.5 - slot_dia/2 + cable_allowance;
    hull() {
        cylinder(body_thickness, d = slot_dia);
        translate([0, top_end_y, 0]) cylinder(body_thickness, d = slot_dia);
    }
    #hull() {
        translate([0, top_end_y, 0]) cylinder(body_thickness/2, d = slot_dia);
        translate([0, top_end_y+shaft_height-core_ext_dia/2, 0]) cylinder(body_thickness/2, d = slot_dia);
    }   
}

module shaft() {
    cylinder(body_thickness, d = core_ext_dia);
    translate([-shaft_width/2, 0, 0]) cube([shaft_width, shaft_height, body_thickness]);
}

module charger_cutout() {
    translate([0, 0, body_thickness - core_thickness]) cylinder(core_thickness, d = core_dia);
        power_cutout();
}

module body() {
    difference() {
        shaft();
        charger_cutout();
    }
}

body();
//rounded_box();