if !activated {
	
	//Ejecutar una sola vez
	if saved {
		saved = false
	}
	
	//Verificar si lo esta tocando
	if place_meeting(x, y, obj_player) {
		
		//Cambiar la variable para que deje de ejecutarse
		activated = true
		
		//Cambiar las variables del ultimo checkpoint
		global.lastCheckpointID = id
		global.lastCheckpointX = posX
		global.lastCheckpointY = posY
		
 	}
}

//Si se activa guardar de forma automatica
if activated {
	if !saved {
		saved = true
		saveGame("saveSlot0.ini") 
	}
}

//Si no es igual al ID cambiar a desactivado
if global.lastCheckpointID != id {
	if activated {
		activated = false
	}
}