$fn=100;

actual_core_dia = 27.7;
core_dia = actual_core_dia * 1.02;
core_thickness = 6;

core_ext_dia = core_dia * 1.3;
body_thickness = core_thickness * 1.6;
cable_allowance = 6;
cable_thickness = 3;

slot_dia = cable_thickness + 1;
bar_dia = 6;
shaft_length_past_bar=11;

shaft_height = core_ext_dia/2+bar_dia+shaft_length_past_bar;
shaft_width = core_ext_dia/3;
rounding_radius = 1.5;
connector_width = 13;

module bar() {
    top_of_stone_down_to_bar_top = 35.3;

    translate([-shaft_width/2,
            top_of_stone_down_to_bar_top-core_ext_dia/2,
            body_thickness])
    translate([0, bar_dia/2+0.5, 0]) rotate([0, 90 ,0]) cylinder(shaft_width, d=bar_dia);
}

module power_cutout() {
    cylinder(body_thickness, d = connector_width+1);
    top_end_y = core_dia * 0.5 - slot_dia/2 + cable_allowance;
    hull() {
        cylinder(body_thickness, d = slot_dia);
        translate([0, top_end_y, 0]) cylinder(body_thickness, d = slot_dia);
    }
    hull() {
        translate([0, top_end_y, 0]) cylinder(body_thickness/2, d = slot_dia);
        translate([0, top_end_y+shaft_height-core_ext_dia/2, 0]) cylinder(body_thickness/2, d = slot_dia);
    }   
}

module head() {
    hull() {
        translate([12, -core_ext_dia*0.9, 0]) {
            cylinder(body_thickness, d = 4);
        }
        cylinder(body_thickness, d = core_ext_dia);
    }
}

module shaft() {
    translate([-shaft_width/2 + rounding_radius, rounding_radius, rounding_radius]) {
        minkowski() {
            cube([shaft_width - 2 * rounding_radius,
            shaft_height - 2 * rounding_radius,
            body_thickness - 2 * rounding_radius]);
            sphere(rounding_radius);
        }             
    }
}

module charger_cutout() {
    translate([0, 0, body_thickness - core_thickness]) cylinder(core_thickness, d = core_dia);
        power_cutout();
}

module body() {
    difference() {
        union() {
            shaft();
            head();
            bar();
        }
        charger_cutout();
    }
}

rotate([0, 0, 270]) body();
