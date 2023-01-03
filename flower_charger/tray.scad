include <definitions.scad>
include <flower_stalk.scad>
include <flower.scad>

$fn=100;

scale_up=1.1;
tray_height = 14;
tray_width = 90*scale_up;
tray_length = 125*scale_up;
rounding_radius = tray_height / 5;
rim_width = 5;
main_radius = tray_width/2; 
tray_depth = tray_height - rim_width;

echo(tray_depth);

module base_tray_form(height, width, length, radius) {
    x_offset = length/2 - radius;
    hull() {
        translate([x_offset, 0, 0]) cylinder(height, r=radius, center=true);
        translate([-x_offset, 0, 0]) cylinder(height, r=radius, center=true);
    }
}

module cutout_tray() {
    difference() {
        cutout_height = tray_depth;
        base_tray_form(tray_height, tray_width, tray_length, main_radius);
        translate([0, 0, (tray_height - cutout_height)/2]) {            
            base_tray_form(cutout_height,
                           tray_height-rim_width, 
                           tray_length - 2*rim_width, 
                           tray_width/2 - rim_width);
        }
    }
}

module tray_wire_cut() {
    translate([tray_length/2-rim_width/2, 0, (tray_height-tray_depth)/2])
        cube([rim_width*1.1, wire_radius*2, tray_depth], center=true);
}

module filled_tray() {
    filled_length = tray_length * 0.7;
    // cutout_tray();
    translate([tray_length/4-rim_width*2, 0, rim_width/2]) {
        //stalk();
        difference() {
            radius = main_radius-rim_width;
            cylinder(tray_height - rim_width, r=radius, center=true);
            translate([radius/2, 0, (tray_height - rim_width)/2 - wire_radius])
                cube([radius, wire_radius*2, wire_radius*2], center=true);
            translate([0, 0, -tray_height/2]) 
                cylinder(tray_height, r=shaft_radius * shaft_hole_scale);
        }
    }
}

module complete_tray() {    
    difference() {
        filled_tray();
        tray_wire_cut();
    }
    * translate([-10, 0, 130])rotate([90-shaft_angle, 0, 90]) {
        front_petal_ring();
        back_petal_ring();
    }
}

complete_tray();

