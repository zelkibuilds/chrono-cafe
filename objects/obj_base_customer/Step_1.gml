/// @description Insert description here
// You can write your code in this editor

if(self.curr_state == CUSTOMER_STATE.QUEUED) {
	if(self.check_frames_counter > 0) {
		self.check_frames_counter = self.check_frames_counter - 1;
		self.skip_step = true;
	}
	
	var _dt = delta_time / 1_000_000
	
	self.wait_for_seat_seconds_counter += _dt;
	self.progress_bar.current = self.wait_for_seat_seconds_counter;
	
	if(self.wait_for_seat_seconds_counter > WAIT_FOR_SEAT_SECONDS_LIMIT) {
		self.manager.leave_cafe(self);	
	}
	
	exit
}

if(self.curr_state == CUSTOMER_STATE.WAITING) {

	var _dt = delta_time / 1_000_000
	
	if(!self.has_chosen_order) {
		self.wait_for_order_choice_seconds_counter += _dt
		self.has_chosen_order = self.wait_for_order_choice_seconds_counter >= CHOOSE_ORDER_DELAY_SECONDS
		self.progress_bar.total = WAIT_FOR_ORDER_SECONDS_LIMIT
		exit
	}
	
	self.wait_for_order_seconds_counter += _dt;
	self.progress_bar.current = self.wait_for_order_seconds_counter;
	
	if(self.wait_for_order_seconds_counter > WAIT_FOR_ORDER_SECONDS_LIMIT) {
		
		if(self.has_chosen_order) {
			self.manager.orders_service.cancel_order(self)
		}
		
		self.manager.orders_service.hide_order_bubble(self)
		self.manager.leave_cafe(self);	
	}
	
	exit
}






