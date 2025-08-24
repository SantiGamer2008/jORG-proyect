//Variables del jugador
controlsSetup();

//Profundidad del objeto (Mientras mas chico sea mas cerca)
depth = -30;

//Movimiento
spd = 10;
xSpd = 0;
ySpd = 0;

//Gravedad
grav = 0.9;
limitYSpd = 20;

//Saltos
JumpSpd = -14;
jumpMax = 1;
jumpCount = 0;
jumpHoldTimer = 0;
jumpHoldFrames = 20;

//Coyote time Start
//Tiempo de suspension
coyoteSusFrames = 2;
coyoteSusTimer = 0;

//Tiempo de salto al caer
coyoteJumpFrames = 10;
coyoteJumpTimer = 0;
//Coyote time End

//SemiSolidPlatform
onSemiSolid = false
myFloorPlat = noone
IgnoreOneWay = false

//HotFloor
hotTime = 192
hotTimer = 0

//Wall Jump
wallJumpVertSpd = -18;
wallJumpHorzSpd = 12;

movementTimerLock = 0;

//Climbable Wall
Isclimbing = false
limitYSpdClimbingUp = -5
limitYSpdClimbingDown = 5
limitXSpdClimbingLeft = -5
limitXSpdClimbingRight = 5

//Transicion de la camara
canMove = true

//Otros
dead = false

ammo = 1

canThrow = false

animState = "idle"