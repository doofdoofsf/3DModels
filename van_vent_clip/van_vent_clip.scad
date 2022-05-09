$fn=100;

thickness=2.5;
clip_length=thickness*12;
clip_width=8;
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

module body() {
    hollowed_clip_shape();
    translate([clip_length, 0, 2.4*thickness]) rotate([0, 0, 180]) hollowed_clip_shape();
}

spacing = 15;

offsets = [0*spacing, 1*spacing, 2*spacing, 3*spacing, 4*spacing, 5*spacing];
offsets = [0];

for (offset = offsets) {
  translate([offset, 0, 0])
        rotate([90, 0, 90]) body();
}


