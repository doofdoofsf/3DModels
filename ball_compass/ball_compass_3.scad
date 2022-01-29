/*
 * a mount for a keychain ball compass for paragliding
 */

// https://www.internet-outdoorshop.com/en/399321-hypersonic-compass-ball-3-cm-black/

$fn=180;

sphere_diameter = 28.5;

module lanyard_loop() {
   loop_thickness = 4;
   translate([0, sphere_diameter*0.53, 0]) {
      difference() {
         diameter = sphere_diameter * 0.6;
         cylinder(h=3, d=diameter);
	 translate([0, 0, -1]) {
            cylinder(h=3+2, d=diameter-loop_thickness);
         }
      }
   }
}

module access_hole() {
   translate([0, 0, -sphere_diameter/2]) {
      cylinder(d=8, sphere_diameter);
   }
}

module body_cylinder() {
   difference() {
      cylinder(d=sphere_diameter*1.1, sphere_diameter*0.7);
      rotate([24, 0, 0]) {
         translate([0, 0, sphere_diameter*0.76]) {
            cube([sphere_diameter*1.3, sphere_diameter*1.3, sphere_diameter/3], center=true);
         }
      }
   }
}

module body() {
   cube_height = sphere_diameter*0.19;

   hull() {
      body_cylinder();
      translate([0, -sphere_diameter*0.2, cube_height/2]) {
         cube([sphere_diameter*1.5, sphere_diameter*1.5, cube_height], center=true);
      }
   }
   lanyard_loop();
}

module ball_depression() {
   translate([0, 0, sphere_diameter/1.7]) {
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
