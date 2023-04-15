$fn = 60;

base_block_width = 25;
base_block_height = 50;
base_block_thickness = 6;

hole_radius = 2;

module base_block() {
    cube([base_block_width, 
                base_block_thickness, 
                base_block_height], center=true);

}

module base_block_holes() {
    edge_distance = hole_radius * 3;
    z_offset = base_block_height/2 - edge_distance;
    
    for(z = [-z_offset, z_offset]) {
        translate([base_block_width/4, base_block_thickness*0.6, z]) {
            rotate([90, 0, 0]) cylinder(h = base_block_width+10, r = hole_radius, center = true);
        }
    } 
}

module holy_base_block() {
    difference() {
        base_block();
        base_block_holes();
    }
}

holy_base_block();

//mount();
//translate([0, 50, 0]) mirror([0, 1, 0]) mount();