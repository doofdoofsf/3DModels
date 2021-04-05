/*
 * A bracket to mount a shower head on in the van
 */

$fn=100;

hole_diameter=27;
wall_thickness=6;
fudge=2;

height=40;
depth=hole_diameter;
width=40;
rounding_sphere_diameter = 2;

bolt_hole_diameter=5.2;
bolt_hole_access_diameter=9.5;

module bolt_hole(z) {
   translate([-fudge, bolt_hole_diameter/2+(width-bolt_hole_diameter)/2, z])
      rotate([0,90,0])
         cylinder(h=wall_thickness+fudge*2, d=bolt_hole_diameter);

   translate([wall_thickness*0.25, bolt_hole_access_diameter/2+(width-bolt_hole_access_diameter)/2, z])
      rotate([0,90,0])
         cylinder(h=wall_thickness*1.2, d=bolt_hole_access_diameter);
}

module shower_cutout() {
   translate([hole_diameter/2+wall_thickness, hole_diameter/2+(width-hole_diameter)/2, -fudge])
      cylinder(h=height+2*fudge, d1=hole_diameter, d2=hole_diameter-2);
}

module main_body() {
   minkowski() {
      cube([depth,width,height]);
      sphere(d=rounding_sphere_diameter);
   }
}

difference() {
   main_body();
   union() {
      shower_cutout();
      bolt_hole(wall_thickness+rounding_sphere_diameter);
      bolt_hole(height-wall_thickness-rounding_sphere_diameter);
   }
}
