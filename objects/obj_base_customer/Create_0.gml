/// @description Insert description here
// You can write your code in this editor

#region state
#macro CHECK_INTERVAL_FRAMES 60
#macro WAIT_FOR_SEAT_SECONDS_LIMIT 5
#macro CHOOSE_ORDER_DELAY_SECONDS 5
#macro WAIT_FOR_ORDER_SECONDS_LIMIT 3

enum CUSTOMER_STATE {
	QUEUED,
	SEATING,
	WAITING,
	EATING,
	LEAVING
}

manager = instance_find(obj_manager, 0);

progress_bar = instance_create_layer(x, y + 5, "Floating_UI", obj_progress_bar, {
	total: WAIT_FOR_SEAT_SECONDS_LIMIT
})

path = path_add()
path_target_instance = noone;
move_speed = 1

curr_state = CUSTOMER_STATE.QUEUED;
check_frames_counter = random(CHECK_INTERVAL_FRAMES);

wait_for_seat_seconds_counter = 0;
wait_for_order_choice_seconds_counter = 0;
wait_for_order_seconds_counter = 0;

has_chosen_order = false;

skip_step = true;

#endregion

image_xscale = -1

manager.register_customer(self);

move_to_chair = function() {
 if(array_length(manager.free_chairs) == 0) {
	return false
 }
 
 var _chair_instance = manager.take_seat();
 path_target_instance = _chair_instance;
 
 if(mp_potential_path(path, _chair_instance.x, _chair_instance.y, move_speed, 2, false)) {
	path_start(path, move_speed, path_action_stop, 0)
	return true
 } else {
	return false
 }
}

move_to_exit = function() {
	var _is_path_cleared = mp_potential_path(self.path, manager.cafe_exit.x, manager.cafe_exit.y, self.move_speed, self.move_speed, false);
	
	path_start(self.path, self.move_speed, path_action_stop, false)
	self.curr_state = CUSTOMER_STATE.LEAVING;
}