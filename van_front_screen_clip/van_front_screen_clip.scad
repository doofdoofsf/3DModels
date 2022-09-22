$fn=100;

thickness=2.7;
clip_length=thickness*12;
clip_width=15;
fiddle=1;

module clip_shape(height, width, length) {
    end_cube_thickness=3;
    hull() {
        translate([length-end_cube_thickness/2, 0, 0]) {
           cube([end_cube_thickness, width, height], center=true);
        }
        rotate([90, 0, 0]) cylinder(h=width, d=height, center=true);
    }
}


module hollowed_clip_shape() {
    difference() {
       clip_shape(2.9*thickness, clip_width, clip_length);
       clip_shape(1.9*thickness, clip_width+fiddle, clip_length+fiddle);
    }
}

rotate([90,0,0]) hollowed_clip_shape();

