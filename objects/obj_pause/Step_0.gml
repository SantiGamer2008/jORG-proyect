GetMenuControls()

// Fullscreen toggle
if keyboard_check_pressed(vk_f11) {
    window_set_fullscreen(!window_get_fullscreen());
}

//Reset Game (TEMPORAL)
if keyboard_check_pressed(vk_backspace) && !pause {
	game_restart()
}

windowFocus = window_has_focus()

//Si la instancia obj no pausa existe devolver y no hacer nada
if instance_exists(obj_noPausa) exit

//Pausar al desenfocar el juego
if global.pauseOnUnfocus == true {
		
	option[2, 1] = "Not Pause On Unfocus" 
		
	if !windowFocus { pause = true }
	
} else { option[2, 1] = "Pause On Unfocus" }
	
//Guardar el numero de opciones en el menu actual
op_length = array_length(option[menu_level])

//Moverse atraves del menu
pos += downKey - upKey
if pos >= op_length { pos = 0 }
if pos < 0 { pos = op_length - 1 }

if pause {
	//using the options
	if acceptKey {
	
		var _sml = menu_level
	
		switch menu_level {
		
	//------------------Main Menu------------------
			case 0:
				switch pos {
		
					//Continue
					case 0:  
						pause = false
						Unpause(pauseSurface, Pl_jensenk_pauseoff, Pause_Menu_sound)
						break
	
					//Settings
					case 1: menu_level = 1 break
				
					//Main Menu
					case 2:
						Unpause(pauseSurface, Pl_jensenk_pauseoff, Pause_Menu_sound)
						saveGame(saveFile)
						room_goto(Menu_Room)
						
						break
				
					//Quit Game
					case 3:
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
						if global.pauseOnUnfocus == true {
							global.pauseOnUnfocus = false
						} else {
							global.pauseOnUnfocus = true  
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
		}
	
		//Set position back
		if _sml != menu_level { pos = 0 }
		
		//Correct option length
		op_length = array_length(option[menu_level])
	
	}
}

//Pausa XD
if pauseKey {
	pause = !pause
	
	pos = 0
	menu_level = 0
	
	if pause {
		Pause(Pl_jensenk_pauseon, Pause_Menu_sound)
	} else {
		Unpause(pauseSurface, Pl_jensenk_pauseoff, Pause_Menu_sound)
	}
}

//Se reproduce cada frame
if pause {
	musicDelay++
	if musicDelay == musicDelayMax {
		audio_play_sound(Pause_Menu_sound, 1, true)
	}
}