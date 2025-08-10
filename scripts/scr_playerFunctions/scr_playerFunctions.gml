function controlsSetup()
{
	bufferTime = 10
	
	jumpKeyBuffered = 0
	jumpKeyBufferTimer = 0
}

function GetControls()
{
	//Inputs de direccion
	rightKey = keyboard_check(vk_right) + gamepad_button_check(0, gp_padr) + keyboard_check(ord("D"))
	rightKey = clamp(rightKey, 0, 1)
	
	leftKey = keyboard_check(vk_left) + gamepad_button_check(0, gp_padl) + keyboard_check(ord("A") )
	leftKey = clamp(leftKey, 0, 1)
	
	downKey = keyboard_check(vk_down) + gamepad_button_check(0, gp_padd) + keyboard_check(ord("S"))
	downKey = clamp(downKey, 0, 1)
	
	upKey = keyboard_check(vk_up) + gamepad_button_check(0, gp_padu) + keyboard_check(ord("W"))
	upKey = clamp(upKey, 0, 1)
	
	//Inputs de accion
	jumpKeyPressed = keyboard_check_pressed(vk_space) + gamepad_button_check_pressed(0, gp_face1)
	jumpKeyPressed = clamp(jumpKeyPressed, 0, 1)
	
	jumpKey = keyboard_check(vk_space) + gamepad_button_check(0, gp_face1)
	jumpKey = clamp(jumpKey, 0, 1)
	
	grabKey = keyboard_check(vk_shift) + gamepad_button_check(0, gp_face3)
	grabKey = clamp(grabKey, 0, 1)
	
	throwRocky = device_mouse_check_button_pressed(0, mb_left) + gamepad_button_check_pressed(0, gp_shoulderl) + keyboard_check_pressed(ord("C"))
	throwRocky = clamp(throwRocky, 0, 1)
	
	//Salto Buffer
	if jumpKeyPressed
	{
		jumpKeyBufferTimer = bufferTime
	}
	if jumpKeyBufferTimer > 0
	{
		jumpKeyBuffered = 1;
		jumpKeyBufferTimer--
	} else {
		jumpKeyBuffered = 0
	}
}

function GetMenuControls() {
	pauseKey = keyboard_check_pressed(vk_escape) + gamepad_button_check_pressed(0, gp_start)
	pauseKey = clamp(pauseKey, 0, 1)
	
	downKey = keyboard_check_pressed(vk_down) + gamepad_button_check_pressed(0, gp_padd) + keyboard_check_pressed(ord("S"))
	downKey = clamp(downKey, 0, 1)

	upKey = keyboard_check_pressed(vk_up) + gamepad_button_check_pressed(0, gp_padu) + keyboard_check_pressed(ord("W"))
	upKey = clamp(upKey, 0, 1)

	acceptKey = keyboard_check_pressed(vk_space) + gamepad_button_check_pressed(0, gp_face1) + keyboard_check_pressed(vk_enter)
	acceptKey = clamp(acceptKey, 0, 1)
}