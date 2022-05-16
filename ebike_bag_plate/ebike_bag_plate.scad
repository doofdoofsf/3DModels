$fn=100;

plate_width=37;
plate_thickness=3;
plate_length=50;
hole_diameter=18;
charge_port_diameter=12;
fiddle=1;

module charge_port() {
    translate([plate_length/4, 0, 0]) {
        cylinder(h=plate_thickness+fiddle*2, d=charge_port_diameter, center=true);
    }
}

module main_plate_with_charge_port() {
    difference() {
       main_plate();
       charge_port();
    }
}

module main_plate() {
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

module outside_plate() {
    main_plate_with_charge_port();
}


outside_plate();