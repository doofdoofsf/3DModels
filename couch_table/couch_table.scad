$fn = 80;

top_width = 180.0;
top_length = 200.0;
thickness = 19.05;

tab_count = 10;
tab_depth = 13;
tab_width = thickness;
tab_length = top_length / (tab_count*2-1);

module top() {
    cube([top_length, top_width, thickness]);
}

module tabs() {
    for(x = [tab_length : tab_length * 2 : top_length - tab_length]) {
        translate([x, 0, 0]) {
            cube([tab_length, tab_width, thickness]);
        }
    }
}

difference() {
    top();
    tabs();
}

