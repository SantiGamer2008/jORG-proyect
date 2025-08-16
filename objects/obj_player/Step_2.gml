var platform = collision_rectangle(x - 10, y, x + 10, y + 2, obj_movingPlatform, true, true)
if platform {
	x += platform.hspeed
	y += platform.vspeed
}