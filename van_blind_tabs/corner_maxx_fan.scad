/*
 * a corner tab to hold the maxxair fan blind up
 */

$fn=50;

rounding_sphere_diameter=3;
thickness=1.2;
wall_length=11;
height=7;

module base_cube() {
   minkowski() {
     cube([wall_length, wall_length, height]);
     sphere(d=rounding_sphere_diameter);
   }
}

module cube_corner() {
   difference() {
      base_cube();
      translate([thickness, thickness, thickness]) {
         base_cube();
      }
   }
}

module cube_corder_cutout() {
   true_wall_length = wall_length + rounding_sphere_diameter;
   cutout_wall_length = true_wall_length - 3 * thickness;

   translate([thickness/4, thickness/4, -2*thickness])
      cube([cutout_wall_length, cutout_wall_length, thickness*2]);
}

module tab() {
   difference() {
      cube_corner();
      cube_corder_cutout();
   }
}

offsets = [0, 20, 40, 60];

for (offset = offsets) {
   translate([offset, 0, 0])
      tab();
}
