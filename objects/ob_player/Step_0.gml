//Obtener Inputs (Teclas etc.)
rightKey = keyboard_check(vk_right)
leftKey = keyboard_check(vk_left)
jumpKeyPressed = keyboard_check_pressed(vk_space);

//Movimiento en X
	//Direccion
	moveDir = rightKey - leftKey;

	//Obtener velocidad en X
	xVel = moveDir * moveVel;

	//Colisiones en X
	var _subPixel = 0.5;

	if place_meeting(x + xVel, y, ob_plwall) 
	{
		var _pixelCheck = _subPixel * sign(xVel);
		while !place_meeting(x + _pixelCheck, y, ob_plwall)
		{
			x += _pixelCheck;
		}
	
		xVel = 0;
	}

	//Mover
	x += xVel;

//Movimiento en Y

	//Gravedad
	yVel += grav;
	
	//Salto
	if jumpKeyPressed && place_meeting(x, y + 1, ob_plwall)
	{
		yVel = JumpVel;
	}
	
	//Colisiones en Y
	var _subPixel = 0.5;
	if place_meeting(x, y + yVel, ob_plwall)
	{
		var _pixelCheck = _subPixel * sign(yVel);
		while !place_meeting(x, y + _pixelCheck, ob_plwall)
		{
			y += _pixelCheck;
		}
		
		yVel = 0;
	}
	
	//Mover
	y += yVel;