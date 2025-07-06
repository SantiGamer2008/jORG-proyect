//Mover en circulos
dir += rotSpd;

//Get our target positions
var _targetX = xstart + lengthdir_x(radius, dir);
var _targetY = ystart + lengthdir_y(radius, dir);

//Obtener nuestra velodidad en x e y
xVel = _targetX - x;
//xVel = 0;
yVel = _targetY - y;
//yVel = 0;

//Move
x += xVel;
y += yVel;