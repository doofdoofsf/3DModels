include <definitions.scad>
$fn=70;

tray_height = 14;
tray_width = 90;
tray_length = 180;
rounding_radius = tray_height / 5;
rim_width = 5;
main_radius = tray_width/2; 

module base_tray_form(height, width, length, radius) {
    x_offset = length/2 - radius;
    hull() {
        translate([x_offset, 0, 0]) cylinder(height, r=radius, center=true);
        translate([-x_offset, 0, 0]) cylinder(height, r=radius, center=true);
    }
}

module cutout_tray() {
    difference() {
        cutout_height = tray_height - rim_width;
        base_tray_form(tray_height, tray_width, tray_length, main_radius);
        translate([0, 0, (tray_height - cutout_height)/2]) {            
            base_tray_form(cutout_height,
                           tray_height-rim_width, 
                           tray_length - 2*rim_width, 
                           tray_width/2 - rim_width);
        }
    }
}

module filled_tray() {
    filled_length = tray_length * 0.6;
    cutout_tray();
    translate([(tray_length - filled_length)/2, 0, 0]) {
        difference() {
            base_tray_form(tray_height, tray_width, filled_length, main_radius);
            #cylinder(tray_height, r=shaft_radius);

        }
    }
}
    

filled_tray();

