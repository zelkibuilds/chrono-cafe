/// @description Insert description here
// You can write your code in this editor

#region state
#macro FOOD_PRICE 10
#macro BEVERAGE_PRICE 5

_orders_arr = []

_menu = [
    new Order(spr_food_00, FOOD_PRICE),
    new Order(spr_food_01, FOOD_PRICE),
    new Order(spr_food_02, FOOD_PRICE),
    new Order(spr_food_03, FOOD_PRICE),
    new Order(spr_food_04, FOOD_PRICE),
    new Order(spr_food_05, FOOD_PRICE),
    new Order(spr_food_06, FOOD_PRICE),
    new Order(spr_food_07, FOOD_PRICE),
    new Order(spr_food_08, FOOD_PRICE),
    new Order(spr_food_09, FOOD_PRICE),
    new Order(spr_food_10, FOOD_PRICE),
    new Order(spr_food_11, FOOD_PRICE),
    new Order(spr_food_12, FOOD_PRICE),
    new Order(spr_food_13, FOOD_PRICE),
    new Order(spr_food_14, BEVERAGE_PRICE),
    new Order(spr_food_15, BEVERAGE_PRICE),
    new Order(spr_food_16, BEVERAGE_PRICE),
    new Order(spr_food_17, BEVERAGE_PRICE),
    new Order(spr_food_18, BEVERAGE_PRICE),
    new Order(spr_food_19, BEVERAGE_PRICE),
    new Order(spr_food_20, BEVERAGE_PRICE),
    new Order(spr_food_21, BEVERAGE_PRICE),
    new Order(spr_food_22, BEVERAGE_PRICE),
    new Order(spr_food_23, BEVERAGE_PRICE),
    new Order(spr_food_24, BEVERAGE_PRICE),
    new Order(spr_food_25, BEVERAGE_PRICE),
    new Order(spr_food_26, BEVERAGE_PRICE),
    new Order(spr_food_27, BEVERAGE_PRICE)
];

cook = instance_find(obj_chef, 0)
_active_order_bubbles = ds_map_create()

#endregion

#region behaviour

/// @function place_random_order(_customer)
/// @description Places order for a customer in the orders queue with a randomly selected menu item
/// @param {Id.Instance} _customer The customer instance id
place_random_order = function(_customer) {
	var _rand_order_idx = irandom(array_length(self._menu) - 1)	
	var _order = self._menu[_rand_order_idx]
	
	array_push(self._orders_arr, { order: _order, customer: _customer })
	self.show_order_bubble(_customer, _order.item_spr)
}
	
cancel_order = function(_customer) {
	var _f = function(_element) {
		return _element.customer == _customer; 
	}
	
	var _idx = array_find_index(self._orders_arr, _f);
	
	if(_idx == -1) {
		self.cook.cancel_order()
		return;
	}
	
	array_delete(self._orders_arr, _idx, 1)
}

show_order_bubble = function(_customer, _order_spr) {
	var _bubble = instance_create_layer(_customer.x, _customer.y - 30, "Floating_UI", obj_order_bubble, { order_icon: _order_spr})
	
	ds_map_add(self._active_order_bubbles, _customer, _bubble);
}

hide_order_bubble = function(_customer) {
	var _bubble = ds_map_find_value(self._active_order_bubbles, _customer);
	
	if(is_undefined(_bubble)) {
		exit
	}
	
	instance_destroy(_bubble);
	
	ds_map_delete(self._active_order_bubbles, _customer);
}
	
take_order_from_queue = function() {
	return array_shift(self._orders_arr)
}

has_queued_orders = function() {
	return array_length(self._orders_arr) > 0
}

#endregion