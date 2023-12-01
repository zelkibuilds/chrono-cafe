/// @description Insert description here
// You can write your code in this editor

if (self.skip_step) {
	exit
}

if(self.curr_state == CUSTOMER_STATE.SEATING) {
	progress_bar.hide();
	
	//TODO: Break move to chair into two parts and spam movement
	if(self.path_target_instance == noone) {
		self.move_to_chair()
		exit
	}
	
	if(self.x == self.path_target_instance.x && self.y == self.path_target_instance.y) {
		self.curr_state = CUSTOMER_STATE.WAITING;
		self.progress_bar.show();
		self.progress_bar.current = 0;
		self.manager.orders_service.place_random_order(self);
	}
	
	exit
}

if (self.curr_state == CUSTOMER_STATE.WAITING) {
	exit
}

if (self.curr_state == CUSTOMER_STATE.LEAVING) {
	self.move_to_exit();
	
	if(self.x == self.manager.cafe_exit.x && self.y == self.manager.cafe_exit.y) {
		instance_destroy(self.progress_bar);
		instance_destroy(self)
	}
}









