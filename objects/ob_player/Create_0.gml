//Custom fuctions para el jugador
function setOnGround(_val = true)
{
	if _val == true
	{
		onGround = true;
		coyoteSusTimer = coyoteSusFrames;
	} else {
		onGround = false;
		myFloorPlat = noone;
		coyoteSusTimer = 0;
	}
}

//Variables del jugador
controlsSetup();

depth = -30

//Movimiento
moveDir = 0;
moveVel = 10;
xVel = 0;
yVel = 0;

//Saltos
grav = 0.9;
gravOnAWall = 0.5
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

//Moving Platforms
myFloorPlat = noone;
moveplatXspd = 0;
moveplatMaxYspd = limitVely;

//Wall Jump
onWall = 0;
xVelWJump = 50;
yVelWJump = -20;
yVelMaxWall = 15;