/// @description Insert description here
// You can write your code in this editor

var _dt = delta_time / 1_000_000;

if(!self.skip_order_delay && CHOOSE_ORDER_DELAY_SECONDS > self.order_delay_seconds_counter) {
	self.order_delay_seconds_counter += _dt
	self.show_choosing_icon = true;
} else {
	self.show_choosing_icon = false;
}
















