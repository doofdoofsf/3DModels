$fn = 90;
color_dark = "Sienna";
color_light = "DarkGoldenrod";

outer_diameter = 140;
layer_height = 19.05; // 3/4" wood
wall_thickness = 8;
inner_diameter = outer_diameter - 2*wall_thickness;
kludge = 1;

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
        
    

color(color_light) base();
color(color_dark) wall_layer(1);
color(color_light) wall_layer(2);
color(color_dark) wall_layer(3);
color(color_light) wall_layer(4);