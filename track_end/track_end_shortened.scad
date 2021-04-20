module base_cap() {
   translate([0, -102, 0])
      import("3rdParty/ltrack_ends/L_Track_End_-_Blank.stl");
}

module shortened_base_cap() {
   difference() {
      base_cap();
      translate([-10, 35, -15])
         rotate([22, 0, 0]) 
            cube(38);
   }
}

offsets = [0, 35, 70, 105, 140];

for (offset = offsets) {
  translate([offset, 0, 0]) 
     shortened_base_cap();
}
