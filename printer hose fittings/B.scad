

module base() {
   rotate([0, 0, 39]) {
      translate([-73, -63, 0]) {
         import("Dremel_3D45_Exhaust_Hose_Adapter_B.stl");
      }
   }
}

module cutting_tool(angle) {
      rotate([0, 0, angle]) {
         translate([0, -44, 16.0]) {
            cube([5, 10, 2], center=true);
         }
      }
}

module base_cut() {
   for(angle = [-12 : 1 : 10]) { 
      cutting_tool(angle);
   }
   for(angle = [167 : 1 : 189]) {
      cutting_tool(angle);
   }
}

difference() {
   base();
   // base_cut();
}

