$fn=120;
wall_thickness = 5;
section_length = 40;

ring_length = 10;
ring_offset = 5;

int_dia = 91.5;
ext_dia = int_dia + 2 * wall_thickness;


module tube() {
    difference() {
        cylinder(section_length, d = ext_dia);
        cylinder(section_length, d = int_dia);
    }
}

module ring() {
    difference() {
        cylinder(ring_length, d = ext_dia);
        cylinder(ring_length, d = ext_dia - wall_thickness/2);
    }
}
  
module end() {
    difference() {
        tube();
        translate([0, 0, ring_offset]) ring();
    }
}

end();


    
    

