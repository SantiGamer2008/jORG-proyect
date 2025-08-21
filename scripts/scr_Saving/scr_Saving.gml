//Rooms
global.rooms = [
	Menu_Room,
	LevelSelect_Room,
	Test_Room,
	Test_Room2
]

//Checkpoint
global.lastCheckpointID = ""
global.lastCheckpointX = 0
global.lastCheckpointY = 0

//Player
global.loadPlayerPosition = false
global.rockyFollow = true

//Collectibles
global.collect1 = 0
global.collect2 = 0

function newGame(_file) {
	if file_exists(_file) {
		file_delete(_file)
	}
	
	//Player
	global.loadPlayerPosition = false
	global.rockyFollow = true
	
	//Checkpoint
	global.lastCheckpointID = ""
	global.lastCheckpointX = 0
	global.lastCheckpointY = 0
	
	//Collectibles
	global.collect1 = false
	global.collect2 = false
}

function saveGame(_file){
	
	ini_open(_file)
	
	//Player
	ini_write_string("player", "actualRoom", room_get_name(room))
	ini_write_real("player", "rockySeguir", global.rockyFollow)
	
	//Colectibles
	ini_write_real("collectibles", "1", global.collect1)
	ini_write_real("collectibles", "2", global.collect2)
	
	//World
	ini_write_string("world", "lastCheckpoint", string(global.lastCheckpointID))
	ini_write_real("world", "lastcpX", global.lastCheckpointX)
	ini_write_real("world", "lastcpY", global.lastCheckpointY)
	
	ini_close()
	
}

function loadGame(_file){
	
	if file_exists(_file) {
		
		ini_open(_file)
		
		//Player
		var _roomName = ini_read_string("player", "actualRoom", string(LevelSelect_Room))
		var _room = get_room_index_from_name(_roomName)
		
		global.rockyFollow = ini_read_real("player", "rockySeguir", global.rockyFollow)
		
		//Collectibles
		global.collect1 = ini_read_real("collectibles", "1", global.collect1)
		global.collect2 = ini_read_real("collectibles", "2", global.collect2)
		
		//World
		global.lastCheckpointID = ini_read_string("world", "lastCheckpoint", "")
		global.lastCheckpointX = ini_read_real("world", "lastcpX", global.lastCheckpointX)
		global.lastCheckpointY = ini_read_real("world", "lastcpY", global.lastCheckpointY)
		
		ini_close()
		
		if _room != noone { room_goto(_room) }
		
		if _room != LevelSelect_Room {
			global.loadPlayerPosition = true
		}
		
	} else { show_debug_message("No se encontre una partida guardada") }
}

function saveSettings() {
	var _settings = {
		pauseOnUnfocus: global.pauseOnUnfocus
	}

	var _json_text = json_stringify(_settings)

	var _path = "settingsSave.json"
	var _file = file_text_open_write(_path)
	file_text_write_string(_file, _json_text)
	file_text_close(_file)
	
	show_debug_message("Se cambio algo")
	
}

function loadSettings() {
	var _path = "settingsSave.json"
	
	if file_exists(_path) {
		var _file = file_text_open_read(_path)
		var _json_text = ""
		
		while !file_text_eof(_file) {
			_json_text += file_text_read_string(_file)
		}
		
		file_text_close(_file)
		
		var _settings = json_parse(_json_text)
		
		global.pauseOnUnfocus = _settings.pauseOnUnfocus
		
		show_debug_message(string(_settings))
	}
}

function get_room_index_from_name(name) {
    for (var i = 0; i < array_length(global.rooms); i++) {
		var r = global.rooms[i]
        if (room_get_name(r) == name) {
            return r;
        }
    }
    return noone;
}