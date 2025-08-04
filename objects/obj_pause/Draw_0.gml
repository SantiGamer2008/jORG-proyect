//Dinamicamente obtener el ancho y alto del menu
var _new_w = 0
for (var i = 0; i < op_length; i++) {
	var _op_w = string_width(option[menu_level, i])
	_new_w = max(_new_w, _op_w)
}
width = _new_w + op_border * 2
height = op_border * 2 + string_height(option[0, 0]) + (op_length - 1) * op_space

//var cam_w = camera_get_view_width(view_camera[0])
//var cam_h = camera_get_view_height(view_camera[0])

//Saca screenshot de la pantalla
if (pause) {
	if (!surface_exists(pauseSurface)) {
		pauseSurface = surface_create(surface_get_width(application_surface), surface_get_height(application_surface))
		surface_set_target(pauseSurface)
		draw_surface(application_surface, 0, 0)
		surface_reset_target()
		
		instance_deactivate_all(true)
		instance_activate_object(obj_fade)
	}
	//dibuja el screenshot en la pantalla agregando cosas
	draw_surface(pauseSurface, 0, 0)
	
	draw_set_color(c_black)
	draw_set_alpha(0.5)
	draw_rectangle(0, 0, room_width, room_height, false)
	draw_set_alpha(1)
	draw_set_color(c_white)
	
	//Dibujar el fondo del menu
	//draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 0)
	
	draw_set_font(Menu_Font)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	for (var i = 0; i < op_length; i++) {
		var _c = c_white
		if pos == i { _c = c_yellow }
		draw_text_color(x + op_border, y + op_border + op_space * i, option[menu_level, i], _c, _c, _c, _c, 1)
	}
}