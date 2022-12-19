$fn=70;

tray_height = 12;
tray_width = 90;
tray_length = 180;
rounding_radius = tray_height / 5;

module base_tray_form(height, width, length) {
    x_offset = -length/2 + width/2;
    hull() {
        translate([x_offset, 0, 0]) cylinder(height, r=width/2, center=true);
        translate([-x_offset, 0, 0]) cylinder(height, r=width/2, center=true);
    }
}

module tray_with_indent(height, width, length) {
    indent_scale = 0.5;
    difference() {
        base_tray_form(height, width, length); 
        translate([-length/5, 0, indent_scale * height/2]) {
           base_tray_form(height * indent_scale, width * 0.9, length* indent_scale);     
        }        
    }    
}

tray_with_indent(tray_height, tray_width, tray_length);

hull() {
    tray_with_indent(tray_height, tray_width, tray_length);

    sphere(rounding_radius);
}