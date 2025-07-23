if keyboard_check_pressed(vk_backspace) && !pause {
	game_restart()
}

windowFocus = window_has_focus()

//Si la instancia obj no pausa existe devolver y no hacer nada
if instance_exists(obj_noPausa) exit

//Pausar al desenfocar el juego
if instance_exists(obj_settings) {
	if global.pauseOnUnfocus == true {
		if !windowFocus { pause = true }
	}
}

//Pausa XD
if keyboard_check_pressed(vk_escape){
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

//Se reproduce cada frame
if pause {
	musicDelay++
	if musicDelay == musicDelayMax {
		audio_play_sound(Pause_Menu_sound, 1, true)
	}
}