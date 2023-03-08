$fn = 100;
rr = 3.17;
shaft_width = rr*3;
shaft_length = 9*rr;
triangle_base = 5*rr;
joint_width = rr+shaft_length+triangle_base*sqrt(3);

base_tile_width = 140;

module quarter_rounder(r) {
    translate([-r, r]) {
        difference() {
            difference() {
                square(r*2, center = true);
                circle(r);
            }
            translate([0, r]) square(r*2, center = true);
            translate([-r, 0]) square(r*2, center = true);
        }
    }
}

module triangle(r, l) {
    hull() {
        for(a = [0, 120, 240]) {
            rotate([0, 0, a]) {
                translate([l, 0]) circle(r);
            }
        }
    }
}

module round_triangle_base(shaft_width) {
    x_offset = -(triangle_base+rr)*sqrt(3)/2.89;
    translate([x_offset, shaft_width/2]) quarter_rounder(rr);
    rotate([180, 0, 0]) translate([x_offset, shaft_width/2]) quarter_rounder(rr);
}

module round_shaft(shaft_width, shaft_length) {
    x_offset = -(triangle_base+rr)*sqrt(3)/2.93;
    translate([x_offset, shaft_width/2]) quarter_rounder(rr);
    rotate([180, 0, 0]) translate([x_offset, shaft_width/2]) quarter_rounder(rr);
    translate([-shaft_length+x_offset, 0]) rotate([0, 180, 0]) round_triangle_base(shaft_width);
}

module shaft(shaft_width, shaft_length) {
    echo(shaft_width, shaft_length);
    translate([-shaft_length, -shaft_width/2]) square([shaft_length, shaft_width]);
}

module arrow(shaft_width, shaft_length) {
    difference() {
        union() {
            triangle(rr, triangle_base);
            shaft(shaft_width, shaft_length);
            round_shaft(shaft_width, shaft_length);
        }
        translate([-shaft_length*1.5-shaft_width*2, -shaft_width]) square(shaft_width*2);
    }
}

module arrow_at_zero(shaft_width, shaft_length) {
    translate([shaft_length, 0]) arrow(shaft_width, shaft_length);
}

module spaced_arrows(base_tile_width, num_arrows, shaft_width, shaft_length) {
    y_spacing = base_tile_width / num_arrows;
    
    for(n = [0 : 1 : num_arrows - 1]) {
        translate([0, y_spacing * 0.5 + n * y_spacing]) {
            arrow_at_zero(shaft_width, shaft_length);
        }
    }
}


module tile() {
    square(base_tile_width);
}

difference() {
    tile();
    spaced_arrows(base_tile_width, 1, shaft_width, shaft_length);
    translate([base_tile_width, 0]) rotate([0, 0, 90]) spaced_arrows(base_tile_width, 1, shaft_width, shaft_length); 
}
