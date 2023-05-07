$fn = 100;

level_radius = 30;
level_height = 7;
cutoff_side = level_radius * 2.1;

module level(angle) {
    difference() {
        cylinder(h = level_height, r = level_radius, center = true);
        translate([0, 0, -level_height/3]) {
            rotate([angle, 0, 0]) {
                cube([cutoff_side, cutoff_side, 6], center = true);
            }
        }
    }
}

increment = level_radius*2+4;


rotate([0, 180, 0]) {
    translate([-increment, 0, 0]) level(1);
    translate([0, 0, 0]) level(2);
    translate([increment, 0, 0]) level(3);
}