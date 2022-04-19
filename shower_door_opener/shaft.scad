$fn=30;

end_cube_size=15;
end_cube_height=10;
thickness=3;
fiddle=3;
shaft_length=70;
rounding_radius=2;

module holy_end_cup() {
    difference() {
        end_cup();
        translate([-end_cube_size/2-thickness, end_cube_size*0.7, 0]) {
            rotate([0, 90, 0]) {
               cylinder(r=2.5, h=30);
            }
        }
    }
}

module end_cup() {
    translate([0, 0, -end_cube_height/2]) {
        difference() {
            cube([end_cube_size, end_cube_size, end_cube_height]);

            translate([thickness,thickness, -fiddle]) {
                cube([end_cube_size, end_cube_size, end_cube_height+fiddle*2]);
            }
        }
    }
}

module shaft() {
    cube([thickness, shaft_length, end_cube_height], center=true);
}

module end_cups() {
    translate([0, shaft_length/2-thickness, 0]) {
        rotate([0, 0, 65]) end_cup();
    }
    translate([0, -shaft_length/2+thickness, 0]) {
        rotate([0, 0, 235]) holy_end_cup();
    }
}

module body() {
    end_cups();
    shaft();
}

body();

