//Obtener Inputs (Teclas etc.)
GetControls();

if !canMove exit

var OnGround = place_meeting(x, y + 1, obj_wallParent) || onSemiSolid
var OnWall = place_meeting(x - 5, y, obj_wall) - place_meeting(x + 5, y, obj_wall);

movementTimerLock = max(movementTimerLock - 1, 0)

//Si muere hacer esto
if dead {
	loadGame("saveSlot0.ini")
	show_debug_message("Murio")
}


//Movimiento en X
//Direccion
var moveDir = rightKey - leftKey;

//Bloquear el movimiento del personaje si la variable es igual o menor a 0
if movementTimerLock <= 0 {	
	
	//Esto hace que mire hacia otro lado el sprite
	if (moveDir != 0) { image_xscale = moveDir * 3}

	xSpd = moveDir * spd;
}

//Pared Escalable
if place_meeting(x, y, obj_climbableWall) {
	
	if grabKey {
		if !Isclimbing { ySpd = 0 }
		Isclimbing = true

	} else { Isclimbing = false }
	
} else { Isclimbing = false }

if Isclimbing {
	if xSpd > limitXSpdClimbingLeft || limitXSpdClimbingRight { 
		
		xSpd = moveDir * limitXSpdClimbingRight
	}
}

//Colisiones en X
if place_meeting(x + xSpd, y, obj_wallParent) {
	
	while (!place_meeting(x + sign(xSpd), y, obj_wallParent)) {
		x += sign(xSpd)
	}
	
	xSpd = 0;
}

/*var _movingPlatformX = instance_place(x + xSpd, y, obj_movingPlatform)

if _movingPlatformX != noone && bbox_left <= _movingPlatformX.bbox_right + 1 {
		xSpd += _movingPlatformX.moveX
} else if _movingPlatformX != noone && bbox_right >= _movingPlatformX.bbox_left - 1 {
		xSpd += _movingPlatformX.moveX
}*/

x += xSpd;

//Movimiento en Y
//Gravedad
if coyoteSusTimer > 0 {
	
	coyoteSusTimer--;
} else if (OnWall != 0) { ySpd = min(ySpd + 1, 5) }

else {
	
	if ySpd > limitYSpd { ySpd = limitYSpd }
	//Aplicar gravedad
	ySpd += grav;
}
	
//Resetear o preparar las variables de salto
if OnGround {
	
	jumpCount = 0;
	coyoteJumpTimer = coyoteJumpFrames;
	coyoteSusTimer = coyoteSusFrames;
	IgnoreOneWay = false
	
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
if downKey && jumpKeyPressed && myFloorPlat != noone && !place_meeting(x, y + 1, obj_wallParent) && !Isclimbing {
	
	ySpd += 2
	IgnoreOneWay = true
	myFloorPlat = noone
	
}

//Escalando
if Isclimbing {

	if upKey {
			
		if ySpd > limitYSpdClimbingUp { ySpd = limitYSpdClimbingUp }
		ySpd -= 1
		
	} else if downKey {
			
		if ySpd > limitYSpdClimbingDown { ySpd = limitYSpdClimbingDown }
		ySpd += 1
			
	} else { ySpd = 0 }
	
}
//Colisiones en Y

//Collision de Plataformas Movible
/*var _movingPlatformY = instance_place(x, y + max(1, ySpd), obj_movingPlatform)

if _movingPlatformY != noone && bbox_bottom <= _movingPlatformY.bbox_top + 1 {
	if ySpd > 0 {
		while !place_meeting(x, y + sign(ySpd), obj_movingPlatform) {
			y += sign(ySpd)
		}
		ySpd = 0
	}
		x += _movingPlatformY.moveX
		y += _movingPlatformY.moveY
}*/

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

//SemiSolid Platform
if ySpd >= 0 && !IgnoreOneWay {
	var _plat = instance_place(x, y + ySpd, obj_semiSolidPlat)
	
	if _plat != noone {
	
		if bbox_bottom <= _plat.bbox_top + 1 {
			
			if place_meeting(x, y + ySpd, obj_semiSolidPlat) {
				while !place_meeting(x, y + sign(ySpd), obj_semiSolidPlat) {
					y += sign(ySpd);
				}
				
				ySpd = 0;
				myFloorPlat = _plat
				
			}
		}
	}
}

if instance_exists(myFloorPlat) {
	if myFloorPlat.object_index == obj_hotFloor {
			
		if place_meeting(x, y + 1, obj_hotFloor) {
			if hotTimer < hotTime {
					
				hotTimer++
					
			} else {
				
				ySpd = JumpSpd
					
			}	
		}
	}
} else {
	if hotTimer <= 0 {
		hotTimer = 0
	} else {
		hotTimer--
	}
}

if !IgnoreOneWay {
	var _plat_check = instance_place(x, y + 1, obj_semiSolidPlat)
	
	if _plat_check != noone && bbox_bottom <= _plat_check.bbox_top + 1 {
		myFloorPlat = _plat_check
	} else if !place_meeting(x, y + 1, obj_wallParent) { myFloorPlat = noone }
	
	if _plat_check != noone && bbox_bottom <= _plat_check.bbox_top + 1 { onSemiSolid = true } 
	else { onSemiSolid = false }

}

y += ySpd

switch animState {
	case "idle":
		if moveDir != 0 {
			animState = "walk"
			sprite_index = spr_playerWalk
			}
		break
		
	case "walk":
		if moveDir == 0 {
			animState = "idle"
			sprite_index = spr_playerIdle
		}
		break
}