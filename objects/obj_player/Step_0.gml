//Obtener Inputs (Teclas etc.)
GetControls();


var OnGround = place_meeting(x, y + 1, obj_wallParent) || onOneWay
var OnWall = place_meeting(x - 5, y, obj_wall) - place_meeting(x + 5, y, obj_wall);
var IgnoreOneWay = false

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
if OnGround {
	
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

//Bloquear el salto del personaje si la variable es igual o menor a 0
if movementTimerLock <= 0
	
	if OnWall != 0 && jumpKeyPressed && !OnGround{
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

//Dejar caer de la plataforma OneWay
if downKey && jumpKeyPressed && actualPlatform != noone && !place_meeting(x, y + 1, obj_wallParent) {
	
	y += 2
	IgnoreOneWay = true
	actualPlatform = noone
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

//SemiSolid Platform/One-Way Platform
if ySpd >= 0 && !IgnoreOneWay {
	var plat = instance_place(x, y + ySpd, obj_semiSolidPlat)
	
	if plat != noone {
	
		if bbox_bottom <= plat.bbox_top + 1 {
			
			if place_meeting(x, y + ySpd, obj_semiSolidPlat) {
				while !place_meeting(x, y + sign(ySpd), obj_semiSolidPlat) {
					y += sign(ySpd);
				}
				ySpd = 0;
				actualPlatform = plat
			}
		}
	}
}

if !IgnoreOneWay {
	var plat_check = instance_place(x, y + 1, obj_semiSolidPlat)
	
	if plat_check != noone && bbox_bottom <= plat_check.bbox_top + 1 {
		actualPlatform = plat_check
	} else if !place_meeting(x, y + 1, obj_wallParent) { actualPlatform = noone }
	
	if plat_check != noone && bbox_bottom <= plat_check.bbox_top + 1 { onOneWay = true } 
	else { onOneWay = false }

}



y += ySpd;