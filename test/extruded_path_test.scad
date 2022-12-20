$fn=100;

module extruded_shape() {
    linear_extrude(height = 50, center = true)
    import("test_looped_path.svg");
}

module centered_shape() {
    translate([-50, -100, 0])
        import("test_looped_path.svg");
}

* for (a = [0 : 30 : 360]) {
    rotate([0, 0, a]) translate([0, 200, 0]) extruded_shape();
}

* linear_extrude(height = 300, center = true, twist=360)
    centered_shape();


rotate_extrude(convexity = 10)
    translate([50, 0, 0])
        import("test_looped_path.svg");

