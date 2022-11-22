$fn=30;
core_diameter=30;
sphere_diameter=24;
num_petals = 9;
core_thickness=2;

module petal() {
    scale([0.7, 0.2, 1.2]) {
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

module petal_ring(core_diameter, num_petals = 3) {
    for(angle = [0 : 360/num_petals : 360]) {
        rotate([0, angle, 0]) translate([0, 0, sphere_diameter*0.3+core_diameter/2]) petal();
    }
}

module core(core_thickness, core_diameter) {
    translate([0, core_thickness/2, 0]) {
        rotate([90, 0, 0]) {
            cylinder(h=core_thickness, r=core_diameter/2);
        }
    }
}

module body() {
    difference() {
        union() {
            petal_ring(core_diameter = core_diameter, num_petals=num_petals);
            core(core_thickness, core_diameter);
        }
        core(core_thickness, core_diameter*0.85);
    }
        
}

body();
translate([0, -core_thickness, 0]) rotate([0, 360/num_petals/2, 0]) body();
