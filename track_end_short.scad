$fn=50;
rounding_sphere_diameter=15;
capx = 30;
capy = 40;
capz = 12;

module base_cap() {
   translate([0, -102, 0])
      import("3rdParty/ltrack_ends/L_Track_End_-_Blank.stl");
}

module end_chopper_shape() {
   d = rounding_sphere_diameter;
   difference() {
      translate([0, 10, 0])
         cube([capx+6, 20+6, capz+6]);
      translate([d/2, 0, d/2]) {
         minkowski() {
            cube([capx-d+6, d+6, capz-d+6]);
	    sphere(d=rounding_sphere_diameter);
         }
      }
   }
}


module end_chopper() {
   translate([-8, 25, -1])
      #end_chopper_shape();
}

difference() {
   base_cap();
   translate([-8, 18, -1]) {
      end_chopper_shape();
   }
} 
