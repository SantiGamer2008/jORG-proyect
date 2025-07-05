// Movimiento
x += xspd;
y += yspd;

// Rebote instantáneo en los bordes (¡sin suavizado!)
if (x <= 0 || x >= room_width - sprite_width) {
    xspd *= -0.1;
}

if (y <= 0 || y >= room_height - sprite_height) {
    yspd *= -0.1;
}

// Rotación continua visual
image_angle += 0.3; // ajustá si querés más rápido o más lento
