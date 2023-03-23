// http://mkmra2.blogspot.com/2014/08/cnc-cut-wood-joinery.html

$fn = 100;

// s = square cut
// r = round cut
// n = nothing
        
fine = ["n", "n", "r", "s", "r", "n",
        "r", "n", "r", "n", "r", "n", "r", "n", "r", 
        "n", "n", "n", "r", "s"];
        
module joint_cutout(thickness, height, pattern) {
    component_height = height / len(pattern);
    for (i = [ 0 : len(pattern) - 1 ] ) {
        translate([0, i * component_height]) {
            if(pattern[i] == "s") {
                square([thickness, component_height]);
            } else
            if(pattern[i] == "r") {
                hull() {
                    square([thickness, component_height]);
                    translate([0, component_height/2]) {
                        circle(d = component_height);
                    }
                }
            }            
        }
    }
}
