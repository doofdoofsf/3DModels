/*
 * A draining shower shelf cover
 */

$fn=60;
thickness = 2.5;

shelf_length=300+thickness*2;
shelf_width=115;
shelf_height=10;

number_x_spars = 10;
x_spar_spacing = shelf_length / number_x_spars;

number_y_spars = 4;
y_spar_spacing = shelf_width / number_y_spars;

corner_radius = 12;

foot_length=shelf_length/10;

module overhang_catch() {
   translate([0, 0, -shelf_height+3]) {
      cube([thickness, shelf_width/2, shelf_height], center=true);
   }
}

module overhang_catches() {
   translate([shelf_length/2-thickness/2, 0, 0]) overhang_catch();
   translate([-shelf_length/2+thickness/2, 0, 0]) overhang_catch();
}

module foot() {
   cube([foot_length, thickness, shelf_height/2], center=true);
}

module feet() {
   translate([shelf_length/2-foot_length, shelf_width/2-y_spar_spacing, -shelf_height/2]) foot();
   translate([shelf_length/2-foot_length-3*x_spar_spacing, shelf_width/2-y_spar_spacing, -shelf_height/2]) foot();
   translate([shelf_length/2-foot_length, -shelf_width/2+y_spar_spacing, -shelf_height/2]) foot();
   translate([shelf_length/2-foot_length-3*x_spar_spacing, -shelf_width/2+y_spar_spacing, -shelf_height/2]) foot();
   translate([-shelf_length/2+foot_length, -shelf_width/2+y_spar_spacing, -shelf_height/2]) foot();
   translate([-shelf_length/2+foot_length+3*x_spar_spacing, -shelf_width/2+y_spar_spacing, -shelf_height/2]) foot();
   translate([-shelf_length/2+foot_length, shelf_width/2-y_spar_spacing, -shelf_height/2]) foot();
   translate([-shelf_length/2+foot_length+3*x_spar_spacing, shelf_width/2-y_spar_spacing, -shelf_height/2]) foot();
}

module x_hatch() {
   for(x_offset = [x_spar_spacing : x_spar_spacing : shelf_length-x_spar_spacing]) {
      translate([x_offset-shelf_length/2, 0, 0]) {
         cube([thickness, shelf_width, shelf_height], center=true);
      }
   }
}

module y_hatch() {
   for(y_offset = [y_spar_spacing : y_spar_spacing : shelf_width-y_spar_spacing]) {
      translate([0, y_offset-shelf_width/2, 0]) {
         cube([shelf_length, thickness, shelf_height], center=true);
      }
   }
}

module base_shape(width, length) {
   minkowski() {
      square([length-2*corner_radius, width-2*corner_radius], center=true);
      circle(corner_radius);
   }
}

module base() {
   difference() {
      base_shape(shelf_width, shelf_length);
      base_shape(shelf_width-2*thickness, shelf_length-2*thickness);
   }
}

module body() {
   translate([0, 0, -shelf_height/2]) {
      linear_extrude(shelf_height) {
         base();
      }
   }
   x_hatch();
   y_hatch();
   feet();
   overhang_catches();
}

module half_body() {
   difference() {
      body();
      translate([-shelf_length/2-thickness/2, 0, 0]) {
         cube([shelf_length, shelf_width+10, shelf_height+30], center=true);
      }
   }
}


difference() {
   half_body();
   translate([0, 0, 12]) {
      cube([shelf_length+10, shelf_width+10, 30], center=true);
   }
}
