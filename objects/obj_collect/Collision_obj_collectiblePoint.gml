switch collect {
	case 0:
		global.collect1 = 1	
		break
	
	case 1: 
		global.collect2 = 1
		break
}

image_index = 2

saveGame("saveSlot0.ini")

instance_destroy(self)