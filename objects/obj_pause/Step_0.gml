//se reproduce cada frame mientras esta apretando el boton
if keyboard_check_pressed(vk_escape) && room != Menu_Room {
	pause = !pause
	
	if pause {
		audio_pause_all()
		audio_resume_sound(Pause_Menu_sound)
		audio_play_sound(Pl_jensenk_pauseon, 1, false)
	
	} else {
		audio_stop_sound(Pause_Menu_sound)
		audio_play_sound(Pl_jensenk_pauseoff, 1, false)
		audio_resume_all()
		surface_free(pauseSurface)
		instance_activate_all()
		musicDelay = 0
	}
}

if keyboard_check_pressed(vk_backspace) && !pause {
	game_restart();
}

//Se reproduce cada frame
if pause {
	musicDelay++
	if musicDelay == musicDelayMax {
		audio_play_sound(Pause_Menu_sound, 1, true)
	}
}