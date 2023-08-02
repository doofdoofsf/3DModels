/*
 * a mount for a keychain ball compass for paragliding
 */

// https://www.internet-outdoorshop.com/en/399321-hypersonic-compass-ball-3-cm-black/

$fn=120;

sphere_diameter = 29;
cube_width = sphere_diameter*1.3;


module cutout_tool() {
    width = cube_width * 1.5;
    difference() {
        cube([width, width, width/2], center=true);
        translate([0, 0, -cube_width/4]) sphere(cube_width * 0.65);
    }
}


module access_hole() {
    length = sphere_diameter * 2;
    diameter = 10;
    translate([0, 0, sphere_diameter*0.5]) {
       translate([0, 0, -length/2]) {
           cylinder(d=diameter, length);
       }
    }
}


module body() {
    cube_height = sphere_diameter*0.5;

    translate([0, 0, cube_height/2])
        cube([cube_width, cube_width, cube_height], center=true);
}

module ball_depression() {
   translate([0, 0, 2+sphere_diameter/2.0]) {
      sphere(d=sphere_diameter);
   }
}

module mount() {
   difference() {
      body();
      ball_depression();
      access_hole();
   }
}

module rounded_mount() {
    difference() {
        mount();
        translate([0, 0, sphere_diameter * 0.4]) cutout_tool();
    }
}

rounded_mount();
