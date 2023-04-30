$fn = 60;

mount_width = 47;
mount_height = 55;

hole_size = 28;
thickness = 2.5;

mount_hole_radius = 3.3/2;
mount_hole_vertical_separation = 9.5;

module flat_rounded_cube(size, rounding_radius) {
    width = size[0];
    height = size[1];
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

module mount_square() {
    flat_rounded_cube([mount_width, mount_height, thickness], 4);
}

module holy_mount_square() {
    difference() {
        mount_square();
        translate([0, 0, mount_height/8]) {
            cube([hole_size, thickness + 1, hole_size], center = true);
        }
    }
}

module mount_hole_array() {
    x_offset = mount_width * 0.8 / 2;
    z_offset = mount_hole_vertical_separation/2;
    
    for(x = [x_offset, -x_offset]) {
        for(z = [z_offset, -z_offset]) {
            translate([x, 0, z]) {
                rotate([90, 0, 0]) {
                    cylinder(h = thickness+1, r = mount_hole_radius, center = true);
                }
            }
        }
    }
}

module complete_mount() {
    difference() {
        holy_mount_square();
        translate([0, 0, -mount_height*0.32]) mount_hole_array();
    }
}

complete_mount();