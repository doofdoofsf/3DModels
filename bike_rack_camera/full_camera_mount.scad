include <mount_shim.scad>

$fn = 60;

mount_width = 61;
mount_height = 60;

hole_size = 28.2;
thickness = 4.5;

mount_hole_radius = 3.3/2;
mount_hole_vertical_separation = 9.5;

square_hole_z_offset = mount_height/6;

mount_angle = 37.5;

show_shim = true;
show_mount = false;

module hole() {
    rotate([90, 0, 0]) cylinder(h = thickness+1, r = mount_hole_radius, center = true);
}
    

module camera_holes() {
    offset = hole_size/2+3.0;
    offsets = [[-offset, 0], [offset, 0]];
    
    for(o = offsets) {
        echo(o);
        
        translate([o[0], 0, square_hole_z_offset+o[1]]) {
            hole();
        }
    }
}

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
        translate([0, 0, square_hole_z_offset]) {
            cube([hole_size, thickness + 1, hole_size], center = true);
        }
    }
}

module complete_mount() {
    difference() {
        holy_mount_square();
        camera_holes();
    }
}

module shim_with_mount_hole() {
    difference() {
        rotate([0, 90, 90]) shim();
        #translate([0, 30, 28]) rotate([-mount_angle, 0, 0]) complete_mount();

    }
}

if(show_shim) translate([0, 0, shim_width/2]) shim_with_mount_hole();
if(show_mount) translate([0, 55, thickness/2]) rotate([90, 0, 0]) complete_mount();