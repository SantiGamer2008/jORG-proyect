depth = -15

grabbed = false

spd = 10

offsetX = 50
offsetY = 128

sound = false

switch collect {
	case 0:
		if global.collect1 = 1 {
			image_alpha = 0.3
		}
	
	case 1:
		if global.collect2 = 1 {
			image_alpha = 0.3
		}
}