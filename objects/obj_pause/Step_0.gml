if keyboard_check_pressed(vk_escape) && room != Menu_Room{
	pause = !pause
}

if pause {
	audio_pause_all()
} else {
	surface_free(pauseSurface)
	instance_activate_all()
	audio_resume_all()
}

if keyboard_check_pressed(vk_backspace) && !pause {
	game_restart()
}