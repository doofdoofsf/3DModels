/*
 * a sewing jig for ozone brake lines
 */

$fn=200;

jig_width=33;
border=10;

slot_width=1.2;
slot_length=100;
jig_thickness=1.2;

module jig() {
   cube([jig_width, slot_length+2*border, jig_thickness]);
}

module slot() {
   translate([jig_width/2-slot_width/2, border, -1]) {
      cube([slot_width, slot_length, jig_thickness+2]);
   }
}

difference() {
   jig();
   slot();
}
