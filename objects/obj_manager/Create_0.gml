/// @description Insert description here
// You can write your code in this editor

randomize()

free_chairs = []
occupied_chairs = [];
customer_seating_queue = ds_queue_create()
cafe_exit = instance_find(obj_exit, 0);

customer_spawner = instance_create_layer(0, 0, "Characters", obj_customer_spawner)
orders_service = instance_create_layer(0,0, "Characters", obj_orders_service)

register_chair = function(_chair_instance) {	
	if(_chair_instance == noone) exit
	
	array_push(self.free_chairs, _chair_instance);
}

register_customer = function (_customer_instance) {
	if(_customer_instance == noone) exit
	
	ds_queue_enqueue(self.customer_seating_queue, _customer_instance)
}

take_seat = function () {
	if(array_length(self.free_chairs) == 0) {
		exit
	}
	
	return array_shift(self.free_chairs);
}

seat_customer = function() {
	var _customer = ds_queue_dequeue(self.customer_seating_queue);
	
	_customer.curr_state = CUSTOMER_STATE.SEATING
}

leave_cafe = function(_customer, _satisfied = false) {
	if(self.cafe_exit == noone) {
		exit
	}
	
	_customer.move_to_exit();
}