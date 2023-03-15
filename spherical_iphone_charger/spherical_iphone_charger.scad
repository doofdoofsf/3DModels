$fn = 200;


charger_thickness = 5.4;
charger_diameter = 55.9;
show_charger = false;
full_display_charger = false;
show_top = true;
show_bottom = false;
show_base = false;

body_size = charger_diameter * 1.36;


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
    cylinder(h = charger_thickness * 5, d = charger_diameter*1.1);
}
    

module spherical_body() {
    sphere(d = body_size);
}


module charger_with_cut_out() {
    head_y_offset = body_size * 0.25;
    difference() {
        spherical_body();
        translate([0, 0, head_y_offset]) {
            charger_cut_out();
            charger_head();
            cylinder(h = charger_thickness, d = body_size);
        }
    }
    if (show_charger) color("white") translate([0, 0, head_y_offset]) charger_head();    
}

module base() {
    height = body_size/5;
    echo(height);
    translate([0, 0, (-body_size/2-height/2)*0.9])
        cylinder(d = body_size, h=height);
}

module show_base() {
    difference() {
        base();
        charger_with_cut_out();
    }
}

module charger_half(half) {
    cutout_size = charger_diameter * 1.5;
    y_offset = half == "top" ? -cutout_size/2 : cutout_size/2;
    
    difference() {
        charger_with_cut_out();
        translate([0, 0, y_offset]) cube(cutout_size, center=true);
    }
}

module full_display_charger() {
    rotate([0, 0, $t * 360]) {
        base();
        rotate([0, 50, 0]) charger_with_cut_out();
    }
}

if (show_bottom) {
    charger_half("bottom");
    translate([charger_diameter * 1.45, 0, 0]) charger_half("bottom");
}

if (show_top) {
    charger_half("top");
    translate([charger_diameter * 1.45, 0, 0]) charger_half("top");
}

if (show_base) show_base();
    

if (full_display_charger) full_display_charger(); 


