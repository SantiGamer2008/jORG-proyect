angle = 180; // Empezamos a la izquierda
radius = 200; // Radio del movimiento circular
center_x = 640; // Centro horizontal de la curva
center_y = 400; // Centro vertical

alpha = 0; // Opacidad inicial

if (!audio_is_playing(Menu_sound)) {
    audio_play_sound(Menu_sound, 1, true); // loop
}
