/*
 * tilting mount for a vario
 */

$fn = 100;

mount_width = 100;
mount_height = 60;
mount_thickness = 2.5;

module mount_plane() {
   cube([mount_width, mount_thickness, mount_height]);
}

module reenforcer() {
   radius = mount_thickness*1.1;
   translate([0, -radius*0.22, 2.4*radius]) {
      rotate([0, 90, 0]) {
         cylinder(r=radius, h=mount_width);
      }
   }
}

module render_mount(mount_angle) {
   mount_plane();
   rotate([mount_angle, 0, 0]) {
      mount_plane();
   }
   reenforcer();
}

module render_mounts() {
   angles = [ for (a = [20 : 5 : 35]) a ];
   indexed_angles = [for (i = [0 : len(angles)-1]) [i, angles[i]] ];
   for(a = indexed_angles) {
      translate([0, a[0] * 50, 0]) {
         render_mount(a[1]);
      }
   }
}

render_mounts();
