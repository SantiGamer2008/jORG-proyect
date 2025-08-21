var interactKey = keyboard_check_pressed(ord("E")) + gamepad_button_check_pressed(0 ,gp_face3)
interactKey = clamp(interactKey, 0, 1)


if place_meeting(x, y, obj_player) {
	
	isColliding = true
	
	if interactKey {
		show_debug_message("Hola :D")
	}
	
} else { isColliding = false }