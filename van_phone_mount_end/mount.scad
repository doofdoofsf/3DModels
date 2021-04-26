/*
 * an end bracket for phone mount
 */

$fn=80;

width=12.5;
length=18.5;
wall_thickness = 3;

module receiver_shape(width, length) {
   hull() {
      circle(d=width);
      translate([length-width, 0, 0])
         circle(d=width);
   }
}

module receiver_2d() {
   difference() {
      receiver_shape(width+2*wall_thickness, length+2*wall_thickness);
      receiver_shape(width, length);
   }
}

module receiver() {
   linear_extrude(3)
      receiver_2d();
}

receiver();
