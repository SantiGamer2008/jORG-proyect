if grabbed {
	var target = instance_find(obj_player, 0)
	
	if target != noone {
		
		move_towards_point(target.x - offsetX, target.y - offsetY, spd)
		
		if point_distance(x, y, target.x - offsetX, target.y - offsetY) < spd {
			
			x = target.x - offsetX
			y = target.y - offsetY
			
			spd = 0
			
		} else if target.xSpd != 0 || target.ySpd != 0 {
			spd = 10
		}
	}
}