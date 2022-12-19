include <definitions.scad>

$fn=100;
shaft_length=80;

module shaft_slice() {
    difference() {
        circle(r = shaft_radius);
        translate([-shaft_radius+wire_radius, 0, 0]) square([wire_radius*2, wire_radius*2], center=true);
    }
}

module shaft() {
    linear_extrude(height = shaft_length, convexity = 10)
      shaft_slice();
}


module bend() {
    offset = 53;
    translate([-offset, 0, 0])
    rotate([90, 0, 0])
    rotate_extrude(angle = shaft_angle)
        translate([offset, 0, 0])
            shaft_slice();
}

module bottom_wire_cut() {
    translate([0, 0, wire_radius])
        cube([shaft_radius*2, wire_radius*2, wire_radius*2], center=true);
}

module stalk() {
    difference() {
        shaft();
        bottom_wire_cut();
    }
    translate([0, 0, shaft_length]) bend();
}

//stalk();
