$fn=100;

plate_length=70;
plate_width=57;
rounding_radius=5;
plate_thickness = 5;
fiddle=1;


module plate_holes() {
    mid_hole_from_edge = 7;
    mid_hole_from_center = plate_length/2 - mid_hole_from_edge;
    
    translate([mid_hole_from_center, 0, 0]) {
        plate_hole();
    }
    
    translate([-mid_hole_from_center, 0, 0]) {
        plate_hole();
    }
}

module charger_hole() {
    cylinder(h=plate_thickness+2*fiddle, d=30, center = true);
}

module plate_hole() {
    cylinder(h=plate_thickness+2*fiddle, d=5.5, center=true);
}

module base_plate() {  
    linear_extrude(height=plate_thickness, center=true) {
        minkowski() {
           square([plate_length-rounding_radius*2, 
            plate_width-rounding_radius*2],
            center=true);
           circle(r=rounding_radius);
        }
    }
}

module plate() {
    difference() {
        base_plate();
        plate_holes();
        charger_hole();
    }
}

module mount() {
    plate();
}

mount();