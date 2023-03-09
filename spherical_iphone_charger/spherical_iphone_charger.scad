$fn = 200;

charger_thickness = 5.4;
charger_diameter = 55.9;
show_charger = false;
rotated_charger = false;
show_top = true;
show_bottom = false;

module charger() {
    cylinder(h = charger_thickness, d = charger_diameter, center = true);
}

module charger_nub() {
    diameter = 3.8;
    length = 10;
    
    translate([charger_diameter/2-1, 0, 0]) rotate([0, 90, 0]) cylinder(10, d = diameter);
}

module charger_head() {
    charger();
    charger_nub();
}

module charger_cut_out() {
    cylinder(h = charger_thickness * 5, d = charger_diameter);
}
    

module spherical_body() {
    sphere(d = charger_diameter * 1.2);
}


module charger_with_cut_out() {
    head_y_offset = charger_diameter * 0.28;
    difference() {
        spherical_body();
        translate([0, 0, head_y_offset]) {
            charger_cut_out();
            charger_head();
            cylinder(h = charger_thickness, d = charger_diameter * 1.2);
        }
    }
    if (show_charger) color("white") translate([0, 0, head_y_offset]) charger_head();    
}

module charger_half(half) {
    cutout_size = charger_diameter * 1.5;
    y_offset = half == "top" ? -cutout_size/2 : cutout_size/2;
    
    difference() {
        charger_with_cut_out();
        translate([0, 0, y_offset]) cube(cutout_size, center=true);
    }
}

if (show_bottom) charger_half("bottom");
if (show_top) charger_half("top");

if (rotated_charger) rotate([0, 50, 0]) charger_with_cut_out();


