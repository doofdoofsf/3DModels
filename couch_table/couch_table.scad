$fn = 80;

top_width = 180.0;
top_length = 200.0;
thickness = 19.05;

side_height = 130;

tab_count = 5;
tab_height = thickness*1.3;
tab_depth = 13;
tab_width = thickness*0.8;
tab_length = top_length / (tab_count*2-1);

show_top_projection = false;
show_top = true;
show_side = false;

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

module side() {
    translate([0, -top_width/2+thickness/2, -side_height/2+thickness/2]) cube([top_length, thickness, side_height], center = true);
}

module cut_side() {
    difference() {
        side();
        cut_top();
    }
}

if(show_top) cut_top();
if(show_side) translate([0, 0, side_height/2]) rotate([90, 0, 0]) cut_side();
if(show_top_projection) projection() cut_top();

