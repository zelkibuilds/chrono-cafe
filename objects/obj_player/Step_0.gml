/// @description Insert description here
// You can write your code in this editor

#region movement

var _move_x = 0;
var _move_y = 0;

if (keyboard_check(vk_right) or keyboard_check(ord("D"))) and place_free(x + collision_margin, y) {
	_move_x = 1;
}

if (keyboard_check(vk_left) or keyboard_check(ord("A"))) and place_free(x - collision_margin, y) {
	_move_x = -1;
}

if (keyboard_check(vk_up) or keyboard_check(ord("W"))) and place_free(x, y - collision_margin) {
	_move_y = -1;
}

if (keyboard_check(vk_down) or keyboard_check(ord("S"))) and place_free(x, y + collision_margin) {
	_move_y = 1;
}

// Normalize the vector if it's not zero
if (_move_x != 0 || _move_y != 0) {
    var _len = point_distance(0, 0, _move_x, _move_y);
    _move_x = (_move_x / _len);
    _move_y = (_move_y / _len);
}

// Apply movement

x += _move_x * p_speed;
y += _move_y * p_speed;

x = clamp(x, 8, room_width - 8);
y = clamp(y, 8, room_height - 8);

#endregion

#region hourglass
if place_meeting(x, y, obj_hourglass_collision) {
	var _hourglass_collision_instance = instance_place(x, y, obj_hourglass_collision);
    if _hourglass_collision_instance != noone {
		_active_hourglass = _hourglass_collision_instance._hourglass;
		_active_hourglass.interactible = true;
    }
} else {
	if _active_hourglass != noone and _active_hourglass.object_index == obj_hourglass {
		_active_hourglass.interactible = false;
		_active_hourglass = noone;
	}
}

poll_distortion_input();

#endregion