hole_width = 228;
hole_height = 100;
hole_depth = 13;

ext_flange_size = 8;
thickness = 3;
fin_height = sqrt(2 * hole_depth * hole_depth);

external_width = hole_width + 2 * ext_flange_size;
external_height = hole_height + 2 * ext_flange_size;

echo(external_width/25.4, external_height/25.4); 

internal_width = hole_width - 2 * ext_flange_size;
internal_height = hole_height - 2 * ext_flange_size;

flange_width = 40; 
flange_height = 40; 


module base_plate() {
    difference() {
        cube([external_width, external_height, thickness], center = true);
        cube([internal_width, internal_height, thickness+1], center = true);
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
}


module blanking_plate() {
    width = external_width/2 + flange_width/2;
    height = external_height/2 + flange_height/2;
    
    x_offset = -external_width/2 + width/2 - flange_width;
    y_offset = -external_height/2 + height/2 - flange_height;
    
    translate([x_offset, y_offset, 0]) 
        cube([width, height, thickness], center = true);
}

module cutout_blanking_plate() {
    difference() {
        blanking_plate();
        cover();
    }
}

//cover();
#cutout_blanking_plate();