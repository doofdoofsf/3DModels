/*
 * fence post top
 */



$fn=120;

outside_length = 152;
outside_height = 44.5;

inside_length = 138;
inside_depth = 10;

module base_cube() {
    cube([outside_length, outside_length, outside_height], center = true);
}

module cutout() {
    cube([inside_length, inside_length, inside_depth], center = true);
}

module cutout_cube() {
    difference() {
        base_cube();
        translate([0, 0, (outside_height - inside_depth)/2])
            cutout();
    }
}

module half_cube() {
    difference() {
        cutout_cube();
        translate([0,outside_length/2, 0]) base_cube();
    }
}

half_cube();