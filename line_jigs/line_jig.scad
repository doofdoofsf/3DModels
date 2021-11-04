/*
 * a set of sewing jigs for lines
 */

$fn = 100;

jig_width = 33;
slot_indent = 1;
slot_length = 65;
border = 10;
jig_length = slot_length+2*border;
bump_diameter = 2;
bump_height = 0.5;

// ***************************************************
// Here you can choose your smallest jig, biggest jig and the number of jigs you want

min_slot_width = 3.0;
max_slot_width = 5.5;
jig_set_count = 6;

// ***************************************************

slot_width_increment = (max_slot_width - min_slot_width) / (jig_set_count-1);

slot_widths = [ for (w = [min_slot_width : slot_width_increment : max_slot_width]) w ];

module size_text(text_depth, slot_width) {
   translate([16, 7, text_depth/2+1]) {
      rotate([0,180,180]) {
         linear_extrude(text_depth) {
	    rounded_slot_width = round(slot_width * 10)/10;
            text(str(rounded_slot_width,"mm"), size=5, halign="center", font="DejaVu Sans:style=Bold");
         }
      }
   }
}

module raised_bumps(jig_thickness) {
   bump_count = 10;
   bump_spacing = (jig_length-2*bump_diameter) / bump_count;

   x_sequence = [bump_diameter, jig_width-bump_diameter];
   y_sequence = [ for (y = [bump_diameter : bump_spacing : jig_length]) y ];

   for (x = x_sequence) {
      for (y = y_sequence) {
         translate([x, y, 0])
	    jig_raised_bump(jig_thickness);
      }
   }
}

module jig_raised_bump(jig_thickness) {
   translate([0,0,jig_thickness]) {
      cylinder(bump_height, d=bump_diameter);
   }
}

module jig(jig_width, jig_length, thickness) {
   cube([jig_width, jig_length, thickness]);
}

module tapered_slot(slot_width, jig_thickness) {
   slot_polygon=[[0,0], [slot_width+2*slot_indent, 0], [slot_width+slot_indent, jig_thickness], [slot_indent, jig_thickness]];

   linear_extrude(height=slot_length) {
      polygon(slot_polygon);
   }
};

module positioned_tapered_slot(slot_width, jig_thickness) {
   translate([jig_width/2-slot_width/2-slot_indent, border+slot_length, 0]) {
      rotate([90,0,0]) {
         tapered_slot(slot_width, jig_thickness);
      }
   }
}

module render_jig(slot_width) {
   projected_jig_thickness = slot_width*0.35 - bump_height;
   jig_thickness = projected_jig_thickness < 1.3 ? 1.3 : projected_jig_thickness;

   text_depth = jig_thickness + 2;

   difference() {
      jig(jig_width, jig_length, jig_thickness);
      positioned_tapered_slot(slot_width, jig_thickness);
      size_text(text_depth, slot_width);
   }

   raised_bumps(jig_thickness);
}

module render_jigs() {
   indexed_slot_widths = [for (i = [0 : jig_set_count-1]) [i, slot_widths[i]] ];
   echo(indexed_slot_widths);
   for(i = indexed_slot_widths) {
      translate([i[0] * (jig_width + 3), 0, 0]) {
         render_jig(i[1]);
      }
   }
}

render_jigs();
