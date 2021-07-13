/*
 * a toggle for my easy bag
 */

$fn=50;

stem_length=100;
stem_width=8;
stem_thickness=3;

module stem() {
   cube([stem_length, stem_width, stem_thickness]);
}

module stem_end() {
   translate([0, 0, stem_thickness])
      #cube([stem_length/4, stem_width, stem_thickness]);
}

stem();
stem_end();
