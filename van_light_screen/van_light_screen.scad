/*
 * a screen to shade the light
 */

$fn=50;

rounding_sphere_diameter = 1;

thickness = 1.5;
screen_length = 100;
screen_width = 20;

module screen() {
   cube([screen_length, screen_width, thickness]);
}

module tab() {
   cube([10, 8, thickness]);
}

module tabs() {
   offsets = [26.6, 63.4];

   for (offset = offsets) {
      translate([offset, thickness, 0]) {
         rotate([90, 0, 0]) {
            tab();
         }
      }
   }
}

module full_screen() {
   screen();
   tabs();
}

offsets = [0, 25, 50, 75];

for (offset = offsets) {
   translate([0, offset, 0]) {
      full_screen();
   }
}
