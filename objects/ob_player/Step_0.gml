//Obtener Inputs (Teclas etc.)
GetControls();

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
if coyoteSusTimer > 0
{
	coyoteSusTimer--;
} else {
	//Aplicar gravedad
	yVel += grav;
	//Ya no estamos en el suelo
	setOnGround(false)
}
	
//Resetear o preparar las variables de salto
if onGround
{
	jumpCount = 0;
	coyoteJumpTimer = coyoteJumpFrames;
} else {
	coyoteJumpTimer--;
	if jumpCount == 0 && coyoteJumpTimer <= 0 {jumpCount = 1;}
}
	
//Salto
if jumpKeyBuffered && jumpCount < jumpMax
{
	//reset buffer
	jumpKeyBuffered = false;
	jumpKeyBufferTimer = 0;
		
	//Incrementar el numero de saltos
	jumpCount++;
		
	//Colocar el tiempo de mantener salto
	jumpHoldTimer = jumpHoldFrames;
	
	//Decir que ya no estamos en el suelo
	setOnGround(false);
	coyoteJumpTimer = 0;
}

	
//Cortar el salto al soltar el boton
if !jumpKey
{
	jumpHoldTimer = 0;
}
	
//Salto en base de el timer o mantener el boton
if jumpHoldTimer > 0
{
	//Salto xd pero constantemente xd
	yVel = JumpVel;
		
	//Contar el tiempo
	jumpHoldTimer--;
}
	
//Limite de velocidad al caer
if yVel > limitVely {yVel = limitVely;}
	
//Colisiones en Y
var _subPixel = 0.5;
if place_meeting(x, y + yVel, ob_plwall)
{
	//Colision precisa
	var _pixelCheck = _subPixel * sign(yVel);
	while !place_meeting(x, y + _pixelCheck, ob_plwall)
	{
		y += _pixelCheck;
	}
		
	//Bonk Code XD
	if yVel < 0
	{
		jumpHoldTimer = 0;
	}
		
	//poner la velocidad de y en 0
	yVel = 0;
}
	
//Poner si estoy en el suelo
if yVel >= 0 && place_meeting(x, y + 1, ob_plwall)
{
	setOnGround(true);
}
	
//Mover
y += yVel;