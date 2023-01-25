$fn = 50;

mug_inside_dia = 78;
mug_thickness = 4.2;

top_overhang = 6;
//top_thickness = 11;
top_thickness = 4;
top_diameter = mug_inside_dia + mug_thickness * 2 + top_overhang * 2;

cutout_thickness = top_thickness / 2;

size_over_percent = 2;
size_up_ratio = (100.0 + size_over_percent) / 100.0;
size_down_ratio = (100.0 - size_over_percent) / 100.0; 

echo(size_up_ratio, size_down_ratio);

module top_cutout() {
    cutout_outside_dia = (mug_inside_dia + 2 * mug_thickness) * size_up_ratio;
    cutout_inside_dia = mug_inside_dia * size_down_ratio;
    
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
        render_fudge = 0.5;
        translate([0, 0, render_fudge+(top_thickness - cutout_thickness) / 2 ])
            top_cutout();
    }
}

top();