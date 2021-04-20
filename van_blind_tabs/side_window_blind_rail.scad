/*
 * a rail for the van side window to hold the blind in
 */

$fn=50;

rounding_sphere_diameter = 1;

rail_length = 12;
rail_width = 5;
thickness = 1.1;

module base() {
   cube([rail_length, rail_width, thickness]);
}

module base_foot() {
   cube([rail_length, thickness, thickness]);
}

module sculpted_back() {
   hull() {
      back();
      base_foot();
   }
}
      
module back() {
   fudge = rounding_sphere_diameter/2;
   translate([fudge, rounding_sphere_diameter*0.7, fudge]) {
      rotate([90, 0, 0]) {
         minkowski() {
            $fn=50;
            cube([rail_length-rounding_sphere_diameter, rail_width-rounding_sphere_diameter, thickness-rounding_sphere_diameter]);
            sphere(d=rounding_sphere_diameter);
         }
      }
   }
}

sculpted_back();
base();
