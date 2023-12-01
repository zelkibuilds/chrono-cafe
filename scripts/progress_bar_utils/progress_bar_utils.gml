// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function set_bar_above_character(_char, _progress_bar){
	var _bar_vector = { x: _char.x - 8, y: _char.y - 20 }

	_progress_bar.x = _bar_vector.x	
	_progress_bar.y = _bar_vector.y;
}