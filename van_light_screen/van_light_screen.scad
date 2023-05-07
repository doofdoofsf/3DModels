/*
 * a screen to shade the light
 */

$fn=50;

rounding_sphere_diameter = 1;

//screen_length = 200;
screen_length = 140;
screen_width = 20;

tab_length = 10;

module screen() {
   cube([screen_length, screen_width, 1.5]);
}

module tab(thickness) {
   cube([10, 8, thickness]);
}

module tabs(thickness) {
   offset_spacing = screen_length/3;
   offsets = [offset_spacing - tab_length/2, offset_spacing*2 - tab_length/2];

   for (offset = offsets) {
      translate([offset, thickness, 0]) {
         rotate([90, 0, 0]) {
            tab(thickness);
         }
      }
   }
}

module full_screen(thickness) {
   screen();
   tabs(thickness);
}

spacing = 25;

//for(s = [0, spacing*1]) {
for(s = [0]) {
   translate([0, s, 0]) {
      full_screen(1.5);
   }
}

//for(s = [spacing*2, spacing*3]) {
for(s = [spacing]) {
   translate([0, s, 0]) {
      full_screen(2.5);
   }
}
