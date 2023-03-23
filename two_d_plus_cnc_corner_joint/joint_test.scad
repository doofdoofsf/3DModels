include <corner_joint.scad>

$t = 1;

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
    linear_extrude(height = thickness) {
        joint(thickness, test_plate_width, test_plate_height, fine);
    }
}


rotate([0, 0, (30*$t)-90]) {
    color("#C4A484") test_plate();
    color("#964B00") translate([(1-$t)*thickness*2 , test_plate_height]) rotate([180, 270]) test_plate();
}
