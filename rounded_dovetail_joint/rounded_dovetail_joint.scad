$fn = 100;

test_board_width = 20;
test_board_length = 100;
test_board_thickness = 10;


module test_board() {
    cube([test_board_width, test_board_length, test_board_thickness]);
}

module pin(thickness) {
    pin_length = thickness;
    difference() {
        rotate([0, 90, 0]) {
            cylinder(pin_length, r1 = thickness/2, r2 = thickness);
        }
        translate([-thickness, -thickness, -thickness*2])
        cube(thickness*2);
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

translate([-test_board_width, 0, 0]) test_board();
pins(test_board_thickness, test_board_length);