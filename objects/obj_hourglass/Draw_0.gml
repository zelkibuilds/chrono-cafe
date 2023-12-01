/// @description Insert description here
// You can write your code in this editor
#region scale_lerp
if self.interactible {
	var _curr_scale = image_xscale; 
		
	if self._animation_config.grow > 0 and _curr_scale >= self._animation_config.max_scale {
		self._animation_config.grow = -1;
	}
	
	if self._animation_config.grow < 0 and _curr_scale <= self._animation_config.min_scale {
		self._animation_config.grow = 1;
	}
	
	image_xscale += self._animation_config.step * self._animation_config.grow;
	image_yscale += self._animation_config.step * self._animation_config.grow;
} else {
	image_xscale = 1;
	image_yscale = 1;
}
#endregion

#region color_tint
if self._time_scale < 1 {
	draw_sprite_ext(spr_hourglass, 0, x, y, image_xscale, image_yscale, 0, c_aqua, 1);
} else if self._time_scale > 1 {
    draw_sprite_ext(spr_hourglass, 0, x, y, image_xscale, image_yscale, 0, c_red, 1);
} else {
	draw_sprite_ext(spr_hourglass, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);
}
#endregion






