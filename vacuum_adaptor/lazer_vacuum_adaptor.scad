$fn=100;
wall_thickness = 2;
section_length = 40;
end_taper = 1.5;

start_ext_dia = 101.0;
start_int_dia = start_ext_dia - 2 * wall_thickness;

end_ext_dia = 72.5;
end_int_dia = end_ext_dia - 2 * wall_thickness;


module start_tube() {
    difference() {
        cylinder(section_length, d1 = start_ext_dia - end_taper, d2 = start_ext_dia);
        cylinder(section_length, d1 = start_int_dia - end_taper, d2 = start_int_dia);
    }
}

module middle_tube() {
    difference() {
        cylinder(section_length, d1 = start_ext_dia, d2 = end_ext_dia);
        cylinder(section_length, d1 = start_int_dia, d2 = end_int_dia);
    }
}

module end_tube() {
    difference() {
        cylinder(section_length, d1 = end_ext_dia, d2 = end_ext_dia-end_taper);
        cylinder(section_length, d1 = end_int_dia, d2 = end_int_dia-end_taper);
    }
}

module adaptor() {
    start_tube();
    translate([0, 0, section_length]) middle_tube();
    translate([0, 0, section_length*2]) end_tube();    
}


adaptor();
    
    

