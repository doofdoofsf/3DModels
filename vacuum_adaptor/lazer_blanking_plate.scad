$fn=100;
wall_thickness = 3;

rounding_radius = 5;
plate_size = 80;

screw_hole_diameter = 4;
screw_hole_inset = 4;

module blanking_plate_base() {
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

module blanking_plate_screw_holes() {
    hole_dim = plate_size/2 - screw_hole_inset;
    holes = [-hole_dim, hole_dim];
    for(x = holes) {
        for(y = holes) {
            translate([x, y, 0]) {
                #cylinder(wall_thickness, d = screw_hole_diameter);
            }
        }
    }
}


module blanking_plate() {
    difference() {
        blanking_plate_base();
        blanking_plate_screw_holes();
    }
}

blanking_plate();
    
    

