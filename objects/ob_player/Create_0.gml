//Custom fuctions para el jugador
function setOnGround(_val = true)
{
	if _val == true
	{
		onGround = true;
		coyoteSusTimer = coyoteSusFrames;
	} else {
		onGround = false;
		coyoteSusTimer = 0;
	}
}

//Variables del jugador
controlsSetup();

//Movimiento
moveDir = 0;
moveVel = 10;
xVel = 0;
yVel = 0;

//Saltos
grav = 0.9;
limitVely = 20;
JumpVel = -14;
jumpMax = 1;
jumpCount = 0;
jumpHoldTimer = 0;
jumpHoldFrames = 20;
onGround = true;

//Coyote time
//Tiempo de suspension
coyoteSusFrames = 2;
coyoteSusTimer = 0;

//Tiempo de salto al caer
coyoteJumpFrames = 10;
coyoteJumpTimer = 0;
