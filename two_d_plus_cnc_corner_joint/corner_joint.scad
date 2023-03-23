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
        echo(i, pattern[i]);
        translate([0, i * component_height]) {
            if(pattern[i] == "s") {
                square([thickness, component_height]);
            } else
            if(pattern[i] == "r") {
                hull() {
                    square([thickness, component_height]);
                    translate([-component_height, component_height/2]) {
                        circle(d = component_height);
                    }
                }
            }            
        }
    }
}

module joint(thickness, width, height, pattern) {
    difference() {
        translate([-width+thickness, 0]) square([width, height]);
        joint_cutout(thickness, height, pattern);
    }
}

joint(19.05, 100, 145, fine);