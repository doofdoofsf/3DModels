$fn = 100;

radius = 30;
rounding_radius = 3.17;
wall_thickness = 4;
height = 25;

module rounded_hexagon(radius, rounding_radius) {
    hull() {
        for(angle = [90 : 60 : 360 + 90]) {
            rotate([0, 0, angle]) {
                translate([radius - rounding_radius, 0, 0]) {
                    circle(rounding_radius);
                }
            }                
        }
    }
}

module hollow_rounded_hexagon(radius, rounding_radius, wall_thickness) {
    difference() {
        rounded_hexagon(radius, rounding_radius);
        rounded_hexagon(radius - wall_thickness, rounding_radius);
    }
}

module hexagon_cell(radius, rounding_radius, wall_thickness, height) {
    linear_extrude(height, center = true) {
        hollow_rounded_hexagon(radius, rounding_radius, wall_thickness);
    }
}

module cell(radius, rounding_radius, wall_thickness, height) {
    hexagon_cell(radius, rounding_radius, wall_thickness, height);
}

module cell_array(radius, rounding_radius, wall_thickness, height) {
    cell(radius, rounding_radius, wall_thickness, height);
    
    for(angle = [0 : 60 : 360 - 60]) {
        rotate([0, 0, angle]) {
            edge_distance = radius * sqrt(3) * 0.5;
            x_offset = 2 * edge_distance - wall_thickness/2;
            translate([x_offset, 0, 0]) {
                cell(radius, rounding_radius, wall_thickness, height);
            }
        }
    }
}

cell_array(radius, rounding_radius, wall_thickness, height);
        
