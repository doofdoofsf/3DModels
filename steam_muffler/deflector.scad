/*
 * steam deflector for the muffler
 */

$fn=200;
thickness=3;

external_mount_diameter=102;
flange_width = 17;
body_diameter = external_mount_diameter+2*flange_width;
pin_height=17;
shield_height=pin_height-2;
fiddle=2;

module cutting_tool(angle) {
   rotate([0, 0, angle]) {
      // echo(angle);
      translate([0, body_diameter/2, shield_height/2+thickness/2]) {
         cube([20, thickness*3, shield_height], center=true);
      }
   }
}

module shield_gap() {
   for(angle = [0 : 15 : 200]) {
      cutting_tool(angle);
   }
}

module shield() {
   difference() {
      difference() {
         cylinder(h=shield_height, d=body_diameter);
         cylinder(h=shield_height+fiddle, d=body_diameter-2*thickness);
      }
      shield_gap();
   }
}


module disc_body() {
   height=thickness;
   cylinder(h=height, d=body_diameter, center=true);
}

module mount_pin() {
   pin_diameter=thickness+1;

   translate([external_mount_diameter/2+1.5, 0, 0]) {
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
      //temp_hole();
   }
   shield();
}

deflector();
