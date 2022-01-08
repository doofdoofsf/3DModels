/*
 * tilting mount for a vario
 */

$fn = 300;

normal_mount_width = 58;
extended_mount_width = 150;
mount_height = 58;
mount_thickness = 2.2;

module curved_mount_plane(mount_width) {
   distance_from_center = 60;

   translate([mount_width/2, 0, 0])
      rotate([90, 0, 0])
         rotate([0, 90, 0])
            translate([-distance_from_center, 0, 0])
               rotate_extrude(angle = 50) 
                  translate([60, 0, 0]) 
                     square(size = [mount_thickness, mount_width], center = true);
}

module mount_plane(mount_width) {
   cube([mount_width, mount_thickness, mount_height]);
}

module corner_plane(mount_width) {
   cube([mount_width, mount_thickness, mount_height/5]);
}

module corner(mount_angle, mount_width) {
   hull() {
      corner_plane(mount_width);
      rotate([mount_angle, 0, 0]) corner_plane(mount_width);
      rotate([mount_angle/2, 0, 0]) corner_plane(mount_width);
   }
}

module render_mount(mount_angle, mount_width) {
   mount_plane(mount_width);
   rotate([mount_angle, 0, 0]) {
      curved_mount_plane(mount_width);
   }
   corner(mount_angle, mount_width);
}

module render_mounts() {
   angles = [ for (a = [10 : 10 : 40]) a ];
   // angles = [15];
   indexed_angles = [for (i = [0 : len(angles)-1]) [i, angles[i]] ];
   for(a = indexed_angles) {
      translate([0, a[0] * 50, 0]) {
         render_mount(a[1]);
      }
   }
}

// render_mounts();
mount_angle = 45;
render_mount(mount_angle, normal_mount_width);
translate([0, 60, 0]) render_mount(mount_angle, extended_mount_width);
