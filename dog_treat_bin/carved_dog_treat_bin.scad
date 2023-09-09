$fn = 120;

show_base = false;
show_handle = true;
show_lid = true;
show_standalone_handle = false;
show_lid_inset = false;
show_standalone_inset = false;


color_dark = "Sienna";
color_light = "DarkGoldenrod";

outer_diameter = 142;
wall_thickness = 6;
inner_diameter = outer_diameter - 2 * wall_thickness;
inset_diameter = inner_diameter * 0.98;
base_height = 57;
kludge = 1;
handle_height = 15;

handle_diameter = outer_diameter * 0.4;

bone_size = [578, 276, 50];
bone_width = 70;


module bone(width, height) {
    scale = (width/bone_size[0]);
    scale([scale, scale, 1]) {
        translate([-bone_size[0]/2, -bone_size[1]/2, 0]) {
            linear_extrude(height = height, center = true) import("rounded_default_bone.svg");
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
    //cylinder(wall_thickness, d = handle_diameter, center = true);
    translate([0, 0, -wall_thickness/2]) bone(bone_width, wall_thickness);
}

module lid_handle() {
    color(color_light) translate([0, 0, handle_height/2+wall_thickness]) bone(bone_width, handle_height);
}

module lid() {
    color(color_dark) hull() {
        lid_lower();
        translate([0, 0, wall_thickness*1.8]) {
            lid_upper();
        }
    }
    if (show_lid_inset) color(color_dark) translate([0, 0, -wall_thickness]) lid_inset();
}

module show_full_lid() {
    translate([0, 0, 10+base_height/2+ wall_thickness/2]) {
        difference() {
            lid();
            lid_handle();
        }
        if(show_handle) lid_handle();
    }
}

if (show_lid) show_full_lid();
if (show_base) color(color_dark) base();
if(show_standalone_handle) lid_handle();
if(show_standalone_inset) lid_inset();

    