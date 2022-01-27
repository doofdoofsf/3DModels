/*
 * a mount for a keychain ball compass for paragliding
 */

$fn=180;

sphere_diameter = 25.4;
height=sphere_diameter/2.6;

module ball_depression() {
   translate([0, 0, sphere_diameter/3.2]) {
      sphere(d=sphere_diameter);
   }
}

module access_hole() {
   translate([0, 0, -sphere_diameter/2]) {
      cylinder(d=sphere_diameter/5, sphere_diameter);
   }
}

module body() {
   difference() {
      cylinder(h = height, r1 = sphere_diameter/1.4, r2 = sphere_diameter/1.6, center = true);
      access_hole();
   }
}

module mount() {
   difference() {
      body();
      # ball_depression();
   }
}

mount();
