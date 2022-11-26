// todo: bigger back plate hole area

include <definitions.scad>

$fn=30;
internal_core_diameter=58.8;
core_diameter = internal_core_diameter * 1.18;
sphere_diameter=30;
num_petals = 9;
core_thickness=3.6;
back_plate_thickness = core_thickness/2;
wire_radius = 1.5;

module petal(height_scale) {
    scale([0.8, 0.2, height_scale]) {
        intersection_for(n = [0 : 60: 360])
        {
            rotate([0, 0, n])
            {
                translate([5, 0, 0])
                sphere(r=sphere_diameter/2);
            }
        }
    }
}

module petal_ring(core_diameter, num_petals = 3, height_scale) {
    for(angle = [0 : 360/num_petals : 360]) {
        rotate([0, angle, 0]) translate([0, 0, sphere_diameter*0.4+core_diameter/2]) {
            petal(height_scale);
        }
    }
}

module core(core_thickness, core_diameter) {
    translate([0, core_thickness/2, 0]) {
        rotate([90, 0, 0]) {
            cylinder(h=core_thickness, r=core_diameter/2);
        }
    }
}

module body(petal_height_scale) {
    difference() {
        union() {
            petal_ring(core_diameter = core_diameter, 
                       num_petals=num_petals, 
                       height_scale=petal_height_scale);
            core(core_thickness, core_diameter);
        }
        core(core_thickness, internal_core_diameter);
    }
        
}

module back_plate_hole() {
    hole_length = back_plate_thickness * 15;
    rotate([90, 0, 0]) cylinder(h=hole_length, r=shaft_end_radius, center=true);
}

module back_plate_reenforcement() {
    rotate([90, 0, 0]) cylinder(h=back_plate_thickness*3, r=core_diameter/4);
}

module back_plate() {
    difference() {
        translate([0, -core_thickness-back_plate_thickness/2, 0]) {
            rotate([90, 0, 0]) cylinder(h=back_plate_thickness, r=core_diameter/2);
            back_plate_reenforcement();
        }   
        back_plate_hole();
    }
}

module ring_wire_cut() {
    cut_length = 12;
    rotate([0, 0, 0])
        translate([0, -core_thickness/2, core_diameter/2-cut_length/2])
            hull () {
                sphere(wire_radius);
                translate([0, 0, cut_length]) sphere(wire_radius);
            }
}

module front_petal_ring() {
    difference() {
        body(1.3);
        ring_wire_cut();
    }
}

module back_petal_ring() {
    difference() {
        union() {
            translate([0, -core_thickness, 0])
                rotate([0, 360/num_petals/2, 0]) body(1.8);
                    back_plate();
        }
        ring_wire_cut();
    }
}

front_petal_ring();
back_petal_ring();

* rotate([90, 0, 0]) {
    front_petal_ring();
    back_petal_ring();
    //translate([0, 3, 0]) color("black") core(core_thickness, internal_core_diameter);
}
