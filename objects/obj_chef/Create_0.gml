/// @description Insert description here
// You can write your code in this editor

#macro PREPARE_ORDER_SECONDS 5

_manager = instance_find(obj_manager, 0)
_orders_service = _manager.orders_service;
_progress_bar = instance_create_layer(x, y, "Floating_UI" ,obj_progress_bar, { total: PREPARE_ORDER_SECONDS, override_set_bar_color: function() { draw_set_color(c_aqua) } });
_progress_bar.hide();

_order_bubble = undefined
_error_bubble = undefined

current_order = undefined
prepare_current_order_seconds_counter = 0;

pick_order = function() {
	if(!is_undefined(self.current_order) || !self._orders_service.has_queued_orders()) {
		return
	}
	
	self.current_order = self._orders_service.take_order_from_queue();
}

prepare_order = function() {
	if(is_undefined(self.current_order)) {
		self._progress_bar.hide()
		exit
	}
	
	if(is_undefined(self._order_bubble)) {
		if(!is_undefined(self._error_bubble)) {
			instance_destroy(self._error_bubble)
		}
		
		self._order_bubble = instance_create_layer(self.x, self.y - 30, "Floating_UI", obj_order_bubble, { order_icon: self.current_order.order.item_spr, skip_order_delay: true})
	}
	
	self._progress_bar.show();
	
	var _dt = get_delta_seconds()
	
	self.prepare_current_order_seconds_counter += _dt
	self._progress_bar.current += _dt;
	
	if(self.prepare_current_order_seconds_counter >= PREPARE_ORDER_SECONDS) {
		self.spawn_order(self.current_order)
		self.reset_order_state()
		self._progress_bar.hide();
		self._progress_bar.current = 0;
		instance_destroy(self._order_bubble)
		self._order_bubble = undefined;
	}
}

reset_order_state = function() {
	self.current_order = undefined
	self.prepare_current_order_seconds_counter = 0
}

spawn_order = function(_order) {
	show_debug_message("Order ready: " + string(_order))
}

cancel_order = function(_order) {
	if(_order != self.current_order) {
		return;
	}
	
	self.reset_order_state()
	
	if(!is_undefined(self._order_bubble)) {
		instance_destroy(self._order_bubble)
	}
	
	self._error_bubble = instance_create_layer(self.x, self.y - 30, "Floating_UI", obj_order_bubble, { order_icon: spr_error, skip_order_delay: true})
}











