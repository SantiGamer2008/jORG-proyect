//Perseguir al jugador
if global.rockyFollow {
	
	var target = instance_find(obj_player, 0)
	
	if target != noone {
		
		if target.image_xscale > 0 {
			lookDirection = 1
		} else if target.image_xscale < 0 {
			lookDirection = -1
		}
		
		if isThrowed {
			x += spd * lookDirection
			
			if place_meeting(x, y, obj_wallParent) || place_meeting(x, y, obj_spikes) {
				isThrowed = false
			}
			
		} else {
		
			move_towards_point(target.x - (offsetX * lookDirection), target.y - offsetY, spd)
	
			if point_distance(x, y, target.x - (offsetX * lookDirection), target.y - offsetY) < spd {
			
				x = target.x - (offsetX * lookDirection)
				y = target.y - offsetY
				spd = 0
				baseY = y
		
			} else if target.xSpd != 0 || target.ySpd != 0 {
				spd = 10
			}
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
