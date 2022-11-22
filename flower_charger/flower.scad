$fn=30;
core_diameter=30;
sphere_diameter=24;
core_thickness = 7;
num_petals = 9;
petal_thickness=2;

module petal() {
    scale([0.7, 0.3, 1]) {
        intersection_for(n = [0 : 60: 360])
        {
            rotate([0, 0, n])
            {
                translate([5,0,0])
                sphere(r=sphere_diameter/2);
            }
        }
    }
}

module petal_ring(core_diameter = 10, num_petals = 3) {
    for(angle = [0 : 360/num_petals : 360]) {
        rotate([0, angle, 0]) translate([0, 0, sphere_diameter*0.3+core_diameter/2]) petal();
    }
}

color("black") translate([0, core_thickness/2, 0]) rotate([90, 0, 0]) cylinder(h=core_thickness, r=core_diameter/2);
translate([0, -core_thickness/2+petal_thickness, 0]) petal_ring(core_diameter = core_diameter, num_petals=num_petals);
translate([0, core_thickness/2-petal_thickness, 0]) rotate([0, 360/num_petals/2, 0]) petal_ring(core_diameter = core_diameter, num_petals=num_petals);