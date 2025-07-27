var _targetX = endX, _targetY = endY

if gointToStart {
	_targetX = startX
	_targetY = startY
}

moveX = sign(_targetX - x) * currentSpeed
moveY = sign(_targetY - y) * currentSpeed
