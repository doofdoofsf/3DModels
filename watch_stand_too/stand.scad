$fn=90;

watch_charger_core_dia = 27.7;
watch_charger_core_thickness = 8.1;
stand_rotation_angle = 14;
wire_dia = 2.8;

core_dia = watch_charger_core_dia * 1.02;
center_dia = watch_charger_core_dia * 1.2;
center_gap = center_dia * 0.85;
echo(center_gap);
center_hole_dia = watch_charger_core_dia * 0.85;
base_z_offset = -center_gap * 0.7;
base_y_offset = 12;
holder_thickness = 15;
show_charger = false;
show_stand = false;
show_rotated_stand = false;
show_base = false;
show_double_stand = true;

rounding_radius = 2;

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
    translate([center_gap/2, 0, watch_charger_core_thickness * 0.5 ]) 
        color("black") 
            charger_body(scale);
}

module oval_hole() {
    base_oval(center_hole_dia, holder_thickness * 2);
}

module frame_oval() {
    base_oval(center_dia * 1.35, holder_thickness);
}

module raised_oval() {
    base_oval(center_dia * 1.1, holder_thickness);
}
    
module stand_body(hole = true) {
    if (show_charger == true) charger(1.0);

    difference() {
        hull() {
            frame_oval();
            translate([0, 0, watch_charger_core_thickness * 0.3]) raised_oval();
        }
        
        union() { 
            if (show_charger == false) charger(1.005);
            if (hole) oval_hole();
        }
    }
}

module rotated_stand(hole = true) {
    rotate([stand_rotation_angle, 0, 0]) rotate([-90, -90, 0]) stand_body(hole);
}

module base(offset) {
    width = center_dia * 1.7 + offset;
    depth = holder_thickness * 2.7 + offset;
    height = watch_charger_core_thickness * 2.3;
    cut_depth = wire_dia * 1.5;

    translate([-width/2+rounding_radius, base_y_offset - depth, base_z_offset-height + rounding_radius]) {
        difference() {            
            minkowski() {
                cube([width - 2 * rounding_radius, 
                      depth - 2 * rounding_radius, 
                      height - 2 * rounding_radius]);
                sphere(r = rounding_radius);
            }
            translate([width/2-wire_dia/2-rounding_radius, -10, height-cut_depth-rounding_radius]) 
                cube([wire_dia, 35, cut_depth]);
        }          
    } 
}

module show_base() {
    scale_up = 1.01;
    scale([scale_up, scale_up, scale_up]) {
        difference() {
            base(0);
            rotated_stand();
        }
    }
}

module show_double_stand() {
   stand_body(true);
   translate([77, 0, 0]) stand_body();    
}

if (show_stand == true) stand_body();
if (show_rotated_stand == true) rotated_stand();
if (show_base == true) show_base();
if (show_double_stand == true) show_double_stand();



    
