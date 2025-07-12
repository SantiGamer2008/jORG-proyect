var cam_w = camera_get_view_width(view_camera[0])
var cam_h = camera_get_view_height(view_camera[0])

if (pause) {
	if (!surface_exists(pauseSurface)) {
		pauseSurface = surface_create(surface_get_width(application_surface), surface_get_height(application_surface))
		surface_set_target(pauseSurface)
		draw_surface(application_surface, 0, 0)
		surface_reset_target()
		
		instance_deactivate_all(true)
	}
	
	draw_surface(pauseSurface, 0, 0)
	
	draw_set_color(c_black)
	draw_set_alpha(0.5)
	draw_rectangle(0, 0, room_width, room_height, false)
	draw_set_alpha(1)
	draw_set_color(c_white)
	
	draw_set_font(Menu_Font)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(cam_w/2, cam_h/2, "Paused")
}