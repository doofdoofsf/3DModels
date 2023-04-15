$fn = 60;

base_block_width = 25;
base_block_height = 50;
thickness = 6;

hole_radius = 2;

module base_block() {
    cube([base_block_width, 
                thickness, 
                base_block_height], center=true);

}

module base_block_holes() {
    edge_distance = hole_radius * 3;
    z_offset = base_block_height/2 - edge_distance;
    
    for(z = [-z_offset, z_offset]) {
        translate([-base_block_width/4, thickness*0.6, z]) {
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

module mount() {
    holy_base_block();
    
    translate([base_block_width/2-thickness/2, 
        base_block_width/2+thickness/2, 
        -base_block_height/2]) 
            rotate([0, 0, -90])
                holy_base_block();
}

mount();
translate([0, 80, 0]) mirror([0, 1, 0]) mount();