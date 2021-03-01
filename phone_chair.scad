// https://i0.wp.com/sourcing.co.uk/wp-content/uploads/2019/03/Promotional-Bamboo-Desktop-Mobile-Phone-Stand-Holder.jpg

phone_width = 76;

arm_width = 10;

chair_height = 50;
chair_width = phone_width + 2 * arm_width;
chair_depth = 80;
rounding_diameter = 6;

back_rotation = 30;

module chair_back() {
   translate([arm_width, arm_width*2.2, 0])
      rotate([back_rotation, 0, 0])
         cube([chair_width - 2 * arm_width, 
	      arm_width, 
	      chair_height*1.8]);
}

module chair_hole() {
   rotate([back_rotation, 0, 0])
      translate([chair_width / 2, chair_depth / 2.2, -chair_height])
         cylinder(d=15, h=chair_height*2);
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
      chair_hole();
   }
}


minkowski() {
   $fn = 20;
   union() {
      chair_body();
      chair_back();
   }
   sphere(d=rounding_diameter);
}
