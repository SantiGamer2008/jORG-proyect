// Movimiento semicircular
if (angle > 90) {
    x = center_x + lengthdir_x(radius, angle);
    y = center_y + lengthdir_y(radius, angle);
    angle -= 2; // Velocidad angular
}

// Fade in
if (alpha < 1) {
    alpha += 0.01;
}
