/// @description Insert description here
// You can write your code in this editor

#region state
#macro BASE_SPAWN_INTERVAL_SECONDS 2

spr_arr = [
    char_01, char_02, char_03, char_04, char_05, char_06, char_07, char_08, char_09, char_10, 
    char_11, char_12, char_13, char_14, char_15, char_16, char_17, char_18, char_19, char_20,
    char_21, char_22, char_23, char_24, char_25, char_26, char_27, char_28, char_29, char_30,
    char_31, char_32, char_33, char_34, char_35, char_36, char_37, char_38, char_39, char_40,
    char_41, char_42, char_43, char_44, char_45, char_46, char_47, char_48, char_49, char_50
];


current_level = 0;
customers_per_level = [3, 5, 10, 14]
customers_spawned_per_level = [0, 0, 0, 0]

entry_point = instance_find(obj_entry, 0);
has_spawn_scheduled = false;

#endregion

#region behaviour
calculate_spawn_interval_seconds = function () {
	return BASE_SPAWN_INTERVAL_SECONDS - current_level
}

can_spawn_customer = function () {
	return  self.customers_spawned_per_level[self.current_level] < self.customers_per_level[self.current_level]
}

should_schedule_spawn = function () {
	return !self.has_spawn_scheduled && self.can_spawn_customer()
}

spawn_random_customer = function () {
	var _sprite = self.spr_arr[irandom(array_length(self.spr_arr) - 2)];
	
	if(self.entry_point == noone || !self.can_spawn_customer()) {
		exit
	}
	
	// All customers spawning in same position is no bueno
	var _customer = instance_create_layer(entry_point.x, entry_point.y - 20, "Characters", obj_simple_customer);
	
	_customer.sprite_index = _sprite;
	
	self.customers_spawned_per_level[self.current_level] += 1;
	self.has_spawn_scheduled = false;
}

schedule_next_spawn = function () {
	var _time_s_id = call_later(self.calculate_spawn_interval_seconds(), time_source_units_seconds, self.spawn_random_customer, false)
	
	self.has_spawn_scheduled = true;
}
#endregion










