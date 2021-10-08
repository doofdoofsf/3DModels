/*
 * flight deck platform
 */

$fn=50;

rounding_radius=5;

deck_thickness=2;
deck_width_bottom=240-2*rounding_radius;
deck_width_top=190-2*rounding_radius;
deck_indent=(deck_width_bottom-deck_width_top)/2;
deck_height=80-2*rounding_radius;

deck_polygon=[[0,0], [deck_width_bottom, 0], [deck_width_bottom-deck_indent, deck_height], [deck_indent, deck_height]];


linear_extrude(height=deck_thickness) {
  minkowski() {
      polygon(deck_polygon);
      circle(r=rounding_radius);
   }
}
