/// @description Insert description here
// You can write your code in this editor
manager = instance_find(obj_manager, 0);

if(!instance_exists(manager))
{
	show_debug_message("Unable to find manager instance")
	exit
}

manager.register_chair(self);







