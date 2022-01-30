/*
 * a muffler for a steam shower vent
 */

$fn=120;

mount_diameter=48;
face_diameter=mount_diameter*2;
depth=14;
thickness=3;
fiddle=2;

module vent_holes() {
   hole_diameter=9;
   distance_from_hole=face_diameter*0.35;
   cylinder_height=thickness*10;
   hole_angles=[-60, -30, 0, 30, 60];

   for (hole_angle = hole_angles) {
      rotate([0, 0, hole_angle]) {
         translate([0, -distance_from_hole, 0]) {
            cylinder(h=cylinder_height, d=hole_diameter, center=true);
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

module holy_face() {
   difference() {
      face();
      vent_holes();
   }
}

module inside_mount() {
   taper=1;

   difference() {
      bottom_diameter=mount_diameter-taper;
      top_diameter=mount_diameter;
      cylinder(h=depth, d1=bottom_diameter, d2=top_diameter, center=true);
      cylinder(h=depth+fiddle, d1=bottom_diameter-thickness*2, d2=top_diameter-thickness*2, center=true);
   }
}

module enclosure() {
   difference() {
      cylinder(h=depth, d=face_diameter, center=true);
      cylinder(h=depth, d=face_diameter-thickness*2, center=true);
   }
}

module vent_cutout() {
   translate([0, mount_diameter*0.4, depth*0.45]) {
      cube([mount_diameter, 10, depth], center=true);
   }
}

module muffler() {
   holy_face();
   difference() {
      inside_mount();
      vent_cutout();
   }
   enclosure();
}

muffler();
