$fn = 40;

outside_radius = 3.5;
wall_thickness = 4;
floor_thickness = 2;

base_height = 19;
base_width = 55;

lid_height = base_height/2;

show_lid = true;
show_base = true;

module block(width, radius, height) {
    c_distance = width / 2 - radius;
    c_distances = [c_distance, -c_distance];
    hull() {
        for(x = c_distances) {
            for(y = c_distances) {
                translate([x, y, 0]) {
                    cylinder(h = height, r = radius, center = true);
                }
            }
        }
    }
}

module base_block() {
    block(base_width, outside_radius, base_height);
};

module cutout() {
    translate([0, 0, floor_thickness]) {
        block(base_width - 2 * wall_thickness, outside_radius, base_height);
    }
}
    

module base() {
    difference() {
        base_block();
        cutout();
    }
}

module lid() {
    lid_fit = 0.98;
    
    block(base_width, outside_radius, lid_height);
    difference() {
        translate([0, 0, -base_height/2]) scale([lid_fit, lid_fit]) cutout();
        translate([0, 0, -base_height * 0.9]) base_block();
    }
}

if (show_lid) translate([0, 0, base_height/2 + lid_height/2]) lid();

if (show_base) #base();

