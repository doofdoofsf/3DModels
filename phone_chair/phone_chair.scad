rounding_diameter = 6;
phone_width = 76;

arm_width = 10;
studs_side = 40;
stud_size = 1.0;

chair_height = 50;
chair_width = phone_width + 2 * arm_width + rounding_diameter;
chair_depth = 80;

back_width = chair_width - 2 * arm_width;
back_height = chair_height * 1.8;

back_rotation = 30;

module chair_studs() {
   $fn=30;
   studs_sequence = [0, studs_side/2, studs_side];
   for (x = studs_sequence) {
      for (z = studs_sequence) {
         translate([x, 0, z]) 
            sphere(stud_size);
      }
   }
}

module chair_back() {
   translate([arm_width, arm_width*2.0, 0])
      rotate([back_rotation, 0, 0])
         union() {
            cube([back_width, arm_width, back_height]);
            translate([(back_width-studs_side)/2, arm_width, (back_height-studs_side)/2])
	       chair_studs();
         }
}

module chair_hole() {
   hole_width = 20;
   rotate([back_rotation, 0, 0])
      translate([(chair_width - hole_width)/2, chair_depth / 2.6, -chair_height])
         cube([hole_width, hole_width*0.7, chair_height*0.865]);
}

module chair_wire_channel() {
   translate([chair_width / 2, -rounding_diameter, -rounding_diameter/2])
      rotate([0, 90, 90])
         cylinder(d=5, chair_depth/2+rounding_diameter);
}
   
module chair_body() {
   difference() {
      cube([chair_width, chair_depth, chair_height]);
      translate([arm_width, arm_width*2, 0])
         rotate([back_rotation, 0, 0])
            cube([chair_width - 2 * arm_width, 
                 chair_depth,
	         chair_height*2]);
      translate([0, chair_depth, 0])
         rotate([back_rotation, 0, 0])
	    cube([chair_width, chair_depth, chair_height*2]);
   }
}

module chair() {
   union() {
      difference() {
         chair_body();
      }
      chair_back();
   }
}

module rounded_chair() {
   minkowski() {
      difference() {
         chair();
         chair_hole();
      }
      sphere(d=rounding_diameter, $fn=20);
   }
}

difference() {
  // chair();
  rounded_chair();
  chair_wire_channel();
}
