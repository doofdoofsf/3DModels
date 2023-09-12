$fn=100;
wall_thickness = 2;
section_length = 40;
end_taper = 1.5;

end_ext_dia = 99.0;
end_int_dia = end_ext_dia - 2 * wall_thickness;

rounding_radius = 5;
plate_size = 110;

screw_hole_diameter = 4;
screw_hole_inset = 7;


module mounting_plate_base() {
    plate_dim = plate_size/2 - rounding_radius;
    ends = [-plate_dim, plate_dim];
    hull() {
        for(x = ends) {
            for(y = ends) {
                translate([x, y, 0]) {
                    cylinder(wall_thickness, r = rounding_radius);
                }
            }
        }
    }
}

module mounting_plate_screw_holes() {
    hole_dim = plate_size/2 - screw_hole_inset;
    holes = [-hole_dim, hole_dim];
    for(x = holes) {
        for(y = holes) {
            translate([x, y, 0]) {
                cylinder(wall_thickness, d = screw_hole_diameter);
            }
        }
    }
}

module mounting_plate_hole() {
        translate([0, 0, -wall_thickness*2]) cylinder(wall_thickness*4, d = end_ext_dia);
}

module mounting_plate() {
    difference() {
        mounting_plate_base();
        mounting_plate_hole();
        mounting_plate_screw_holes();
    }
}
        
    
module end_tube() {
    difference() {
        cylinder(section_length, d1 = end_ext_dia, d2 = end_ext_dia-end_taper);
        cylinder(section_length, d1 = end_int_dia, d2 = end_int_dia-end_taper);
    }
}

module adaptor() {
    end_tube(); 
    mounting_plate();
}


adaptor();
    
    

