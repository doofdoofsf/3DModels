include <../two_d_plus_cnc_corner_joint/corner_joint.scad>

$t = 1;
thickness = 19;
light_brown = "#C4A484";
dark_brown = "#964B00";

couch_arm_width = 140;
top_plate_width = couch_arm_width + 2 * thickness;
top_plate_length = top_plate_width;

side_plate_height = 100;
side_plate_length = top_plate_length;

joint = clean_ends;

module joint(thickness, width, height, pattern) {
    difference() {
        translate([-width+thickness, 0]) square([width, height]);
        joint_cutout(thickness, height, pattern);
    }
}

module side_plate() {
    linear_extrude(height = thickness) {
        joint(thickness, side_plate_height, side_plate_length, joint);
    }
}

module top_plate() {
    linear_extrude(height = thickness) {
        joint(thickness, top_plate_width, top_plate_length, joint);
    }
}


rotate([0, 0, (30*$t)-90]) {
    color(light_brown) side_plate();
    color(dark_brown) translate([(1-$t)*thickness*2 , side_plate_length]) rotate([180, 270]) side_plate();
}
