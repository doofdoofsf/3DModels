/*
 * a muffler for a steam shower vent
 */

$fn=200;

mount_diameter=50.5;
face_diameter=mount_diameter*2;
depth=15;
thickness=3;
fiddle=2;

module vent_holes() {
   hole_diameter=8;
   cylinder_height=thickness*5;
   hole_angles=[-120 : 30 : 120];

   for (hole_angle = hole_angles) {
      rotate([0, 0, hole_angle]) {
         translate([0, face_diameter/2, 0]) {
	    rotate([90, 0, 0]) {
                cylinder(h=cylinder_height, d=hole_diameter, center=true);
            }
         }
      }
   }
}

module face() {
   height=thickness;

   translate([0, 0, -(depth-height)/2]) {
      cylinder(h=height, d=face_diameter, center=true);
   }
}

module baffle() {
   baffle_diameter = face_diameter * 0.75;
   difference() {
      difference() {
         cylinder(h=depth, d=baffle_diameter, center=true);
         cylinder(h=depth+3, d=baffle_diameter-2*thickness, center=true);
      }
      translate([0, -baffle_diameter/2, 0]) {
         cube([baffle_diameter/2, baffle_diameter/2, depth+3], center=true);
      }
   }
}

module inside_mount() {
   taper=1;

   inside_depth = depth-2;

   difference() {
      bottom_diameter=mount_diameter-taper;
      top_diameter=mount_diameter;
      cylinder(h=inside_depth, d1=bottom_diameter, d2=top_diameter, center=true);
      cylinder(h=inside_depth+fiddle, d1=bottom_diameter-thickness*2, d2=top_diameter-thickness*2, center=true);
   }
}

module enclosure() {
   difference() {
      cylinder(h=depth, d=face_diameter, center=true);
      cylinder(h=depth+3, d=face_diameter-thickness*2, center=true);
   }
}

module vent_cutout() {
   translate([0, mount_diameter*0.4, depth*0.45]) {
      cube([mount_diameter, 10, depth], center=true);
   }
}

module muffler() {
   face();

   difference() {
      inside_mount();
      vent_cutout();
   }

   difference() {
      enclosure();
      vent_holes();
   }
   baffle();
}

muffler();
