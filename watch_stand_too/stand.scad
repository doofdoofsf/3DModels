$fn=50;

watch_charger_core_dia = 27.7;
watch_charger_core_thickness = 8.1;

core_dia = watch_charger_core_dia * 1.02;
center_dia = watch_charger_core_dia * 1.2;
center_gap = center_dia * 0.5;
center_hole_dia = watch_charger_core_dia * 0.85;
base_z_offset = -center_gap*1.5;
base_y_offset = 8;
holder_thickness = 12;
show_charger = true;
show_stand = false;
show_rotated_stand = false;
show_insert = true;
show_base = true;


module base_oval(dia, thickness) {
    length = dia + center_gap;
    
    hull() {
        for (x = [-center_gap/2, center_gap/2]) {    
            translate([x, 0, 0]) cylinder(h = thickness, d = dia, center = true);
        }
    }
}

module charger_body(scale) {
    cylinder(h = watch_charger_core_thickness, 
             d = watch_charger_core_dia * scale);
}


module charger(scale) {
    translate([center_gap/2, 0, watch_charger_core_thickness * 0.2 ]) 
        color("black") 
            charger_body(scale);
}

module oval_hole() {
    base_oval(center_hole_dia, holder_thickness * 2);
}

module frame_oval() {
    base_oval(center_dia * 1.3, holder_thickness);
}

module raised_oval() {
    base_oval(center_dia * 1, holder_thickness);
}
    
module stand_body() {
    if (show_charger == true) charger(1.0);

    difference() {
        hull() {
            frame_oval();
            translate([0, 0, watch_charger_core_thickness * 0.3]) raised_oval();
        }
        
        union() { 
            if (show_charger == false) charger(1.01);
            oval_hole();
        }
    }
}

module rotated_stand() {
    rotate([9, 0, 0]) rotate([-90, -90, 0]) stand_body();
}

module base_insert_block() {
    width = center_dia * 1.2;
    depth = holder_thickness * 1.2;
    height = watch_charger_core_thickness * 1.05;
    
    translate([-width/2, base_y_offset - depth, base_z_offset-height])
        cube([width, 
              depth, 
              height]);
}

module base(offset) {
    width = center_dia * 1.7 + offset;
    depth = holder_thickness * 2.5 + offset;
    height = watch_charger_core_thickness * 1.3;
    
    translate([-width/2, base_y_offset - depth, base_z_offset-height])
        cube([width, 
              depth, 
              height]);
}

if (show_stand == true) stand_body();
if (show_rotated_stand == true) rotated_stand();

    
if (show_insert == true) {
    difference() {
        base_insert_block();
        rotated_stand();
    }
}

if (show_base == true) {
    difference() {
        base(0);
        base_insert_block();
    }
}
    
