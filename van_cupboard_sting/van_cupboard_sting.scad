$fn = 60;

base_block_width = 25;
base_block_height = 40;

mount_block_width = 15;
mount_block_height = 80;

thickness = 4;
hole_radius = 2;

rounding_radius = 4;

module flat_rounded_cube(size, rounding_radius) {
    width = size[0];
    height = size[2];
    echo(width, height);
    x_offset = width/2 - rounding_radius;
    z_offset = height/2 - rounding_radius;
    
    hull() {
        for(x = [x_offset, -x_offset]) {
            for(z = [z_offset, -z_offset]) {
                translate([x, 0, z]) {
                    rotate([90, 0, 0]) {
                        cylinder(h = thickness, r = rounding_radius, center = true);
                    }
                }
            }
        }
    }
}

module base_block(width, height) {
    size = [width, thickness, height];
    flat_rounded_cube(size, rounding_radius);
}

module base_block_holes(width, height) {
    edge_distance = hole_radius * 3;
    z_offset = height/2 - edge_distance;
    
    for(z = [-z_offset, z_offset]) {
        translate([-width/4, thickness*0.6, z]) {
            rotate([90, 0, 0]) cylinder(h = width+10, r = hole_radius, center = true);
        }
    } 
}

module holy_base_block(width, height) {
    difference() {
        base_block(width, height);
        base_block_holes(width, height);
    }
}

module mount() {
    base_block(base_block_width, base_block_height);
    
    translate([base_block_width/2-thickness/2, 
        mount_block_width/2+thickness/2, 
        -mount_block_height/2]) 
            rotate([0, 0, -90])
                holy_base_block(mount_block_width, mount_block_height);
}

mount();
translate([0, 40, 0]) mirror([0, 1, 0]) mount();

