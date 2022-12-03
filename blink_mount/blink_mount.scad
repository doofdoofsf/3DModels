inside_base_x = 70.0;
inside_base_y = 30.5;
inside_base_z = 24.0;
crade_push_out = 20;
ledge_indent = 12.0;
tilt = 20;
thickness = 2.0;

outside_base_height_normal = inside_base_z + thickness;
outside_base_height_high = inside_base_z * 2;

module base_cube(high=false) {
    z = high == true ? outside_base_height_high : outside_base_height_normal;
    cube([inside_base_x + thickness * 2,
      inside_base_y + thickness * 2,
      z], center=true);
}

module inside_cube() {
    cube([inside_base_x,
      inside_base_y,
      inside_base_z], center=true);
}

module base_cube_with_step() {
    difference() {
        base_cube(high=true);
        translate([0, -(inside_base_y+2*thickness)/2 + ledge_indent/2, -ledge_indent] )
            cube([inside_base_x + 2*thickness,
                  ledge_indent, 
                  outside_base_height_high], center=true);
    }
}

module cradle() {
    difference() {
        hull() {
            rotate([tilt, 0, 0]) base_cube();
            translate([0, -inside_base_y/2, -inside_base_z]) base_cube_with_step();
        }
        rotate([tilt, 0, 0]) translate([0, 0, thickness]) inside_cube();
    }
   
}

cradle();
    