// todo: bigger back plate hole area

include <definitions.scad>

$fn=70;
core_diameter=59.2;;
sphere_diameter=30;
num_petals = 9;
core_thickness=6;
show_supports = true;
show_front = false;
show_back = true;

back_raised_radius = 20.0;

module support_ring(core_diameter, num_petals = 3) {
    step = 360/num_petals;
    for(angle = [step/2 : step : 360]) {
        rotate([0, angle, 0]) translate([0, 0, core_diameter/2]) {
            cylinder(70, r = 1.75);
        }
    }
}

module glue_grooves() {
    for(radius = [5 : 2 : back_raised_radius * 0.9]) { 
        rotate_extrude()
            translate([radius, 0, 0])
                circle(r = 0.7);
    }       
}

module petal(height_scale) {
    scale([0.9, 0.43, height_scale]) {
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
        rotate([0, angle, 0]) 
            translate([0, 0, height_scale*8+core_diameter*0.5]) {
            petal(height_scale);
        }
    }
}

module core(core_thickness, core_diameter) {
    difference() {
        translate([0, core_thickness/2, 0]) {
            rotate([90, 0, 0]) {
                cylinder(h=core_thickness, r=core_diameter/2);
            }
        }
        translate([0, core_thickness/2, 0]) rotate([90, 0, 0]) glue_grooves();
    }
}


module body(petal_height_scale) {
    petal_ring(core_diameter = core_diameter, 
               num_petals=num_petals, 
               height_scale=petal_height_scale);
    
    if (show_supports) 
        support_ring(core_diameter = core_diameter, num_petals=num_petals);
    core(core_thickness, core_diameter);

}       

module plate_hole() {
    hole_length = core_thickness * 10;
    rotate([90, 0, 0]) cylinder(h=hole_length, r=shaft_radius*hole_scale, center=true);
}

module front_petal_ring() {
    difference() {
        body(1.3);
        plate_hole();
    }
}

module back_petal_ring() {
    difference() {
        union() {
            translate([0, -core_thickness, 0])
                rotate([0, 360/num_petals/2, 0]) body(1.8);
        }
        plate_hole();
    }
}

if(show_front) front_petal_ring();
if(show_back) back_petal_ring();

//translate([0, core_thickness, 0]) color("black") core(core_thickness, core_diameter);
