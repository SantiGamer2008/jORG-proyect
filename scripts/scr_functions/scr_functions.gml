function Unpause(_Surface, _Sound, _Music){
	
	audio_stop_sound(_Music)
	audio_play_sound(_Sound, 1, false)
	audio_resume_all()
	surface_free(_Surface)
	instance_activate_all()
	musicDelay = 0
	
}

function Pause(_Sound, _Music) {
	
	audio_pause_all()
	audio_resume_sound(_Music)
	audio_play_sound(_Sound, 1, false)
	
}