$fn = 80;

charger_thickness = 5.4;
charger_diameter = 55.9;

module charger() {
    cylinder(h = charger_thickness, d = charger_diameter, center = true);
}

module charger_nub() {
    diameter = 3.89;
    length = 10;
    
    translate([charger_diameter/2, 0, 0]) rotate([0, 90, 0]) cylinder(10, d = diameter);
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
    head_y_offset = charger_diameter * 0.32;
    difference() {
        spherical_body();
        translate([0, 0, head_y_offset]) {
            charger_cut_out();
            charger_head();
        }
    }
    color("black") translate([0, 0, head_y_offset]) charger_head();    
}

rotate([0, 50, 0]) charger_with_cut_out();


