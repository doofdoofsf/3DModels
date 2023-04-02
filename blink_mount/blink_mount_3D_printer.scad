inside_base_x = 70.0;
inside_base_y = 31.0;
inside_base_z = 24.0;
crade_push_out = 20;
ledge_indent = 8.5;
tilt = [20, 0, -25];
thickness = 2.0;

mc_width = 80;
mc_height = 50;
mc_depth = 9.5;

outside_base_height_normal = inside_base_z + thickness;
outside_base_height_high = inside_base_z * 2;

module base_cube(high=false) {
    z = high == true ? outside_base_height_high : outside_base_height_normal;
    cube([inside_base_x + thickness * 2,
      inside_base_y + thickness * 2,
      z], center=true);
}

module mount_cubes() {
    y_offset = 25;
    
    
    translate([-mc_width/2, y_offset, -mc_height/2]) {
        cube([mc_width, mc_depth, mc_height]);
    }
    
    translate([-mc_width/2, 0, -mc_height/2]) {
        cube([mc_width, y_offset, mc_height/2]);
    }
}

module inside_cube() {
    cube([inside_base_x,
      inside_base_y,
      inside_base_z], center=true);
}


module cradle() {
    difference() {
        hull() {
            mount_cubes();
            rotate(tilt) base_cube();
        }
        
        z_offset = 30;

        rotate(tilt) translate([0, 0, thickness+z_offset/2]) {
            cube([inside_base_x,
                inside_base_y,
                inside_base_z+z_offset], center=true);
        }
    }
   
}

cradle();
    