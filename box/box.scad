$fn = 100;

rounding_radius = 4;

module hexagon(radius, height) {
    cylinder(r=radius, h=height, $fn=6, center=true);
}

module hollow_hexagon(radius, height, wall_thickness) {
    difference() {
        hexagon(radius, height);
        hexagon(radius - wall_thickness, height * 2);
    }        
}

module hollow_hexagon_strip(radius, height, wall_thickness, count) {
    for(x = [0 : radius * 2 : radius * (count-1) * 2]) {
        translate([x, 0, 0]) {
           echo(x);
            hollow_hexagon(radius, height, wall_thickness);
        }
    }
}


// rounded_square(40, rounding_radius);
hollow_hexagon_strip(radius = 30, height = 25, wall_thickness = 4, count=3);