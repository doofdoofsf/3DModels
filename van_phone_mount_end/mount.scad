/*
 * an end bracket for phone mount
 */

$fn=80;

width=12.3;
length=18.0;
wall_thickness = 3;
base_side = 35;
rounding_sphere = 3;

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

module base_2d() {
   minkowski() {
      square(32);
      circle(rounding_sphere);
   }
}

module receiver_hole() {
   linear_extrude(base_side+wall_thickness)
      receiver_shape(width, length);
}

module base() {
   linear_extrude(wall_thickness*2)
      base_2d();
}

module receiver() {
   linear_extrude(wall_thickness)
      receiver_shape(width+2*wall_thickness, length+2*wall_thickness);
   linear_extrude(base_side)
      receiver_2d();
}

module main_mount() {
   difference() {
      hull() {
         translate([13.0, 0, 10])
            rotate([-70, 0, 0])
               receiver();
         base();
      }
   
      translate([13.0, 0, 10])
         rotate([-70, 0, 0])
            receiver_hole();
   }
}

module base_cutout() {
   radius = 280;
   translate([-base_side/2, base_side, -radius+2.7])
      rotate([0, 90, 0])
         cylinder(r=radius, base_side*2);
}

difference() {
   main_mount();
   base_cutout();
}
