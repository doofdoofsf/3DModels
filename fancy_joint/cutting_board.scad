$fn = 100;
rr = 3.17;
shaft_width = rr * 1.3;
log_length = 6*rr;
triangle_base = 4*rr;
arrow_y_increment = triangle_base * 3;
joint_width = rr+log_length+triangle_base*sqrt(3);

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


module log(r, l) {
    hull() {
        circle(r);
        translate([l, 0]) circle(r);
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

module round_triangle_base() {
    translate([-rr*3, shaft_width]) quarter_rounder(rr);
    rotate([180, 0, 0]) translate([-rr*3, shaft_width]) quarter_rounder(rr);
}

module round_shaft_base() {
    translate([-log_length*2, 0]) rotate([0, 180, 0]) round_triangle_base();
}

module shaft() {
    translate([-log_length*1.5, 0]) log(shaft_width, log_length);
}

module arrow() {
    difference() {
        union() {
        triangle(rr, triangle_base);
        shaft();
        round_triangle_base();
        round_shaft_base();
        }
        translate([-log_length*1.5-shaft_width*2, -shaft_width]) square(shaft_width*2);
    }
}

module arrow_at_zero() {
    translate([log_length*1.5, 0]) arrow();
}

module arrows(count) {    
    for(y = [0 : arrow_y_increment : arrow_y_increment * (count - 1)]) {
        translate([0, y, 0]) arrow_at_zero();
    }
}

module centered_arrows(count, object_height) {
    total_length = arrow_y_increment * (count - 1) + triangle_base;
    y_offset = (object_height - total_length)/2 + triangle_base/2;
    translate([0, y_offset]) arrows(count);
}

arrow();