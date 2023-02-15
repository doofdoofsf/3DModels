$fn = 100;

module rounded_hexagon(radius, rounding_radius) {
    hull() {
        for(angle = [0 : 60 : 360 - 60]) {
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
wall_thickness = 0.1;
height = 25;

module cell() {
    hexagon_cell(radius = radius, rounding_radius = rounding_radius, 
                 wall_thickness = wall_thickness, height = height);
}

module cell_strip(count) {
    x_increment = 2 * (radius * 1.5 - wall_thickness/2);
    x_end = x_increment * (count - 1);
    for(x = [0, x_increment, x_end]) {
        translate([x, 0, 0]) {
            cell();
        }
    }   
}

y_increment = (sqrt(3)/2) * radius - wall_thickness/2;
//cell();
//translate([0, y_increment, 0]) cell();

cell_strip(3);
translate([radius * 1.5 - wall_thickness/2, y_increment, 0]) cell_strip(3);
translate([0, 2*y_increment, 0]) cell_strip(3);

//translate([radius * 1.5 - wall_thickness/2, radius - wall_thickness*1.5, 0]) cell();
