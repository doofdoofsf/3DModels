$fn=100;

thickness=2.5;
clip_length=thickness*12;
clip_width=thickness*5;
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

module clip_loop() {
    height=clip_width;
    translate([clip_length-thickness*2, 0, thickness*2.6]) {
        rotate([90, 0, 0]) {
            difference() {
                cylinder(h=height, d=thickness*3.5, center=true);
                cylinder(h=height+fiddle, d=thickness*2.5, center=true);
            }
        }
    }
}

module hollowed_clip_shape() {
    difference() {
       clip_shape(2.8*thickness, clip_width, clip_length);
       clip_shape(1.8*thickness, clip_width+fiddle, clip_length+fiddle);
    }
}

module body() {
    hollowed_clip_shape();
    clip_loop();
}

spacing = 15;

offsets = [0*spacing, 1*spacing, 2*spacing, 3*spacing, 4*spacing, 5*spacing];
offsets = [0];

for (offset = offsets) {
  translate([offset, 0, 0])
        rotate([90, 0, 90]) body();
}


