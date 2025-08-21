var player = instance_nearest(x, y, obj_player)

if player != noone {
	var dist = point_distance(x, y, obj_player.x, obj_player.y)

	if dist < radius {
	
		var dir = point_direction(obj_player.x, obj_player.y, x, y)
	
		obj_player.x += lengthdir_x(force, dir)
		obj_player.ySpd += lengthdir_y(force, dir)
		
		if dist < 15 {
			obj_player.dead = true
		}
	}
}