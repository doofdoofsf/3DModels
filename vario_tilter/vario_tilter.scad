/*
 * tilting mount for a vario
 */

$fn = 300;

mount_width = 58;
mount_height = 58;
mount_thickness = 2.2;

module curved_mount_plane() {
   distance_from_center = 60;

   translate([mount_width/2, 0, 0])
      rotate([90, 0, 0])
         rotate([0, 90, 0])
            translate([-distance_from_center, 0, 0])
               rotate_extrude(angle = 50) 
                  translate([60, 0, 0]) 
                     square(size = [mount_thickness, mount_width], center = true);
}

module mount_plane() {
   cube([mount_width, mount_thickness, mount_height]);
}

module corner_plane() {
   cube([mount_width, mount_thickness, mount_height/6]);
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
      curved_mount_plane();
   }
   corner(mount_angle);
}

module render_mounts() {
   // angles = [ for (a = [5 : 5 : 20]) a ];
   angles = [15];
   indexed_angles = [for (i = [0 : len(angles)-1]) [i, angles[i]] ];
   for(a = indexed_angles) {
      translate([0, a[0] * 40, 0]) {
         render_mount(a[1]);
      }
   }
}

render_mounts();
