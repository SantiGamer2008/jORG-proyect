//get inputs
downKey = keyboard_check_pressed(vk_down) + gamepad_button_check_pressed(0, gp_padd) + keyboard_check_pressed(ord("S"))
downKey = clamp(downKey, 0, 1)

upKey = keyboard_check_pressed(vk_up) + gamepad_button_check_pressed(0, gp_padu) + keyboard_check_pressed(ord("W"))
upKey = clamp(upKey, 0, 1)

acceptKey = keyboard_check_pressed(vk_space) + gamepad_button_check_pressed(0, gp_face1)
acceptKey = clamp(acceptKey, 0, 1)

//Guardar el numero de opciones en el menu actual
op_length = array_length(option[menu_level])

//Moverse atraves del menu
pos += downKey - upKey
if pos >= op_length { pos = 0 }
if pos < 0 { pos = op_length - 1 }

//using the options
if acceptKey {
	
	var _sml = menu_level
	
	switch menu_level {
		
		//Main Menu
		case 0:
			switch pos {
		
				//Start Game
				case 0:
					audio_play_sound(Pl_Start_sound, 5, false); // sonido de clic

					if (audio_is_playing(Menu_Sound2)) {
					    audio_stop_sound(Menu_Sound2);
					}

					room_goto(LevelSelect_Room);

					fade_out = true;
					fade_speed = 0.02; // velocidad de desvanecimiento

					break
	
				//Settings
				case 1: menu_level = 1 break
		
				//Quit Game
				case 2:
					game_end()
					break
			}
			break
		
		//Settings Menu
		case 1:
			switch pos {
				//Window Size
				case 0:
				
					break
					
				//Controls
				case 1:
				
					break
				
				//Windows Focus
				case 2:
					if instance_exists(obj_settings) {
						if obj_settings.pauseOnUnfocus == true { 
							obj_settings.pauseOnUnfocus = false
							option[1, 2] = "Pause On Unfocus"
						} else {
							obj_settings.pauseOnUnfocus = true 
							option[1, 2] = "Not Pause On Unfocus" 
							}
					}
					break
				
				//Back
				case 3: menu_level = 0 break
			}
			break
	}
		//Set position back
		if _sml != menu_level { pos = 0 }
		
		//Correct option length
		op_length = array_length(option[menu_level])
}