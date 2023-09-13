$fn=100;
wall_thickness = 2.8;
section_length = 34;
end_taper = 2.0;
middle_shrink = 0.8;
end_scale = 1.4;

start_int_dia = 95.4;
start_ext_dia = start_int_dia + 2 * wall_thickness;

end_ext_dia = 99.0;
end_int_dia = end_ext_dia - 2 * wall_thickness;


module start_tube() {
    difference() {
        cylinder(section_length, d = start_ext_dia);
        cylinder(section_length, d = start_int_dia);
    }
}

module middle_tube() {
    difference() {
        cylinder(section_length * middle_shrink, d1 = start_ext_dia, d2 = end_ext_dia);
        cylinder(section_length * middle_shrink, d1 = start_int_dia, d2 = end_int_dia);
    }
}

module end_tube() {
    difference() {
        cylinder(section_length*end_scale, d1 = end_ext_dia, d2 = end_ext_dia-end_taper);
        cylinder(section_length*end_scale, d1 = end_int_dia, d2 = end_int_dia-end_taper);
    }
}

module adaptor() {
    start_tube();
    translate([0, 0, section_length]) middle_tube();
    translate([0, 0, section_length*(1+middle_shrink)]) end_tube();    
}


adaptor();
    
    

