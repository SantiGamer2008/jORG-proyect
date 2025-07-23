//get inputs
downKey = keyboard_check_pressed(vk_down) + gamepad_button_check_pressed(0, gp_padd) + keyboard_check_pressed(ord("S"))
downKey = clamp(downKey, 0, 1)

upKey = keyboard_check_pressed(vk_up) + gamepad_button_check_pressed(0, gp_padu) + keyboard_check_pressed(ord("W"))
upKey = clamp(upKey, 0, 1)

acceptKey = keyboard_check_pressed(vk_space) + gamepad_button_check_pressed(0, gp_face1) + keyboard_check_pressed(vk_enter)
acceptKey = clamp(acceptKey, 0, 1)

//Guardar el numero de opciones en el menu actual
op_length = array_length(option[menu_level])

//Moverse atraves del menu
pos += downKey - upKey
if pos >= op_length { pos = 0 }
if pos < 0 { pos = op_length - 1 }

if instance_exists(obj_settings) {
	if global.pauseOnUnfocus == true {
		option[2, 1] = "Not Pause On Unfocus" 
	} else {
		option[2, 1] = "Pause On Unfocus"
	}
}

//using the options
if acceptKey {
	
	var _sml = menu_level
	
	switch menu_level {
		
//------------------Main Menu------------------
		case 0:
			switch pos {
		
				//Start Game
				case 0: menu_level = 3 break
	
				//Settings
				case 1: menu_level = 1 break
		
				//Quit Game
				case 2:
					game_end()
					break
			}
			break
		
//------------------Settings Menu------------------
		case 1:
			switch pos {
				//Window Size
				case 0: menu_level = 2 break
					
				//Controls
				case 1:
				
					break
				
				//Sound
				case 2:
					
					break
				
				//Back Main Menu
				case 3: menu_level = 0 break
			}
			break
			//End Settings Menu
		
//------------------Windows Menu------------------
		case 2:
			switch pos {
				
				//Window Size
				case 0:
							
					break
						
				//Windows Focus
				case 1:
					if instance_exists(obj_settings) {
						if global.pauseOnUnfocus == true {
							global.pauseOnUnfocus = false
						} else {
							global.pauseOnUnfocus = true  
						}
					}
					break
					//End case 1
				
				//Back Settings Menu
				case 2: 
				menu_level = 1 
				saveSettings()
				break
				
			}
			break
		
//------------------Start Game Menu------------------
		case 3:
			switch pos {
				
				//Nueva partida
				case 0:
					audio_play_sound(Pl_Start_sound, 5, false); // sonido de clic

					if (audio_is_playing(Menu_Sound2)) {
					    audio_stop_sound(Menu_Sound2);
					}
					
					newGame("saveSlot0.ini")
					room_goto(LevelSelect_Room)
					
					break
				
				//Cargar partida
				case 1:
					audio_play_sound(Pl_Start_sound, 5, false); // sonido de clic

					if (audio_is_playing(Menu_Sound2)) {
					    audio_stop_sound(Menu_Sound2);
					}
					
					loadGame(saveFile)
					break
				
				//Back Main Menu
				case 2: menu_level = 0 break
				
			}
			break
	}
		//Set position back
		if _sml != menu_level { pos = 0 }
		
		//Correct option length
		op_length = array_length(option[menu_level])
}