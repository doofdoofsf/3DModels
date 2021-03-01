// https://i0.wp.com/sourcing.co.uk/wp-content/uploads/2019/03/Promotional-Bamboo-Desktop-Mobile-Phone-Stand-Holder.jpg

phone_width = 76;

arm_width = 10;

chair_height = 50;
chair_width = phone_width + 2 * arm_width;
chair_depth = 60;

back_rotation = 30;

module chair_back() {
   translate([arm_width, arm_width*2.2, 0])
      rotate([back_rotation, 0, 0])
        cube([chair_width - 2 * arm_width,
              arm_width,
	      chair_height*1.8]);
}

module chair_body() {
   difference() {
      cube([chair_width, chair_depth, chair_height]);
      translate([arm_width, arm_width*2, 0])
         rotate([back_rotation, 0, 0])
            cube([chair_width - 2 * arm_width, 
                 chair_depth,
	         chair_height*2]);
      translate([0, arm_width*6, 0])
         rotate([back_rotation, 0, 0])
	    cube([chair_width, chair_depth, chair_height*2]);

		 	
   }
}


minkowski() {
   $fn = 20;
   union() {
      chair_body();
      chair_back();
   }
   sphere(3);
}
