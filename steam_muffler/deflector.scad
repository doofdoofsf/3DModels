/*
 * steam deflector for the muffler
 */

$fn=200;
thickness=3;

external_mount_diameter=102;
flange_width = 13;

module disc_body() {
   // height=thickness;
   height = 1.5; // !! change this !!
   body_diameter = external_mount_diameter+2*flange_width;
   cylinder(h=height, d=body_diameter, center=true);
}

module mount_pin() {
   pin_height=17;
   pin_diameter=thickness+1;

   translate([external_mount_diameter/2+3, 0, 0]) {
      translate([0, 0, pin_height/2]) {
         rotate([0, 4, 0]) {
            cylinder(h=pin_height, d=pin_diameter, center=true);
         }
      }
   }
}

module mount_pins() {
   for(angle = [0 : 60 : 360]) {
      rotate([0, 0, angle]) {
         mount_pin();
      }
   }
}

module temp_hole() {
   cylinder(h=10, d=external_mount_diameter-10, center=true);
}

module deflector() {
   mount_pins();

   difference() {
      disc_body();
      temp_hole();
   }

}

deflector();
