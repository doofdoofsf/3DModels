$fn=100;
clip_width=12;
clip_width=8;
clip_height=53;
clip_back_height=7;
grab_height=6.5;
grab_depth=13;
clip_depth=13;
thickness=2;
fiddle=1;

module clip_back() {
    difference() {
        cube([clip_width, clip_depth, clip_height], center=true);
        translate([0, 0, -thickness/2]) {
            cube([clip_width+2*fiddle, 
                clip_depth-2*thickness, 
                clip_height-thickness+fiddle], 
                center=true);
        }
        translate([0, thickness+fiddle, -clip_back_height]) {
            cube([clip_width+2*fiddle, 
                clip_depth-2*thickness, 
                clip_height-thickness], 
                center=true);
        }
    }
}

module clip_grabber() {
    translate([0, -clip_depth, -clip_height/2+thickness/2]) {
        cube([clip_width, grab_depth, thickness], center=true);
    }
    translate([0, -clip_depth, -clip_height/2+thickness/2+grab_height]) {
        cube([clip_width, grab_depth, thickness], center=true);
    }
}

module clip() {
    clip_back();
    clip_grabber();
}

spacing = 15;

//offsets = [0*spacing, 1*spacing, 2*spacing, 3*spacing];
offsets = [0];

for (offset = offsets) {
  translate([offset, 0, 0])
        rotate([0, 90, 90]) clip();
}