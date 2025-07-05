//Obtener Inputs (Teclas etc.)
GetControls();

var onGround = place_meeting(x, y + 1, obj_wallParent);
var OnWall = place_meeting(x - 5, y, obj_wall) - place_meeting(x + 5, y, obj_wall);

movementTimerLock = max(movementTimerLock - 1, 0)

//Movimiento en X
//Direccion
var moveDir = rightKey - leftKey;

//Bloquear el movimiento del personaje si la variable es igual o menor a 0
if movementTimerLock <= 0 {	
	
	/*Esto hace que mire hacia otro lado el sprite
	if (moveDir != 0) { image_xscale = moveDir }*/

	xSpd = moveDir * spd;
}

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
} else if (OnWall != 0) { ySpd = min(ySpd + 1, 5) }

else {
	//Aplicar gravedad
	ySpd += grav;
}
	
//Resetear o preparar las variables de salto
if (onGround) {
	
	jumpCount = 0;
	coyoteJumpTimer = coyoteJumpFrames;
	coyoteSusTimer = coyoteSusFrames;
	
} else if (OnWall != 0) {
	//image_xscale = OnWall;
	
} else {
	coyoteJumpTimer--;
	if jumpCount == 0 && coyoteJumpTimer <= 0 { jumpCount = 1; }
}

//Salto
//Dar margen de error al saltar
if jumpKeyBuffered && jumpCount < jumpMax {
		
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

//Bloquear el salto del personaje si la variable es igual o menor a 0
if movementTimerLock <= 0
	
	if OnWall != 0 && jumpKeyPressed && !onGround {
		//Aplicar el salto en pared
		ySpd = wallJumpVertSpd
		xSpd = OnWall * wallJumpHorzSpd
		movementTimerLock = 10
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

y += ySpd;