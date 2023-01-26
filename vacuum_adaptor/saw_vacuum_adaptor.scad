$fn=100;
wall_thickness = 2;
section_length = 20;
end_taper = 1.5;

start_int_dia = 36.5;
start_ext_dia = start_int_dia + 2 * wall_thickness;
end_ext_dia = 59.5;
end_int_dia = end_ext_dia - 2 * wall_thickness;


module start_tube() {
    difference() {
        cylinder(section_length, d = start_ext_dia);
        cylinder(section_length, d = start_int_dia);
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
        cylinder(section_length*1.5, d1 = end_ext_dia, d2 = end_ext_dia-end_taper);
        cylinder(section_length*1.5, d1 = end_int_dia, d2 = end_int_dia-end_taper);
    }
}

module adaptor() {
    start_tube();
    translate([0, 0, section_length]) middle_tube();
    translate([0, 0, section_length*2]) end_tube();    
}


adaptor();
    
    

