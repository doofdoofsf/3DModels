$fn = 100;
rr = 3.17;
shaft_width = rr*2;
shaft_length = 8*rr;
triangle_base = 4*rr;
arrow_y_increment = triangle_base * 2.7;
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
    x_offset = -(triangle_base+rr)*sqrt(3)/2.89;
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

module arrows(shaft_width, shaft_length, count) {    
    for(y = [0 : arrow_y_increment : arrow_y_increment * (count - 1)]) {
        translate([0, y, 0]) arrow_at_zero(shaft_width, shaft_length);
    }
}

module centered_arrows(count, object_height) {
    total_length = arrow_y_increment * (count - 1) + triangle_base;
    y_offset = (object_height - total_length)/2 + triangle_base/2;
    translate([0, y_offset]) arrows(count);
}

module tile() {
    square(base_tile_width);
}

//tile();

num_arrows = 4;

arrows_height = rr*2 + sqrt(3) * triangle_base + arrow_y_increment * (num_arrows - 1);

translate([0, -14]) square([10, arrows_height]);

arrows(shaft_width, shaft_length, num_arrows);
