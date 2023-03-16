$fn = 80;

sphere_diameter = 76.02;

tray_height = 18;
wall_thickness = 7;
base_thickness = 5;
tray_radius = sphere_diameter;
sausage_thickness = tray_height;

module sausage() {
    thickness = tray_height;
    
    hull() {
        length = tray_radius - sausage_thickness/2 - wall_thickness;
        sphere(d = tray_height);
        translate([length, 0, 0])
            sphere(d = tray_height);
    }
}


module sphere_cutout() {
    translate([0, 0, sphere_diameter*0.45]) {
        sphere(d = sphere_diameter);
    }
}

module base_tray() {
        cylinder(h = tray_height, r = tray_radius, center=true);
}

module tray() {
    difference() {
        base_tray();
        #sphere_cutout();
    }
}


module tray_sausage_cutout() {
    for(angle = [0 : 5 : 30]) {
        echo(angle);
        rotate([0, 0, angle]) {
            sausage();
        }
    }
}

difference() {
    tray();
    translate([0, 0, sausage_thickness/2]) tray_sausage_cutout();
}
cylinder(h = tray_height, r = sphere_diameter/2, center = true);
        