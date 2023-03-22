$fn = 80;

top_width = 180.0;
top_length = 200.0;
thickness = 19.05;

tab_count = 7;
tab_height = thickness*1.3;
tab_depth = 13;
tab_width = thickness * 0.7;
tab_length = top_length / (tab_count*2-1);

rr = 4;

module top() {
    cube([top_length, top_width, thickness], center = true);
}   

module tab() {
    cube([tab_length, tab_width, thickness]);
}

module rounded_tab() {
    hull() {
        cube([tab_length, tab_width - rr, tab_height]);
        translate([rr, tab_width - rr, 0]) cylinder(h=tab_height, r=rr);
        translate([tab_length - rr, tab_width - rr, 0]) cylinder(h=tab_height, r=rr);
    }
}

module tabs() {
    for(x = [tab_length : tab_length * 2 : top_length - tab_length]) {
        translate([x, 0, 0]) {
            rounded_tab();
        }
    }
}

module cut_top() {
    difference() {
        top();
        union() {
            translate([-top_length/2, -top_width/2, -tab_height/2]) tabs();
            translate([-top_length/2, top_width/2, tab_height/2]) rotate([180, 0, 0]) tabs();
        }
    }
}

//cut_top();
projection() cut_top();

