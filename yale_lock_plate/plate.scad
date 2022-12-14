$fn=90;

lock_height = 93.0;
lock_width = 63.5;

margin_y = 27.0;
margin_x = 8;

plate_height = lock_height + 2 * margin_y;
plate_width = lock_width + 2 * margin_x;

hole_diameter = 53.6;
hole_top_to_lock_top = 29;

thickness = 1.5;
rounding_radius = 10;

hole_offset = hole_top_to_lock_top - (lock_height/2 - hole_diameter/2);
echo(lock_height/2 - hole_diameter/2, hole_offset);

module plate() {
    minkowski() {
        cube([plate_width - 2*rounding_radius, 
        plate_height - 2*rounding_radius, 
        thickness], center = true);
        cylinder(r = rounding_radius, h = thickness/1000);
    }
}

module lock_cutout() {
    translate([0, hole_offset, 0])
        cylinder(thickness*5, d = hole_diameter, center=true);
}

module finished_plate() {
    difference() {
        plate();
        lock_cutout();
    }
}

finished_plate();
