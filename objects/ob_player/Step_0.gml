//Obtener Inputs (Teclas etc.)
GetControls();

var onAWall = place_meeting(x+1, y, ob_plwall) - place_meeting(x-1, y, ob_plwall);

//Movimiento en X
//Direccion
moveDir = rightKey - leftKey;

//Obtener velocidad en X
xVel = moveDir * moveVel;

//Wall Jump
if (onAWall != 0) && (!onGround) && (jumpKey)
{
	xVel = -onAWall * xVelWJump;
	yVel = yVelWJump;
}

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
var gravFinal = grav;
var yVelMaxFinal = limitVely;

if (onAWall != 0) && (yVel > 0)
{
	gravFinal = gravOnAWall;
	yVelMaxFinal = yVelMaxWall;
}
if coyoteSusTimer > 0
{
	coyoteSusTimer--;
} else {
	//Aplicar gravedad
	yVel += gravFinal;
	yVel = clamp(yVel, -yVelMaxFinal, yVelMaxFinal)
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
var _floorIsSolid = false;
if instance_exists(myFloorPlat)
&& (myFloorPlat.object_index == ob_plwall || object_is_ancestor(myFloorPlat.object_index, ob_plwall))
{
	_floorIsSolid = true;
}

if jumpKeyBuffered && jumpCount < jumpMax && (!downKey || _floorIsSolid)
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
	//Salto xd, pero constantemente xd
	yVel = JumpVel;
		
	//Contar el tiempo
	jumpHoldTimer--;
}
	
//Limite de velocidad al caer
if yVel > limitVely {yVel = limitVely;}
	
//Colisiones en Y
var _subPixel = .5;

if yVel < 0 && place_meeting(x, y + yVel, ob_plwall)
{
	var _slopeSlide = false;
	
	if !_slopeSlide
	{
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


		yVel = 0;
	}
}



//Floor Y Collisions (En ingles porque suena mejor XD)

//Verificar un piso solido o semisolido debajo de mi
var _clampYspd = max(0, yVel);
var _list = ds_list_create(); // crear una lista DS para almazenar todos los objetos con los que podremos colisionar
var _array = array_create(0);
array_push(_array, ob_plwall, ob_SemiSolidPlat);

//Hacer la verificacion actual y añadir los objetos a la lista
var _listSize = instance_place_list(x, y+1 + _clampYspd + moveplatMaxYspd, _array, _list, false);

for (var i = 0; i < _listSize; i++)
{
	//Obtener una instancia de obWall o obSemisolid de la lista
	var _listInst = _list[| i];
	
	//Evitar engancharse a la plataforma
	if (_listInst.yVel <= yVel || instance_exists(myFloorPlat))
	&& (_listInst.yVel > 0 || place_meeting(x, y+1 + _clampYspd, _listInst))
	{
			//Devolver solidwall o cualquier semisolidplat que esta debajo del jugador
			if _listInst.object_index == ob_plwall 
			|| object_is_ancestor(_listInst.object_index, ob_plwall) 
			|| floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.yVel)
			{
			//Devolver el piso mas "arriba"
			if !instance_exists(myFloorPlat) 
			|| _listInst.bbox_top + _listInst.yVel <= myFloorPlat.bbox_top + myFloorPlat.yVel
			|| _listInst.bbox_top + _listInst.yVel <= bbox_bottom
			{
				myFloorPlat = _listInst;
			}
		}
	}
}

//Destruir la lista DS para evitar sobrecargar la memoria
ds_list_destroy(_list);

if instance_exists(myFloorPlat) && !place_meeting(x, y + moveplatMaxYspd, myFloorPlat)
{
	myFloorPlat = noone;
}

if instance_exists(myFloorPlat)
{
	var _subPixel = 0.5;
	while !place_meeting(x, y + _subPixel, myFloorPlat) && !place_meeting(x, y, ob_plwall) {y += _subPixel}
	
	//
	if myFloorPlat.object_index == ob_SemiSolidPlat || object_is_ancestor(myFloorPlat.object_index, ob_SemiSolidPlat)
	{
		while place_meeting(x, y, myFloorPlat) {y -= _subPixel}
	}
	
	//
	y = floor(y);
	
	//
	yVel = 0;
	setOnGround(true);
}

if downKey && jumpKeyPressed
{
	if instance_exists(myFloorPlat)
	&& (myFloorPlat.object_index == ob_SemiSolidPlat || object_is_ancestor(myFloorPlat.object_index, ob_SemiSolidPlat))
	{
		var _yCheck = max(1, myFloorPlat.yVel+1)
		if !place_meeting(x, y + _yCheck, ob_plwall)
		{
			y += 1;
			
			yVel = _yCheck-1;
			
			setOnGround(false);
		}
	}
}

//Mover
y += yVel;

//final de las plataformas movibles colisiones y movimiento
// X - moveplatXspd and collision
moveplatXspd = 0;
if instance_exists(myFloorPlat) {moveplatXspd = myFloorPlat.xVel}

if place_meeting(x + moveplatXspd, y, ob_plwall)
{
	var _subPixel = .5;
	var _pixelCheck = _subPixel * sign(moveplatXspd);
	while !place_meeting(x + _pixelCheck, y, ob_plwall)
	{
		x += _pixelCheck;
	}
	
	moveplatXspd = 0;
	
}

x += moveplatXspd;

// Y - Engancharme a mi mismo a myFloorPlat
if instance_exists(myFloorPlat) && (myFloorPlat.yVel != 0 
|| myFloorPlat.object_index == ob_semiSolidMovePlat || object_is_ancestor(myFloorPlat.object_index, ob_semiSolidMovePlat))
{
	//Engancharse al piso de la plataforma
	if !place_meeting(x, myFloorPlat.bbox_top, ob_plwall)
	&& myFloorPlat.bbox_top >= bbox_bottom+moveplatMaxYspd
	{
		y = myFloorPlat.bbox_top;
	}
	
	if myFloorPlat.yVel < 0 && place_meeting(x, y + myFloorPlat.yVel, ob_plwall)
	{
		if myFloorPlat.object_index == ob_SemiSolidPlat || object_is_ancestor(myFloorPlat.object_index, ob_SemiSolidPlat)
		{
			var _subPixel = .25;
			while place_meeting(x, y + myFloorPlat.yVel, ob_plwall) {y += _subPixel; };
			
			while place_meeting(x, y, ob_plwall) {y -= _subPixel; };
			y = round(y);
		}
		setOnGround(false);
	}
}