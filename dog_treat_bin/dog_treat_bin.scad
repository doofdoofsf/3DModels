$fn = 90;
color_dark = "Sienna";
color_light = "DarkGoldenrod";

outer_diameter = 135;
//layer_height = 19.05; // 3/4" wood
layer_height = 12.7; // 1/2" wood
wall_thickness = 8;
inner_diameter = outer_diameter - 2*wall_thickness;
kludge = 1;

bone_size = [578, 276, 50];

lid_diameter = outer_diameter * 1.05;
lid_bottom_diameter = inner_diameter * 0.98;
lid_bottom_thickness = layer_height / 2;

module bone(width, height) {
    scale = (width/bone_size[0]);
    scale([scale, scale, 1]) {
        translate([-bone_size[0]/2, -bone_size[1]/2, 0]) {
            linear_extrude(height = height, center = true) import("default_bone.svg");
        }
    }
    //#cube([bone_size[0], bone_size[1], height], center=true);
}

module basic_layer() {
    cylinder(layer_height, d = outer_diameter, center = true);
}

module layer_cutout() {
    cylinder(layer_height+kludge, d = inner_diameter, center = true);
}

module wall_layer(count) {
    translate([0, 0, layer_height * count]) { 
        difference() {
            basic_layer();
            layer_cutout();
        }
    }
}

module base() {
    difference() {
        basic_layer();
        translate([0, 0, wall_thickness]) layer_cutout();
    }
}    

module lid() {
    translate([0, 0, layer_height * 5]) {
        color(color_dark) cylinder(layer_height, d = lid_diameter, center = true);
        translate([0, 0, -(layer_height/2 + lid_bottom_thickness/2)]) {
            color(color_light) cylinder(lid_bottom_thickness, d = lid_bottom_diameter, center=true);
        }
    }   
}

module body() {
    color(color_light) base();
    color(color_dark) wall_layer(1);
    color(color_light) wall_layer(2);
    color(color_dark) wall_layer(3);
    color(color_light) wall_layer(4);

}
        
    

bone(100, 10);
//body();
//lid();