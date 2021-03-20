
module delete_hands() {
   rotate([0, -25, 0])
      translate([33.1,0,-12])
         cube([30,80,30], center=true);
}

module hands_cutout() {
   rotate([0, -25, 0])
      translate([23.1,0,-22])
         cube([30,30.2,24], center=true);
}

module new_hands() {
   $fn=30;
   wall_thickness = 5.1;
   width = 67;

   rotate([0, -25, 0])
      translate([25,0,-24.15])
         union() {
            cube([20, width, wall_thickness], center=true);
	    hull() {
	       rotate([90,90,0])
	          translate([-7, 7.5, 0])
	             cylinder(h=width, d=wall_thickness, center=true);
	       rotate([0,90,0])
	          translate([-4, 0, 7.45])
	             cube([5, width, wall_thickness], center=true);
            }
		      
         }
}

module main_body() {
   difference() {
      import("resources/phone_stand.stl");
      delete_hands();
   }
}

difference() {
   union() {
      main_body();
      new_hands();
   }
   hands_cutout();
}
