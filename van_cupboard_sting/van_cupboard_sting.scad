$fn = 60;
base_block_width = 25;
base_block_height = 50;
base_block_thickness = 6;

mount_block_width = 6;
mount_block_height = 50;
mount_block_thickness = 20;

hole_radius = 2;



module base_block() {
    cube([base_block_width, , base_block_thickness, base_block_height], center = true);

}

module mount_block() {
    translate([base_block_width/2-mount_block_width/2,
                mount_block_thickness/2 + base_block_thickness/2, 
                -base_block_height/2]) {
        cube([mount_block_width, 
                    mount_block_thickness, 
                    mount_block_height], center=true);
    }

}

module mount_block_holes() {
    edge_distance = hole_radius * 3;
    for(z = [-edge_distance, -mount_block_height+edge_distance]) {
        translate([base_block_width/2, mount_block_thickness*0.6, z]) {
            rotate([0, 90, 0]) cylinder(h = mount_block_width+10, r = hole_radius, center = true);
        }
    } 
}

module mount() {
    base_block();
    difference() {
        mount_block();
        mount_block_holes();
    }
}

mount();
//translate([0, 50, 0]) mirror([0, 1, 0]) mount();