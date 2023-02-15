$fn = 100;

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

radius = 30;
rounding_radius = 3.17;
wall_thickness = 5;
height = 25;

module cell() {
    hexagon_cell(radius = radius, rounding_radius = rounding_radius, 
                 wall_thickness = wall_thickness, height = height);
}

cell();

for(angle = [0 : 60 : 360 - 60]) {
    rotate([0, 0, angle]) {
        // this math isn't quite right
        translate([(radius - rounding_radius) * (sqrt(3)) + wall_thickness/2, 0, 0]) {
            cell();
        }
    }
}
        
