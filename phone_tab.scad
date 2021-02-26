/*
 * a tab for my phone case
 */

thickness = 1;

stalk_width = 7;
stalk_length = 1;

tab_width = 40;
tab_length = 60;

loop_radius = 8;
loophole_radius = loop_radius - 3;

module loophole()
{
   translate([0, tab_width / 2, tab_length + stalk_length + loop_radius])
      rotate([0, 90, 0])
         # cylinder(h=thickness, r=loophole_radius);
}

module loop()
{
   translate([0, tab_width / 2, tab_length + stalk_length + loop_radius])
      rotate([0, 90, 0])
         cylinder(h=thickness, r=loop_radius);
}

module loop_stalk()
{
   translate([0, (tab_width - stalk_width) / 2, tab_length])
      cube([thickness, stalk_width, stalk_length]);
}

module tab()
{
   cube([thickness, tab_width, tab_length]);
}

difference() {
   hull() {
      loop();
      loop_stalk();
   }
   loophole();
}

tab();
