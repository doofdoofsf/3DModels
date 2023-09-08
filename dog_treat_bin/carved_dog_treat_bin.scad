$fn = 90;
color_dark = "Sienna";
color_light = "DarkGoldenrod";


outer_diameter = 142;
wall_thickness = 6;
inner_diameter = outer_diameter - 2 * wall_thickness;
base_height = 50;
kludge = 1;

handle_diameter = outer_diameter * 0.4;

bone_size = [578, 276, 50];

module bone(width, height) {
    scale = (width/bone_size[0]);
    scale([scale, scale, 1]) {
        translate([-bone_size[0]/2, -bone_size[1]/2, 0]) {
            linear_extrude(height = height, center = true) import("default_bone.svg");
        }
    }
    //#cube([bone_size[0], bone_size[1], height], center=true);
}

module base_cutout() {
    translate([0, 0, wall_thickness]) {
        cylinder(h = base_height, d = inner_diameter, center = true);
    }
}

module base_block() {
    cylinder(base_height, d = outer_diameter, center = true);
}

module base() {
    difference() {
        base_block();
        base_cutout();
    }
}

module lid_lower() {
    cylinder(wall_thickness, d = outer_diameter, center = true);
}

module lid_upper() {
    cylinder(wall_thickness, d = handle_diameter, center = true);
}

module lid_handle() {
    color(color_light) translate([0, 0, kludge]) bone(40, wall_thickness*2);
    cylinder(wall_thickness*2, d = handle_diameter, center = true);
}

module lid() {
    hull() {
        lid_lower();
        translate([0, 0, wall_thickness*1.5]) lid_upper();
    }
    translate([0, 0, wall_thickness*2.5]) lid_handle();
}

color(color_light) base();
translate([0, 0, base_height/2+ wall_thickness/2]) lid();
    