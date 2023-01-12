include <../lib/apple_definitions.scad>

$fn=30;

//watch_charger_core_dia = 27.7;
//watch_charger_core_thickness = 6;

core_dia = watch_charger_core_dia * 1.02;
center_dia = watch_charger_core_dia * 1.2;
center_gap = center_dia * 0.7;
center_hole_dia = watch_charger_core_dia * 0.8;
holder_thickness = 13;

module base_oval(dia, thickness) {
    length = dia + center_gap;
    
    hull() {
        for (x = [-center_gap/2, center_gap/2]) {    
            translate([x, 0, 0]) cylinder(h = thickness, d = dia, center = true);
        }
    }
}

module oval_hole() {
    base_oval(center_hole_dia, holder_thickness);
}

module frame_oval() {
    base_oval(center_dia, holder_thickness);
}


difference() {
    frame_oval();
    oval_hole();
}
    
