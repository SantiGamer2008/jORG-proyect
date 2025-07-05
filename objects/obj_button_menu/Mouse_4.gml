switch accion {
	case 0:
		audio_play_sound(Start_sound, 5, false); // sonido de clic

		if (audio_is_playing(Menu_sound)) {
		    audio_stop_sound(Menu_sound);
		}

		room_goto(Test_Room);

		fade_out = true;
		fade_speed = 0.02; // velocidad de desvanecimiento

		break
	case 1:
		game_end()
		break
}