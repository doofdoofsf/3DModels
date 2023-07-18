/*
 * a mount for a keychain ball compass for paragliding
 */

// https://www.internet-outdoorshop.com/en/399321-hypersonic-compass-ball-3-cm-black/

$fn=180;

sphere_diameter = 29;
width = sphere_diameter * 1.3;

module engrave(text) {
   text_depth = 2.0;
   text_size = 6;

   translate([0, sphere_diameter*0.50, text_size*0.7]) {
      rotate([90, 0, 180]) {
         linear_extrude(text_depth+1) {
            text(text, size=text_size, halign="center", font="DejaVu Sans:style=Bold");
         }
      }
   }
}


module access_hole() {
   length = sphere_diameter * 2;
   diameter = 10;
   translate([0, 0, sphere_diameter*0.5]) {
      rotate([21, 0, 0]) {
         translate([0, 0, -length/2]) {
            cylinder(d=diameter, length);
         }
      }
   }
}


module body() {
    cube_height = sphere_diameter*0.22;

    cube([width, sphere_diameter*1.35, cube_height], center=true);
}

module ball_depression() {
   translate([0, 0, 2+sphere_diameter/1.6]) {
      sphere(d=sphere_diameter);
   }
}

module mount() {
   difference() {
      body();
      #ball_depression();
      access_hole();
   }
}

mount();
