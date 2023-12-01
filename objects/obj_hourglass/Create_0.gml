/// @description Insert description here
// You can write your code in this editor

interactible = false;
_max_scale = 2;
_growing = false;

_time_scale = 1;
_time_scale_mod = 2;

_animation_config = {
	max_scale: 1.2,
	min_scale: 0.8,
	step: 0.02,
	grow: 1
}



function slow() {
	self._time_scale  = 1 / self._time_scale_mod
	
}

function fast() {
	self._time_scale = 1 * self._time_scale_mod
}

function reset() {
	self._time_scale = 1
}