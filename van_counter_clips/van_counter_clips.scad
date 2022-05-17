$fn=100;
clip_width=3;
clip_height=49;
clip_back_height=7;
grab_height=3.5;
grab_depth=13;
clip_depth=10;
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

clip();