/*
 * a mount for a keychain ball compass for paragliding
 */

// https://www.internet-outdoorshop.com/en/399321-hypersonic-compass-ball-3-cm-black/

$fn=180;

sphere_diameter = 29;
width = sphere_diameter * 1.3;

module body_cylinder() {
   difference() {
      cylinder(d=sphere_diameter*1.2, sphere_diameter*0.68);
      rotate([15, 0, 0]) {
         translate([0, 0, sphere_diameter*0.76]) {
            cube([sphere_diameter*1.3, sphere_diameter*1.3, sphere_diameter/3], center=true);
         }
      }
   }
}

module body() {
   cube_height = sphere_diameter*0.22;

   hull() {
      body_cylinder();
      translate([0, -sphere_diameter*0.2, cube_height/2]) {
         cube([width, sphere_diameter*1.35, cube_height], center=true);
      }
   }
}

module ball_depression() {
   translate([0, 0, 2+sphere_diameter/1.6]) {
      sphere(d=sphere_diameter);
   }
}

module mount() {
   difference() {
      body();
      ball_depression();
   }
}

mount();
