/*
 * keep my head safe from my rack
 */

$fn=50;

include <../lib/rounding.scad>

thickness=2;
hole_dia=5;
hole_x_offset=19;
hole_y_offset=14;

length=75;
width=42;

module hole(x,y) {
   translate([x, y, -thickness*2]) {
      cylinder(thickness*5, d=hole_dia, true);
   }
}

module thinner() {
   translate([-1,-2,-3]) {
      cube([length+2, width+2, 4]);
   }
}

difference() {
   roundedcube([length, width, thickness], false, thickness, "zmin");
   thinner();

   hole(hole_x_offset, hole_y_offset);
   hole(length-hole_x_offset, hole_y_offset);
}


