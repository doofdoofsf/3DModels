/*
 * a mount for a keychain ball compass for paragliding
 */

$fn=60;

include <../lib/rounding.scad>

sphere_diameter = 25.4;

cube_side_length=sphere_diameter*1.2;
cube_height=sphere_diameter/1.6;

rounding_diameter=sphere_diameter/5;

module access_hole() {
   translate([0, 0, -cube_side_length/2]) {
      cylinder(d=sphere_diameter/5, cube_side_length);
   }
}

module body() {
   roundedcube([cube_side_length, cube_side_length, cube_height], true, rounding_diameter, "zmax");
   base();
}

module base() {
   height=cube_side_length/12;
   side_length = cube_side_length*1.1;

   translate([0, 0, -cube_height/2+height/2]) {
      roundedcube([side_length, side_length, height], true, rounding_diameter/5, "zmax");
   }
}

module ball_depression() {
   translate([0, 0, sphere_diameter/4.5]) {
      sphere(d=sphere_diameter);
   }
}

module mount() {
   difference() {
      body();
      # ball_depression();
      access_hole();
   }
}

mount();
