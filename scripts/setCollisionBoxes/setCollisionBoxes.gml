// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function setCollisionBoxes(rows_size){
	if (ds_list_find_index(obj_manager.player_hand, id) == 15 || ds_list_find_index(obj_manager.player_hand, id) == 31 || ds_list_find_index(obj_manager.player_hand, id) == ds_list_size(obj_manager.player_hand) - 1)
		x_collision = sprite_width;
	else 
		x_collision = min(obj_manager.player_x_offset - 1, sprite_width);
	if(ds_list_find_index(obj_manager.player_hand, id) > rows_size)
		y_collision = sprite_height;
	else
	{
		if(ds_list_size(obj_manager.player_hand) - ds_list_find_index(obj_manager.player_hand, id) < 16)
			y_collision = sprite_height;
		else
			y_collision = 34;
	}
}