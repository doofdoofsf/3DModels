pi = 3.14159265358979;
e = 2.71828182845904;

$fn = 80;

base_width = 90;
base_depth = 13;
z_undersize = 9.5;
//grid_size = 200;
grid_size = 70;

ripple_depth = 42;
plug_diameter = 15;

ripples = 5;
range = ripples * pi;
x_range = [-range, +range];
y_range = x_range;

shaft_x = 12.5;
shaft_y = 10;

function z(x,y) = ripple_depth*cos(180*sqrt(x*x+y*y)/pi)/sqrt(100+x*x+y*y);

module uncut_base() {
    cube([base_width/2, base_width/2, base_depth]);
}

module ripples() {
    3dplot(
        x_range,
        y_range,
        [grid_size,grid_size],
        -z_undersize,
        [base_width,base_width]);
        
}

module platform() {
    ripples();
    shaft_base();
}

module shaft_base() {
    base_depth = 8.2;
    translate([0, 0, base_depth/2]) cylinder(d=37, base_depth*1.08);
}

module shaft_cut() {
    shaft_z = 40;
    translate([0, 0, shaft_z/2]) {
        cube([shaft_x, shaft_y, shaft_z], center=true);
    }    
}

module plug_hole() {
}

module body() {
    difference() {
        platform();
        shaft_cut();
    }
}

body();
//#uncut_base();

// ---------------------------



// OpenSCAD trig functions use degrees rather than radians
function rad2deg(a) = a * 180 / pi;

// Our NxM grid is NxM cubes, each cube split into 2 upright prisms
prism_faces_1 = [ [3,2,5],[4,0,1], [0,2,1],[2,3,1], [1,3,4],[3,5,4], [5,2,4],[2,0,4] ];
prism_faces_2 = [[4,5,1],[2,0,3], [5,4,2],[2,3,5], [4,1,0],[0,2,4], [1,5,3],[3,0,1]];

// 3dplot -- the 3d surface generator
//
// x_range -- 2-tuple [x_min, x_max], the minimum and maximum x values
// y_range -- 2-tuple [y_min, y_max], the minimum and maximum y values
//    grid -- 2-tuple [grid_x, grid_y] indicating the number of grid cells
//              along the x and y axes
//   z_min -- Minimum expected z-value; used to bound the underside of the surface
//    dims -- 2-tuple [x_length, y_length], the physical dimensions in millimeters

module 3dplot(x_range=[-10, +10], y_range=[-10,10], grid=[50,50], z_min=-5, dims=[80,80])
{
    dx = ( x_range[1] - x_range[0] ) / grid[0];
    dy = ( y_range[1] - y_range[0] ) / grid[1];

    // The translation moves the object so that its center is at (x,y)=(0,0)
    // and the underside rests on the plane z=0

    scale([dims[0]/(max(x_range[1],x_range[0])-min(x_range[0],x_range[1])),
           dims[1]/(max(y_range[1],y_range[0])-min(y_range[0],y_range[1])),1])
    translate([-(x_range[0]+x_range[1])/2, -(y_range[0]+y_range[1])/2, -z_min])
    union()
    {
        for ( x = [x_range[0] : dx  : x_range[1]] )
        {
            for ( y = [y_range[0] : dy : y_range[1]] )
            {
                polyhedron(points=[[x,y,z_min], [x+dx,y,z_min], [x,y,z(x,y)], [x+dx,y,z(x+dx,y)],
                                   [x+dx,y+dy,z_min], [x+dx,y+dy,z(x+dx,y+dy)]],
                           triangles=prism_faces_1);
                polyhedron(points=[[x,y,z_min], [x,y,z(x,y)], [x,y+dy,z_min], [x+dx,y+dy,z_min],
                                   [x,y+dy,z(x,y+dy)], [x+dx,y+dy,z(x+dx,y+dy)]],
                           triangles=prism_faces_2);
            }
        }
    }
}

