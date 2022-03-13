$fn=100;

cone_height = 150;
coin_radius = 40;

module coin() {
    cylinder(10, r=coin_radius);
}

module mini_coin() {
    cylinder(1, r=1);
}

module cone() {
    hull() {
        coin();
        translate([-coin_radius,0,-cone_height/2]) mini_coin();
    }
}

module double_cone() {
   cone();
   translate([0, 0, -cone_height]) rotate([0, 180, 180]) cone();
}

double_cone();