/*
 * a toggle for my easy bag
 */

$fn=50;

toggle_length=20;
toggle_width=10;
rounding_sphere_diameter=2;

module main_body() {
   minkowski() {
      cube([toggle_length, toggle_width, toggle_width]);
      sphere(d=rounding_sphere_diameter);
   }
}

module cut_out() {
   hole_height=15;
   hole_diameter=8;

   translate([toggle_length/2, hole_height-3, toggle_width/2])
      rotate([90,0,0])
         cylinder(h=hole_height, d=hole_diameter);
}


module toggle() {
   difference() {
      main_body();
      cut_out();
   }
}

toggle();
