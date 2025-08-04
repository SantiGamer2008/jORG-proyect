switch collect {
	case 0:
		global.collect1 = true	
		break
	
	case 1: 
		global.collect2 = true
		break
}

image_index = 2

saveGame("saveSlot0.ini")

instance_destroy(self)