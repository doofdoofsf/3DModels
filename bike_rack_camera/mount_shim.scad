sheet_width = 40;
sheet_depth = 100;
sheet_height = 1;
roof_angle = 145;
shim_length = 61;
shim_width = 34;
    
module angled_sheet() {
    rotate([0, 90-roof_angle/2, 0]) {
        translate([0, -sheet_depth/2, 0]) {
            cube([sheet_width, sheet_depth, sheet_height]);
        }
    }
}

module angled_roof() {
    angled_sheet();
    mirror([1, 0, 0]) angled_sheet();
}

module angled_cutout() {
    hull() {
        angled_roof();
        translate([0, 0, -20]) {
            cube([sheet_width*2, sheet_depth, sheet_height], center = true);
        }
    }
}

module shim() {
    difference() {
        cube([shim_width, shim_length, 27], center = true);
        translate([0, 0, 3]) rotate([0, 0, 90]) angled_cutout();
    }
}

//shim();