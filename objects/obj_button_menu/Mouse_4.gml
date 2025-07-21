switch accion {
	case 0:
		audio_play_sound(Pl_Start_sound, 5, false); // sonido de clic

		if (audio_is_playing(Menu_Sound2)) {
		    audio_stop_sound(Menu_Sound2);
		}

		room_goto(LevelSelect_Room);

		fade_out = true;
		fade_speed = 0.02; // velocidad de desvanecimiento

		break
	case 1:
		
		break
	case 2:
		game_end()
		break
}