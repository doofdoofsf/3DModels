$fn = 200;

mug_inside_dia = 78;
mug_thickness = 4.2;

top_overhang = 6;
top_thickness = 11;
top_diameter = mug_inside_dia + mug_thickness * 2 + top_overhang * 2;

cutout_thickness = top_thickness / 2;

module top_cutout() {
    cutout_inside_dia = mug_inside_dia * 0.98;
    cutout_outside_dia = cutout_inside_dia + mug_thickness * 2 * 1.02; 
    
    difference() {
        cylinder(d = cutout_outside_dia, h = cutout_thickness, center = true);
        cylinder(d = cutout_inside_dia, h = cutout_thickness, center = true);
    }
}

module top_disc() {
    cylinder(h = top_thickness, d = top_diameter, center=true);
}

module top() {
    difference() {
        top_disc();
        translate([0, 0, (top_thickness - cutout_thickness) / 2 ])
            top_cutout();
    }
}

top();