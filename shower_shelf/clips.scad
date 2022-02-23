/*
 * clips for the shelf cover halfs
 */

$fn=60;
thickness = 1.0;

inside_clip_length = 11;
inside_clip_width = 6;
inside_clip_height = 5.2;

clip_length = inside_clip_length;
clip_width = inside_clip_width + 2*thickness;
clip_height = inside_clip_height + 2*thickness;

module clip_cube() {
   cube([clip_length, clip_width, clip_height], center=true);
}

module clip_cutout() {
   cube([inside_clip_length+3, inside_clip_width, inside_clip_height], center=true);
}

module clip_break() {
   height = thickness+3;
   translate([0, 0, (inside_clip_height+2*thickness)/2]) {
      cube([inside_clip_length+3, inside_clip_width*0.7, height], center=true);
   }
}

module clip() {
   rotate([0, 90, 0]) {
      difference() {
         clip_cube();
         clip_cutout();
         clip_break();
      }
   }
}

/*
for(spacing = [0 : 10 : 50]) {
   translate([0,  spacing, 0]) {
      clip();
   }
}
*/

clip();
