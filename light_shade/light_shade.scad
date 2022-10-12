$fn=100;

outside_dia = 144;
height = 70;
wall_thickness = 2;

module main_shade() {
    difference() {
        sphere(d = outside_dia);
        sphere(d = outside_dia - 2 * wall_thickness);
    }
}

module cutout() {
    cube(outside_dia, center=true);
}


module cutout_shade() {
   difference() { 
       main_shade();
       translate([0, 0, outside_dia/2]) cutout();
       translate([0, 0, -outside_dia * 0.88]) cutout();
       translate([-outside_dia/2, 0, -outside_dia/2-wall_thickness*3]) cutout();
   }
}

cutout_shade();
    

