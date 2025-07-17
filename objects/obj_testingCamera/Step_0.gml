//Fullscreen toggle
if keyboard_check_pressed(vk_f11)
{
	window_set_fullscreen(!window_get_fullscreen())
}

//Si no existe el jugador no se ejecutara el codigo
if !instance_exists(obj_player) exit;

//Obtener el tamaño de la camara
var _camWidth = camera_get_view_width(view_camera[0]);
var _camHeight = camera_get_view_height(view_camera[0]);

//Obtener cordenadas del objetivo de la camara
var _camX = obj_player.x - _camWidth/2;
var _camY = obj_player.y - _camHeight/2;

//Restringir la camara a los bordes de la habitacion
_camX = clamp(_camX, 0, room_width - _camWidth);
_camY = clamp(_camY, 0, room_height - _camHeight);

//Establecer cordenadas de la camara
camera_set_view_pos(view_camera[0], _camX, _camY)