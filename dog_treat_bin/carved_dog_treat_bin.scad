$fn = 90;
color_dark = "Sienna";
color_light = "DarkGoldenrod";


outer_diameter = 142;
wall_thickness = 6;
inner_diameter = outer_diameter - 2 * wall_thickness;
inset_diameter = inner_diameter * 0.98;
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
        translate([0, 0, base_height/2 - wall_thickness/2]) lid_inset();
    }
}

module lid_inset() {
    cylinder(wall_thickness, d1 = inset_diameter, d2 = outer_diameter, center = true);
}

module lid_lower() {
    cylinder(wall_thickness, d = outer_diameter, center = true);
}

module lid_upper() {
    cylinder(wall_thickness, d = handle_diameter, center = true);
}

module lid_handle() {
    color(color_light) translate([0, 0, -wall_thickness/2]) bone(70, wall_thickness*4);
    //cylinder(wall_thickness*2, d = handle_diameter, center = true);
}

module lid() {
    color(color_dark) hull() {
        lid_lower();
        translate([0, 0, wall_thickness*1.5]) lid_upper();
    }
    color(color_dark) translate([0, 0, -wall_thickness]) lid_inset();

    translate([0, 0, wall_thickness*2.5]) lid_handle();
}

color(color_dark) base();
translate([0, 0, 10+base_height/2+ wall_thickness/2]) lid();
    