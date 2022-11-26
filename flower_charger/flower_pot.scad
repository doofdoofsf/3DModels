//https://cdn-tp3.mozu.com/24645-37138/cms/37138/files/951f8afc-140d-49d5-8d02-ca46c08575c9?quality=60&_mzcb=_1649148331752

$fn=100;

pot_base_size = 60;
pot_base_height = pot_base_size * 0.5;
pot_base_top_size = pot_base_size * 1.2;
rounding_radius = pot_base_size / 20;

shaft_start_radius = 4.5;

pot_topper_size = pot_base_top_size * 1.1;
pot_topper_height = pot_base_size / 5;
pot_topper_z = pot_base_height + pot_topper_height/2;

module base_rounded_cuboid(side_length, height) {
    base_side_length = side_length - 2*rounding_radius;
            
    minkowski() {
        cube([base_side_length, base_side_length, height - 2*rounding_radius], center=true);
        sphere(rounding_radius);
    }
}

module top_cutout() {
    size = pot_topper_size * 0.8;
    
    translate([0, 0, pot_topper_z]) base_rounded_cuboid(size, pot_topper_height * 1.5);
}
    

module pot_base() {
    hull() {
        translate([0, 0, pot_base_height]) base_rounded_cuboid(pot_base_top_size, rounding_radius * 2.1);
        base_rounded_cuboid(pot_base_size, rounding_radius * 2.1);
    }
}

module pot_topper() {
    translate([0, 0, pot_topper_z]) {
        base_rounded_cuboid(pot_topper_size, pot_topper_height * 1.1);    
    } 
}

module shaft_cutout() {
    cutout_height = pot_base_height * 0.4;
    cutout_radius = shaft_start_radius * 1.04;
        
    translate([-pot_topper_size * 0.15, 0, pot_topper_z - cutout_height]) cylinder(cutout_height, r=cutout_radius, center=true);
}

module pot() {
    difference() {
        union() {
            pot_topper();
            pot_base();
        }
        
        top_cutout();
        shaft_cutout();
    }
}

pot();