/*
 * a tab to hold the maxxair fan blind up
 */

$fn=50;

back_size = 5;
thickness = 1.2;

module back() {
   translate([back_size/2, thickness, thickness])
      rotate([90, 0, 0])
         scale([1, 2, 1])
            cylinder(d=back_size, h=thickness);
}

module back_cutoff() {
   translate([0, 0, -back_size])
      cube(back_size);
}

cube([back_size, back_size, thickness]);
difference() {
   back();
   back_cutoff();
}
