$fn = 100;

radius = 25;
rounding_radius = 3.17;
wall_thickness = 4.5;
height = 25;
size_under_percent = 3;
size_down_ratio = (100.0 - size_under_percent) / 100.0;

show_tray = true;
show_lid = false;
show_lids = false;

module rounded_hexagon(radius, rounding_radius) {
    hull() {
        for(angle = [90 : 60 : 360 + 90]) {
            rotate([0, 0, angle]) {
                translate([radius - rounding_radius, 0, 0]) {
                    circle(rounding_radius);
                }
            }                
        }
    }
}

module hollow_rounded_hexagon(radius, rounding_radius, wall_thickness, hollow = true) {
    difference() {
        rounded_hexagon(radius, rounding_radius);
        if(hollow == true) rounded_hexagon(radius - wall_thickness, rounding_radius);
    }
}

module hexagon_cell(radius, rounding_radius, wall_thickness, height, hollow=true) {
    linear_extrude(height, center = true) {
        hollow_rounded_hexagon(radius, rounding_radius, wall_thickness, hollow);
    }
}

module cell(radius, rounding_radius, wall_thickness, height, hollow = true) {
    hexagon_cell(radius, rounding_radius, wall_thickness, height, hollow);
}

module cell_array(radius, rounding_radius, wall_thickness, height, hollow=true) {
    cell(radius, rounding_radius, wall_thickness, height, hollow);
    
    for(angle = [0 : 60 : 360 - 60]) {
        rotate([0, 0, angle]) {
            edge_distance = radius * sqrt(3) * 0.5;
            x_offset = 2 * edge_distance - wall_thickness/2;
            translate([x_offset, 0, 0]) {
                cell(radius, rounding_radius, wall_thickness, height, hollow);
            }
        }
    }
}

module lid() {
    translate([0, 0, height/2+wall_thickness/2]) {
       cell(radius+wall_thickness/2, rounding_radius, wall_thickness, wall_thickness, hollow=false);
        translate([0, 0, -wall_thickness]) {
           cell((radius-wall_thickness) * size_down_ratio, rounding_radius, wall_thickness, wall_thickness, hollow=false);    
        }
    }
}

module tray() {
    cell_array(radius, rounding_radius, wall_thickness, height);
    translate([0, 0, -height/2 + wall_thickness/2]) {
        cell_array(radius, rounding_radius, wall_thickness, wall_thickness, hollow=false);
    }
}

module lids() {
    rotate([180, 0, 0]) lid();
}

if(show_tray) tray();
if(show_lid) lid();
if(show_lids) lids();
    
    
        
