/*
 * tilting mount for a vario
 */

$fn = 100;

mount_width = 100;
mount_height = 60;
mount_thickness = 2.2;

module mount_plane() {
   cube([mount_width, mount_thickness, mount_height]);
}

module corner_plane() {
   cube([mount_width, mount_thickness, mount_height/4]);
}

module corner(mount_angle) {
   hull() {
      corner_plane();
      rotate([mount_angle, 0, 0]) {
         corner_plane();
      }
   }
}

module render_mount(mount_angle) {
   mount_plane();
   rotate([mount_angle, 0, 0]) {
      mount_plane();
   }
   corner(mount_angle);
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
