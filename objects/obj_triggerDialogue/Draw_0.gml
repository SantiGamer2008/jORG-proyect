
if isColliding {
	draw_set_font(Menu_Font)
	draw_set_halign(fa_middle)
	draw_set_valign(fa_center)
	draw_set_color(c_white)
	draw_text(obj_player.x, obj_player.y - 32, "Press E to interact")
}