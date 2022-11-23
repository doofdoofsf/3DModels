$fn=30;
core_diameter=30;
sphere_diameter=24;
num_petals = 9;
core_thickness=2.5;

module petal(height_scale) {
    scale([0.7, 0.2, height_scale]) {
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
        rotate([0, angle, 0]) translate([0, 0, sphere_diameter*0.3+core_diameter/2]) {
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
        core(core_thickness, core_diameter*0.85);
    }
        
}

body(1.5);
translate([0, -core_thickness, 0]) rotate([0, 360/num_petals/2, 0]) body(1.1);
