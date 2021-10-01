/*
 * a tab to hold the maxxair fan blind up
 */

$fn=50;
foot_size = 30;
foot_depth = 1.5;
hole_size = 16;
hole_depth = 5;
center = true;

thickness = 2;
radius = 1;

include <../lib/rounding.scad>


module coaster() {
   roundedcube([foot_size, foot_size, foot_depth], center, radius, "z");

   hole_square_size = hole_size + thickness;

   difference() {
      translate([0, 0, thickness]) {
         roundedcube([hole_square_size, hole_square_size, hole_depth], center, radius, "z");
      }
      translate([0, 0, thickness]) {
         roundedcube([hole_size, hole_size, hole_depth+1], center, radius, "z");
      }
   }
}

// for (offset = [0:35:70]) {
for (offset = [0]) {
   translate([offset, 0, 0])
      coaster();
}
