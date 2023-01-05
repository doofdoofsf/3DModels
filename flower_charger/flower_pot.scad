include <definitions.scad>

$fn=30;

pot_base_size = 60;
pot_base_height = pot_base_size * 0.5;
pot_base_top_size = pot_base_size * 1.2;
rounding_radius = pot_base_size / 20;

pot_topper_size = pot_base_top_size ;
pot_topper_height = pot_base_size / 7;
pot_topper_z = pot_base_height + pot_topper_height/2 + rounding_radius;

module base_rounded_cuboid(side_length, height) {
    base_side_length = side_length - 2*rounding_radius;
            
    minkowski() {
        cube([base_side_length, base_side_length, height - 2*rounding_radius], center=true);
        sphere(rounding_radius);
    }
}
    

module pot_base() {
    hull() {
        translate([0, 0, pot_base_height]) base_rounded_cuboid(pot_base_top_size, rounding_radius * 2.1);
        base_rounded_cuboid(pot_base_size, rounding_radius * 2.1);
    }
}

module pot_topper() {
    wall_thickness = 3;
    translate([0, 0, pot_topper_z]) {
        minkowski() {
            difference() {
                inside_cube_size = pot_topper_size - 2*wall_thickness;
                cube([pot_topper_size, pot_topper_size, pot_topper_height], center=true);
                cube([inside_cube_size, inside_cube_size, pot_topper_height], center=true);
            }
            sphere(rounding_radius);
        }
    } 
}

module shaft_cutout() {
    cutout_height = pot_base_height*2;
    cutout_radius = shaft_radius * hole_scale;
        
    translate([-pot_topper_size * 0.15, 0, pot_topper_z - cutout_height]) 
        #cylinder(cutout_height, r=cutout_radius, center=true);
}

module pot() {
    difference() {
        union() {
            pot_topper();
            pot_base();
        }
        
        shaft_cutout();
    }
}

pot();
