/*
 * a sewing jig for lines
 */

$fn = 100;

jig_width = 33;
border = 10;

slot_width = 6.5;
slot_length = 75;
jig_length = slot_length+2*border;

bump_diameter = 2;
bump_height = 0.5;
slot_indent = 1;

jig_thickness = slot_width*0.48 - bump_height;
text_depth = jig_thickness + 2;


module size_text() {
   translate([16, 7, text_depth/2+1]) {
      rotate([0,180,180]) {
         linear_extrude(text_depth) {
            text(str(slot_width,"mm"), size=4, halign="center", font="DejaVu Sans:style=Bold");
         }
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

module tapered_slot() {
   slot_polygon=[[0,0], [slot_width+2*slot_indent, 0], [slot_width+slot_indent, jig_thickness], [slot_indent, jig_thickness]];

   linear_extrude(height=slot_length) {
      polygon(slot_polygon);
   }
};


module positioned_tapered_slot() {
   translate([jig_width/2-slot_width/2-slot_indent, border+slot_length, 0]) {
      rotate([90,0,0]) {
         tapered_slot();
      }
   }
}

difference() {
   jig(jig_thickness);
   positioned_tapered_slot();
   size_text();
}

raised_bumps();
