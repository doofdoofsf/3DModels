/*
 * A bracket to mount a phone mount in the van on
 */

slot_height = 77;
slot_width = 13.5;

wall_thickness = 2.5;
bracket_width = 60;
bracket_height = slot_height + (2 * wall_thickness);
bracket_thickness = 21.5;
bracket_leg_width = 10;
bracket_top_height = 4;
bracket_back_leg_shorten = 20;
bracket_back_height = bracket_height - bracket_back_leg_shorten;

cutout_width = bracket_width + 1; 
cutout_height = bracket_height - bracket_top_height;
cutout_thickness = bracket_thickness - 2  * wall_thickness;
cutout_cylinder_diameter = bracket_thickness - 2 * wall_thickness;
cutout_y_offset = (bracket_thickness - cutout_thickness)/2;

slot_depth = 55;


module phone_box_back_cutout()
{
   cutout_height = slot_height*0.65;

   translate([bracket_width-slot_width-wall_thickness*2, slot_depth/1.98, cutout_height + (slot_height - cutout_height)/2])
     rotate([0, 90, -20])
        minkowski() {
           $fn=50;
           cube([cutout_height, slot_depth/2, wall_thickness*3]);
	   sphere(3);
        }
}

module phone_box_cutout()
{
   lip_height = bracket_height / 15;
   translate([(bracket_width-slot_width)/2-2*wall_thickness, bracket_thickness/1.45, wall_thickness])
     rotate([0, 0, -20])
        cube([wall_thickness*2, slot_depth+wall_thickness, slot_height-lip_height]);
}

module phone_box()
{
   translate([(bracket_width-slot_width)/2-wall_thickness, bracket_thickness/1.5, 0])
     rotate([0, 0, -20])
        cube([slot_width+2*wall_thickness, slot_depth, slot_height+2*wall_thickness]);
}

module phone_slot()
{
   translate([(bracket_width-slot_width)/2, bracket_thickness/1.5, wall_thickness])
     rotate([0, 0, -20])
        cube([slot_width, slot_depth+10, slot_height]);
}

module cube_with_rounded_top()
{
   union()
   {
      rotate ([0, 90, 0])
         translate([0, bracket_thickness/2, 0]) 
            cylinder (h=bracket_width, d=bracket_thickness);
      cube([bracket_width, bracket_thickness, bracket_height]);
      phone_box();
   }
}

difference() 
{
   difference()
   {
      cube_with_rounded_top();
      phone_slot();
      phone_box_cutout();
      phone_box_back_cutout();
   }
      
   union() /* cutout with rounded top */
      translate([0, cutout_y_offset, bracket_top_height]) 
         cube([cutout_width, cutout_thickness, cutout_height]);
      translate([0, bracket_thickness/2, bracket_top_height])
         rotate ([0, 90, 0]) 
            cylinder (h=bracket_width, d=cutout_cylinder_diameter);

   /* shorten back */
   translate([0, 0, bracket_height - bracket_back_leg_shorten])
      cube([bracket_width, wall_thickness, bracket_back_leg_shorten]);

}
