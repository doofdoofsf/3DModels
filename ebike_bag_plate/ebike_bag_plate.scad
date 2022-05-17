$fn=100;

plate_width=37;
plate_thickness=3;
plate_length=60;
cable_hole_diameter=18;
cable_hole_x_offset = -plate_length/5;
charge_port_diameter=12;
fiddle=1;
hole_height=plate_thickness+fiddle*2;

module donut(wheel_radius, tyre_diameter) {
    $fa = 1;
    $fs = 0.4;
    
    rotate_extrude(angle=360) {
        translate([wheel_radius - tyre_diameter/2, 0]) {
            circle(d=tyre_diameter);
        }
    }
}

module cable_hole_half_grommet() {    
    tyre_diameter = plate_thickness * 2;
    translate([cable_hole_x_offset, 0, plate_thickness/2]) {
        donut(cable_hole_diameter/2+tyre_diameter, tyre_diameter);
    }
}

module cable_hole() {
    translate([cable_hole_x_offset, 0, 0]) {
        cylinder(h=hole_height, d=cable_hole_diameter, center=true);
    }
}

module charge_port() {
    translate([plate_length/4, 0, 0]) {
        cylinder(h=hole_height, d=charge_port_diameter, center=true);
    }
}

module base_plate_with_holes() {
    difference() {
       base_plate();
       holes();
    }
    cable_hole_half_grommet();
}

module holes() {
    charge_port();
    cable_hole();
    alignment_holes();
}

module alignment_holes() {
    hole_diameter = 1;
    for(x=[plate_length/2-plate_thickness, -plate_length/2+plate_thickness]) {
        for(y=[plate_width/2-plate_thickness, -plate_width/2+plate_thickness]) {        translate([x, y, 0]) {
                echo(x,y);
                cylinder(h = plate_thickness + 2*fiddle, d=hole_diameter, center=true);
            }
        }
    }
}

module base_plate() {
    rounding_radius=5;

    linear_extrude(height=plate_thickness, center=true) {
        minkowski() {
           square([plate_length-rounding_radius*2,
            plate_width-rounding_radius*2],
            center=true);
           circle(r=rounding_radius);
        }
    }
}
base_plate_with_holes();
