if grabbed {
	var target = instance_find(obj_player, 0)
	
	if target != noone {
		
		move_towards_point(target.x, target.y, spd)
		
		if point_distance(x, y, target.x, target.y) < spd {
			
			x = target.x 
			y = target.y
			
			spd = 0
			
		} else if target.xSpd != 0 || target.ySpd != 0 {
			spd = 10
		}
	}
}