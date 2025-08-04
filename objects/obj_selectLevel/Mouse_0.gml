if instance_exists(obj_fade)  {
	obj_fade.fadeIn = layer_sequence_create("Fade", room_width / 2, room_height / 2, FadeIn)
	obj_fade.fadeOut = FadeOut
	obj_fade.Room = level
}