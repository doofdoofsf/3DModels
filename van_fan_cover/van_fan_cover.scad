hole_width = 228;
hole_height = 100;
hole_depth = 13;

ext_flange_size = 8;
thickness = 3;
fin_height = 0.8*sqrt(2 * hole_depth * hole_depth);

external_width = hole_width + 2 * ext_flange_size;
external_height = hole_height + 2 * ext_flange_size;

internal_width = hole_width - 2 * ext_flange_size;
internal_height = hole_height - 2 * ext_flange_size;

show_cover = true;
show_blanking_plate = true;

module plate(thickness = thickness) {
    cube([external_width, external_height, thickness], center = true);
}

module base_plate() {
    difference() {
        plate();
        cube([internal_width, internal_height, thickness+1], center = true);
    }
}

module support() {
    translate([0, 0, fin_height/2 - thickness]) {
        rotate([0, 90, 0]) {
            cube([fin_height * 0.6, internal_height * 1.1, thickness], center=true);
        }
    }
}

module fin() {
    offset = sqrt((fin_height * fin_height)/2)/2;
    translate([0, 0, offset]) {
        rotate([45, 0, 0]) {
            cube([internal_width+2*thickness, fin_height, thickness], center = true);
        }
    }
}

module fins() {
    num_fins = 7;
    fin_spacing = hole_height / (num_fins + 1);
    
    for(y = [fin_spacing : fin_spacing : hole_height - fin_spacing]) {
        translate([0, y - hole_height/2, 0]) fin();
    }
}

module cover() {
    base_plate();
    fins();
    support();
}


module blanking_plate() {
    offset = 30;
    width = external_width;
    height = external_height+offset;
    difference() {
        translate([-external_width/2+width/2-offset, 
                   -external_height/2+height/2-offset, 0]) {
            cube([width, height, thickness], center = true);;
        }
        plate(thickness+1);
    }
}

if (show_cover) #cover();

if (show_blanking_plate) blanking_plate();