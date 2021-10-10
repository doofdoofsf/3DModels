/*
 * flight deck bag insert
 */

$fn=200;

rounding_radius=5;

deck_thickness=1.2;
deck_width_bottom=245-2*rounding_radius;
deck_width_top=190-2*rounding_radius;
deck_indent=(deck_width_bottom-deck_width_top)/2;
deck_height=90-2*rounding_radius;

module 2d_deck() {
   deck_polygon=[[0,0], [deck_width_bottom, 0], [deck_width_bottom-deck_indent, deck_height], [deck_indent, deck_height]];
   polygon(deck_polygon);
};


module 3d_deck() {
   linear_extrude(height=deck_thickness) {
     minkowski() {
         2d_deck();
         circle(r=rounding_radius);
      }
   }
}

module deck_cutout() {
   diameter = deck_width_bottom*2.5;
   translate([diameter/2-(diameter-deck_width_bottom)/2,
             -(deck_height*3.5),
	     -1]) {
      cylinder(deck_thickness+2, d=diameter);
   }
}

difference() {
   3d_deck();
   deck_cutout();
}
