include <corner_joint.scad>

test_plate_height = 145;
test_plate_width = 100;
thickness = 19.05;

module joint(thickness, width, height, pattern) {
    difference() {
        translate([-width+thickness, 0]) square([width, height]);
        joint_cutout(thickness, height, pattern);
    }
}

module test_plate() {
    joint(thickness, test_plate_width, test_plate_height, fine);
}

test_plate();
translate([thickness*2 , test_plate_height]) rotate([180, 180]) test_plate();
