/*
 * coaster for table
 */

$fn=50;
foot_depth = 1.5;
hole_x = 13;
hole_y = 65;
flange = 25;
hole_depth = 5;
center = true;

thickness = 2.5;
radius = 1;

include <../lib/rounding.scad>

module coaster() {
   roundedcube([hole_x+flange, hole_y+flange, foot_depth], center, radius, "z");

   hole_square_x = hole_x + thickness;
   hole_square_y = hole_y + thickness;

   difference() {
      translate([0, 0, thickness]) {
         roundedcube([hole_square_x, hole_square_y, hole_depth], center, radius, "z");
      }
      translate([0, 0, thickness]) {
         roundedcube([hole_x, hole_y, hole_depth+1], center, radius, "z");
      }
   }
}

spacing=hole_x+flange+5;

for (offset = [0,spacing,spacing*2,spacing*3]) {
// for (offset = [0]) {
   translate([offset, 0, 0])
      coaster();
}
