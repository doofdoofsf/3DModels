/*
 * a mount for a keychain ball compass for paragliding
 */

// https://www.internet-outdoorshop.com/en/399321-hypersonic-compass-ball-3-cm-black/

$fn=180;

sphere_diameter = 25.4;

module access_hole() {
   translate([0, 0, -sphere_diameter/2]) {
      cylinder(d=sphere_diameter/5, sphere_diameter);
   }
}

module body_cylinder() {
   difference() {
      cylinder(d=sphere_diameter*1.1, sphere_diameter*0.5);
      rotate([30, 0, 0]) {
         translate([0, 0, sphere_diameter*0.6]) {
            cube([sphere_diameter*1.3, sphere_diameter*1.3, sphere_diameter/3], center=true);
         }
      }
   }
}

module body() {
   cube_height = sphere_diameter*0.1;

   hull() {
      body_cylinder();
      translate([0, -sphere_diameter*0.2, cube_height/2]) {
         cube([sphere_diameter*1.1, sphere_diameter*1.05, cube_height], center=true);
      }
   }
}

module ball_depression() {
   translate([0, 0, sphere_diameter/2.1]) {
      sphere(d=sphere_diameter);
   }
}

module mount() {
   difference() {
      body();
      # ball_depression();
      access_hole();
   }
}

mount();
