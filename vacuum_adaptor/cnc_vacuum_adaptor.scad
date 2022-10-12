// 54mm hole

$fn=10;
wall_thickness = 2;
section_length = 20;

start_int_dia = 36.5;
start_ext_dia = start_int_dia + 2 * wall_thickness;
end_ext_dia = 54;
end_int_dia = end_ext_dia - 2 * wall_thickness;
flange_dia = end_ext_dia * 1.5;

mounting_hole_dia = 5;

module start_tube() {
    difference() {
        cylinder(section_length*1.5, d = start_ext_dia);
        cylinder(section_length*1.5, d = start_int_dia);
    }
}

module middle_tube() {
    difference() {
        cylinder(section_length, d1 = start_ext_dia, d2 = end_ext_dia);
        cylinder(section_length, d1 = start_int_dia, d2 = end_int_dia);
    }
}

module end_flange_hole() {
    translate([33, 0, 0])
    {
        cylinder(wall_thickness*2, d = mounting_hole_dia);
        translate([0, 0, wall_thickness]) #cylinder(wall_thickness, d = mounting_hole_dia*2);
    }
}

module end_flange_holes() {
    angles = [ for (a = [0 : 90 : 360]) a ];
        
        
    for(a = angles) {
        rotate(a) end_flange_hole();
    }
}

module end_flange() {
    difference() {
        cylinder(wall_thickness*2, d = flange_dia);
        cylinder(wall_thickness*2, d = end_int_dia);
    }
}

module adaptor() {
    start_tube();
    translate([0, 0, section_length*1.5]) middle_tube();
    translate([0, 0, section_length*2.5]) end_flange();
}

module holy_adaptor() {
    difference() {
        adaptor();
        translate([0, 0, section_length*2.5]) end_flange_holes();
    }
}
        


holy_adaptor();
    
    

