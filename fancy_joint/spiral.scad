$fn = 90;

r = 3;
for(a = [0 : 1 : 360 * 2]) {
    d = r + a * 0.03;
    rotate([0, 0, a]) {
        translate([d, 0, 0]) {
            circle(r);
        }
    }
}

