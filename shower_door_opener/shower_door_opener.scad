$fn=100;

cut_width = 10;

disc_diameter=150;
disc_thickness=10;

rounding_radius=5;

module cut() {
    cut_length=disc_diameter*0.4;
    translate([disc_diameter*0.4, 0, 0]) {
        rotate([0, 90, 30]) {
            #cube([disc_thickness*3, cut_width, cut_length], 
            center=true);
        }
    }
}

module disc() {
    minkowski() {
        cylinder(h=disc_thickness, d = disc_diameter, center=true);
        sphere(rounding_radius);
    }
}

module opener() {
    difference() {
        disc();
        cut();
    }
}

opener();
