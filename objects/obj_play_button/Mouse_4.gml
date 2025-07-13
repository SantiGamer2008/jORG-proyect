// Inherit the parent event
event_inherited();

audio_play_sound(Pl_Start_sound, 5, false); // sonido de clic

if (audio_is_playing(Pl_Menu_sound)) {
    audio_stop_sound(Pl_Menu_sound);
}

room_goto(Test_Room);

fade_out = true;
fade_speed = 0.02; // velocidad de desvanecimiento
