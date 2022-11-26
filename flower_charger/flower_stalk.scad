include <definitions.scad>

$fn=100;
big_shaft_length=50;
base_shaft_length = 20;
shaft_angle = 70;

module big_shaft() {
    translate([0, 0, base_shaft_length]) cylinder(h=big_shaft_length-base_shaft_length, r1=shaft_start_radius, r2=shaft_end_radius);
}

module base_shaft() {
    cylinder(h=base_shaft_length, r=shaft_start_radius);
}


module bend() {
    offset = 53;
    translate([-offset, 0, 0])
    rotate([90, 0, 0])
    rotate_extrude(angle = shaft_angle)
        translate([offset, 0, 0])
            circle(r = shaft_end_radius);
}

base_shaft();
big_shaft();
translate([0, 0, big_shaft_length]) bend();
