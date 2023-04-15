$fn = 100;

test_board_width = 20;
test_board_length = 40;
test_board_thickness = 10;
tool_radius = 1.5875; // 1/8"

module test_board() {
    cube([test_board_width, test_board_length, test_board_thickness]);
}

module pin(thickness) {
    pin_length = thickness;
    
    difference() {
        union() {
            cylinder(pin_length-tool_radius, r1 = thickness/2, r2 = thickness);
            translate([0, 0, -tool_radius]) pin_collar(thickness/2+tool_radius, tool_radius*1.7);
        }
        pin_flare((thickness/2+tool_radius)*1.0, tool_radius);

    }
}

module pins(thickness, length) {
    y_increment = thickness * 3;
    indent = thickness * 2;
    for(y = [indent : y_increment : length - indent]) {
        translate([0, y, 0]) {
            pin(thickness);
        }
    }
}

module pin_collar(radius, flare_radius) {
    cylinder(h=flare_radius, r=radius);
}

module pin_flare(radius, flare_radius) {
    rotate_extrude() 
        translate([radius, 0, 0]) 
            circle(r = flare_radius);
}

//pin(test_board_thickness);
//pin_flare(test_board_thickness, tool_radius);

//translate([-test_board_width, 0, 0]) test_board();
pins(test_board_thickness, test_board_length);