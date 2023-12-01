/// @description Insert description here
// You can write your code in this editor

#macro VISUAL_TOTAL_PX 14

current = 0

hide = function() { self.visible = false }
show = function() { self.visible = true }

_get_paint_px_count = function() {
	if(is_undefined(self.total)){
		exit
	}
	
	return floor(self.current / self.total * VISUAL_TOTAL_PX)
}

_set_bar_color = function() {
	var _bar_length = self._get_paint_px_count();
	
	var _yellow_threshold = 0.5
	var _red_threshold = 0.75
	
		draw_set_color(c_purple)
	
	if(_bar_length < VISUAL_TOTAL_PX * _yellow_threshold) {
		draw_set_color(c_green)
	} else if(_bar_length < VISUAL_TOTAL_PX * _red_threshold) {
		draw_set_color(c_orange)
	} else {
		draw_set_color(c_red)
	}
}

_draw_bar = function() {
	var _bar_lenght = self._get_paint_px_count()
	
	draw_set_color(c_white)
	draw_rectangle(x + 1, y + 7, x + VISUAL_TOTAL_PX, self.y + 8, false);
	
	if(is_undefined(self.override_set_bar_color)) {
		self._set_bar_color()
	} else {
		self.override_set_bar_color()
	}
	
	draw_rectangle(x + 1, y + 7, x + _bar_lenght, self.y + 8, false)
}











