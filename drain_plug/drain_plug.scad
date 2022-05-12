$fn=200;

difference() {
    cylinder(h=40, d2=30.5, d1=28, center=true);
    translate([6, 0, 0]) cylinder(h=50, d=13, center=true); 
}
