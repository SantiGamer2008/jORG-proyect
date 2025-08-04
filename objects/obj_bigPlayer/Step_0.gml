//Obtener Inputs (Teclas etc.)
GetControls();

if !canMove exit

var OnGround = place_meeting(x, y + 1, obj_wallParent)

//Si muere hacer esto
if dead {
	loadGame("saveSlot0.ini")
	show_debug_message("Murio")
}


//Movimiento en X
//Direccion
var moveDir = rightKey - leftKey;
	
	//Esto hace que mire hacia otro lado el sprite
	if (moveDir != 0) { image_xscale = moveDir + 0.5 * moveDir }
		
	xSpd = moveDir * spd;

//Colisiones en X
if place_meeting(x + xSpd, y, obj_wallParent) {
	
	while (!place_meeting(x + sign(xSpd), y, obj_wallParent)) {
		x += sign(xSpd)
	}
	
	xSpd = 0;
}

x += xSpd;

//Movimiento en Y
//Gravedad
if coyoteSusTimer > 0 {
	
	coyoteSusTimer--;
} else {
	
	if ySpd > limitYSpd { ySpd = limitYSpd }
	//Aplicar gravedad
	ySpd += grav;
}
	
//Resetear o preparar las variables de salto
if OnGround {
	
	jumpCount = 0;
	coyoteJumpTimer = coyoteJumpFrames;
	coyoteSusTimer = coyoteSusFrames;
	
} else {
	coyoteJumpTimer--;
	if jumpCount == 0 && coyoteJumpTimer <= 0 { jumpCount = 1; }
}

//Salto
//Dar margen de error al saltar
if jumpKeyBuffered && !downKey && jumpCount < jumpMax {
		
	//reiniciar el buffer
	jumpKeyBuffered = false;
	jumpKeyBufferTimer = 0;
		
	//Incrementar el numero de saltos
	jumpCount++;
		
	//Colocar el tiempo de mantener salto
	jumpHoldTimer = jumpHoldFrames;

	//Decir que ya no estamos en el suelo
	coyoteJumpTimer = 0;
	coyoteSusTimer = 0;
}
	
//Cortar el salto al soltar el boton
if !jumpKey {
	
	jumpHoldTimer = 0;
}

//Saltar en base de el tiempo mantenido del boton
if jumpHoldTimer > 0 {
	//Aplicar el salto
	ySpd = JumpSpd;

	//Contar el tiempo
	jumpHoldTimer--;
}

//Colisiones en Y
if place_meeting(x, y + ySpd, obj_wallParent) {
	
	while (!place_meeting(x, y  + sign(ySpd), obj_wallParent)) {
		y += sign(ySpd)
	}
	
	/*Bonk Code XD 
	(Cuando el personaje choca contra un techo deja de mantener el salto)*/
	if ySpd < 0 {
		
		jumpHoldTimer = 0;
	}
	
	ySpd = 0;
}

y += ySpd

switch animState {
	case "idle":
		if moveDir != 0 {
			animState = "starting"
			sprite_index = spr_bigPlayerStatingWalk
			}
		break
	
	case "stating":
		if moveDir == 0 {
			animState = "idle"
			sprite_index = spr_bigPlayerIdle
		} 
		break
		
	case "walk":
		if moveDir == 0 {
			animState = "idle"
			sprite_index = spr_bigPlayerIdle
		}
		break
}