$fn=30;

end_cube_size=15;
end_cube_height=10;
thickness=2;
fiddle=3;
shaft_length=50;
rounding_radius=2;

module holy_end_cup() {
    difference() {
        end_cup();
        translate([-end_cube_size/2-thickness, end_cube_size/4, 0]) {
            rotate([0, 90, 0]) {
               cylinder(r=2.5, h=30);
            }
        }
    }
}

module end_cup() {
    difference() {
        cube([end_cube_size, end_cube_size, end_cube_height], center=true);

        translate([thickness,thickness, 0]) {
            cube([end_cube_size, end_cube_size, end_cube_height+fiddle], center=true);
        }
    }
}

module shaft() {
    rotate([0, 0, -45]) {
        cube([thickness, shaft_length, end_cube_height], center=true);
    }
}

module end_cups() {
    translate([shaft_length/2-thickness, shaft_length/2-thickness, 0]) {
        holy_end_cup();
    }
    translate([-shaft_length/2+thickness, -shaft_length/2+thickness, 0]) {
        rotate([0, 0, 180]) end_cup();
    }
}

module body() {
    minkowski() {
        union() {
            end_cups();
            shaft();
        }
        sphere(rounding_radius/2);

    }
}

body();
