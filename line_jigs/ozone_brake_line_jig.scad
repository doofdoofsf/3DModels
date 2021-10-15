/*
 * a sewing jig for ozone brake lines
 */

$fn=100;

jig_width=33;
border=10;

slot_width=3.8;
slot_length=75;
jig_length=slot_length+2*border;
jig_thickness=1.2;
bump_diameter = 1.6;
bump_height=0.2;

module help_text() {
   translate([jig_width/2, jig_length-5, jig_thickness]) {
      linear_extrude(bump_height) {
         text("BOTTOM", size=3, halign="center");
      }
   }
}

module raised_bumps() {
   bump_count = 10;
   bump_spacing = (jig_length-2*bump_diameter) / bump_count;
   x_sequence = [bump_diameter, jig_width-bump_diameter];
   y_sequence = [ for (y = [bump_diameter : bump_spacing : jig_length]) y ];

   echo(y_sequence);

   for (x = x_sequence) {
      for (y = y_sequence) {
         translate([x, y, 0])
	    jig_raised_bump();
      }
   }
}

module jig_raised_bump() {
   translate([0,0,jig_thickness]) {
      cylinder(bump_height, d=bump_diameter);
   }
}

module jig(thickness) {
   cube([jig_width, jig_length, thickness]);
}

module slot() {
   translate([jig_width/2-slot_width/2, border, -1]) {
      cube([slot_width, slot_length, jig_thickness+2]);
   }
}

difference() {
   jig(jig_thickness);
   slot();
}

raised_bumps();
help_text();
