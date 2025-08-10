depth = -15

grabbed = false

spd = 10

sound = false

switch collect {
	case 0:
		if global.collect1 {
			image_alpha = 0.3
		}
	
	case 1:
		if global.collect2 {
			image_alpha = 0.3
		}
}