
var centerX = x - sprite_xoffset + (sprite_width / 2)
var centerY = y - sprite_yoffset + (sprite_height / 2)

// Dibujar el botón normalmente
draw_self();

//Cambiar el color del texto si el mouse esta tocando
draw_set_color(mouseTocando ? c_yellow : c_white);

// Cambiar la fuente a Menu_Font
draw_set_font(Menu_Font);

// Alinear el texto al centro (horizontal y vertical)
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Dibujar el texto del botón centrado en la posición del objeto
draw_text(centerX, centerY, text);

// Restaurar alineación (opcional si otros objetos también dibujan texto)
draw_set_halign(fa_left);
draw_set_valign(fa_top);
