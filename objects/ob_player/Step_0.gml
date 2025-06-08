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
	//Salto xd, pero constantemente xd
	yVel = JumpVel;
		
	//Contar el tiempo
	jumpHoldTimer--;
}
	
//Limite de velocidad al caer
if yVel > limitVely {yVel = limitVely;}
	
//Colisiones en Y

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

//Bonk Code XD
/*if yVel < 0
{
	jumpHoldTimer = 0;
}*/

	
//Mover
y += yVel;