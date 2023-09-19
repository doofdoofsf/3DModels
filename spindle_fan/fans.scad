//import("./er20chipfan.stl");

xcount = 1;
ycount = 1;
size = 36;

    
for (x = [0 : size : size*xcount-1]) {
    for (y = [0 : size : size*ycount-1]) {
        echo(x, y);
        translate([x, y, 0]) {
            import("er11chipfan.stl");
        }
    }
}
