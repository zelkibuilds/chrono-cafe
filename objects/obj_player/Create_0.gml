/// @description Insert description here
// You can write your code in this editor

p_speed = 3;
collision_margin = 4;
_active_hourglass = noone;

/**
	checks for player input and changes hourglass timescale
*/
function poll_distortion_input() {
	if _active_hourglass = noone { exit };
	
	if keyboard_check_pressed(ord("E")) {
		_active_hourglass.fast();
		exit;
	}
	
	if keyboard_check_pressed(ord("Q")) {
		_active_hourglass.slow();
		exit;
	}
	
	if keyboard_check_pressed(vk_space) {
		_active_hourglass.reset();
	}
}