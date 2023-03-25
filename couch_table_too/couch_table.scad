include <../two_d_plus_cnc_corner_joint/corner_joint.scad>

$t = 1;
thickness = 19;
light_brown = "#C4A484";
dark_brown = "#964B00";

couch_arm_width = 140;

top_plate_width = couch_arm_width + 2 * thickness;
top_plate_half_width = top_plate_width/2 + thickness/2;

top_plate_length = top_plate_width;

side_plate_height = 100;
side_plate_length = top_plate_length;

joint = fine;

show_table = true;
show_side_projection = false;
show_top_projection = false;

module joint(thickness, width, height, pattern) {
    difference() {
        translate([-width+thickness, 0]) square([width, height]);
        joint_cutout(thickness, height, pattern);
    }
}

module 2D_side() {
    joint(thickness, side_plate_height, side_plate_length, joint);
}

module side_plate() {
    linear_extrude(height = thickness) 2D_side();
}

module 2D_top() {
    joint(thickness, top_plate_half_width, top_plate_length, joint);
}

module top_plate_half() {
    linear_extrude(height = thickness) 2D_top();
}

module jointed_top_plate_half() {
    intersection() {
        top_plate_half();
        translate([-top_plate_half_width+2*thickness, top_plate_length, 0]) {
            rotate([0, 0, 180]) top_plate_half();
        }
    }
}

module half_table(top_color, side_color) {
    color(top_color) jointed_top_plate_half();
    color(side_color) translate([0, side_plate_length]) rotate([180, 270]) side_plate();
}

module full_table() {
    half_table(light_brown, dark_brown);
    translate([-top_plate_width+thickness*2, top_plate_length, 0]) rotate([0, 0, 180]) half_table(dark_brown, light_brown);
}

if (show_table) full_table();
if (show_side_projection) 2D_side();
if (show_top_projection) projection() jointed_top_plate_half();
    
