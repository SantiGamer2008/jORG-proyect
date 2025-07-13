x += moveX
y += moveY

if gointToStart && point_distance(x, y, startX, startY) < currentSpeed {
	gointToStart = false
	currentSpeed = 0
	alarm[0] = waitTime
	
} else if !gointToStart && point_distance(x, y, endX, endY) < currentSpeed {
	gointToStart = true
	currentSpeed = 0
	alarm[0] = waitTime
}