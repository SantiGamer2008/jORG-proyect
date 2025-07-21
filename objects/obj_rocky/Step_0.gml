//Perseguir al jugador
if Seguir {
	var target = instance_find(obj_player, 0)

	if target != noone {
	
		move_towards_point(target.x - 42, target.y - 32, spd)
	
		if point_distance(x, y, target.x - 42, target.y - 32) < spd {
		
			x = target.x - 42
			y = target.y - 32
			spd = 0
			baseY = y
		
		} else if target.xSpd != 0 || target.ySpd != 0 {
		
			spd = 10
			move_towards_point(target.x - 42, target.y - 32, spd)
		
		}
	}

	//Hacer como que flota si esta quieto
	if spd = 0 {
	
		y = baseY + sin(timer) * amplitud
		timer += ySpd
	
	}
	
} else {
	
	y = baseY + sin(timer) * amplitud
	timer += ySpd
	
}

