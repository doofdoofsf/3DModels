module tile_polygon() {
    points = [[0, 0], [0, 1], [sqrt(3)/4, 3/4], [sqrt(3)/4, 1/4], [sqrt(3)/2, 0], [sqrt(3)/2, -1/2]];
    polygon(points);
}

module draw_tile(tile_rotation, color) {
    rotate([0, 0, tile_rotation]) color(color) tile_polygon();
}
        

module draw_tile_grid(tile_rotation, x_count, y_count, color) {        
    for(x = [0 : 1 : x_count - 1]) {
        even_x = x % 2 == 0;

        for(y = [0 : 1 : y_count - 1]) {
            y_offset = (x % 2 == 0) ? 0 : 3/4;
            translate([x * 3 * (sqrt(3) / 4), y_offset + (1.5 * y) + 0])
               draw_tile(tile_rotation, color);          
        }
    }
}

module draw_tile_circle(num_circles, tile_rotation, color) {
    scale([scale, scale]) draw_tile(tile_rotation, color);
    for(circle = [1 : 1 : num_circles]) {
        for(angle = [90 : 60 : 360 + 90]) {
            rotate([0, 0, angle]) {
                translate([1.5*scale * circle, 0, 0]) {
                    rotate([0, 0, -angle])
                        scale([scale, scale])
                            draw_tile(tile_rotation, color);
                }
            }
        }
    }
}

color("#999999") rotate([0, 0, 30]) circle(300, $fn=6);

scale = 10;
num_circles = 1;
scale([scale, scale]) draw_tile_circle(num_circles, 0, "#dddcd9"); 
scale([scale, scale]) draw_tile_circle(num_circles, 120, "#58504f"); 
scale([scale, scale]) draw_tile_circle(num_circles, 240, "#b8b6b0"); 


module grid() {
    x_scale = 10;
    y_scale = 8.5;

    x_count = 9;
    y_count = 9;


    scale([x_scale, y_scale]) draw_tile_grid(0, x_count, y_count, "#dddcd9");
    scale([x_scale, y_scale]) draw_tile_grid(240, x_count, y_count, "#58504f");
    scale([x_scale, y_scale]) draw_tile_grid(120, x_count, y_count, "#b8b6b0");
}




//grid();

//color("#58504f") square(100, 100);

