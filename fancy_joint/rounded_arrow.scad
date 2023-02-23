$fn = 100;
rr = 3.17;
log_width = rr * 1.3;
log_length = 6*rr;
triangle_base = 4*rr;

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

module round_triange_base() {
    translate([-rr*3, log_width]) quarter_rounder(rr);
    rotate([180, 0, 0]) translate([-rr*3, log_width]) quarter_rounder(rr);
}

module round_shaft_base() {
    translate([-log_length*2, 0]) rotate([0, 180, 0]) round_triange_base();
}

module shaft() {
    translate([-log_length*1.5, 0]) log(log_width, log_length);
}

module arrow() {
    triangle(rr, triangle_base);
    shaft();
    round_triange_base();
    round_shaft_base();
}

module arrow_at_zero() {
    translate([log_length*1.5, 0]) arrow();
}

module arrows(count) {
    y_increment = triangle_base * 3;
    for(y = [0 : y_increment : y_increment * (count - 1)]) {
        translate([0, y, 0]) arrow_at_zero();
    }
}

arrows(3);


    
    

