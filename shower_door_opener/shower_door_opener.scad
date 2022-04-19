$fn=200;

cut_width = 10;

disc_diameter=80;
disc_thickness=5;


rounding_radius=disc_thickness*0.75;

module cut() {
    cut_length=disc_diameter*0.5;
    translate([disc_diameter*0.35, 0, 0]) {
        rotate([0, 90, 20]) {
            cube([disc_thickness+2*rounding_radius, cut_width, cut_length], 
            center=true);
        }
    }
}

module hole() {
    translate([-disc_diameter*0.4, 0, 0]) {
        cylinder(h=disc_thickness*4, r=5, center=true);
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
        hole();
    }
}

opener();
