// http://mkmra2.blogspot.com/2014/08/cnc-cut-wood-joinery.html

$fn = 100;

// s = square cut
// r = round cut
// n = nothing
        
fine = ["n", "n", "r", "s", "r", "n",
        "r", "n", "r", "n", "r", "n", "r", "n", "r", 
        "n", "n", "n", "r", "s"];
        
x_fine = ["n", "n", "r", "s", "r", "n",
        "r", "n", "r", "n", "r", "n", "r", "n", "r",
        "n", "r", "n", "r", "n", "r",
        "n", "n", "n", "r", "s"];
        
clean = ["r", "n", "r", "n", "r", "n", "r", "n", "r",
        "n", "r", "n", "r", "n", "r", "n",
        "r", "n", "r", "n", "r", "n", "r", "n", "r",
        "n", "r", "n"];
        
clean_ends = ["n", "n", "n", "r", "n", "r", "n", "r", "n", "r",
        "n", "r", "n", "r", "n", "r", "n",
        "r", "n", "r", "n", "r", "n", "r", "n", "r",
        "n", "r", "s", "r"]; 
 
        
module joint_cutout(thickness, height, pattern) {
    component_height = height / len(pattern);
    rounding_diameter = component_height;
    
    echo("rounding diameter (inches): ", rounding_diameter/25.4);
    for (i = [ 0 : len(pattern) - 1 ] ) {
        translate([0, i * component_height]) {
            if(pattern[i] == "s") {
                square([thickness, component_height]);
            } else
            if(pattern[i] == "r") {
                hull() {
                    square([thickness, component_height]);
                    translate([0, rounding_diameter/2]) {
                        circle(d = rounding_diameter);
                    }
                }
            }            
        }
    }
}
