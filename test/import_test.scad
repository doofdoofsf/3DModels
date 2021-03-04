cube_size=65;
cube([cube_size,cube_size,cube_size], center=true);
translate([0,0,-cube_size/2-7])
   rotate([90,0,0])
      import("Auryn.stl");

translate([0,0,20])
   import("Aoda.stl");
