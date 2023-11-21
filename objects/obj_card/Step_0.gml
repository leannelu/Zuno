/// @description Insert description here
// You can write your code in this editor

if(obj_manager.player_selected == noone)
{
	if(in_player_hand)
	{
		if(position_meeting(mouse_x, mouse_y, id) && global.state = STATES.PLAYER_TURN)
		{
			//raises when hovered over
			target_y = original_y - 10;
			target_depth = -1000;
			obj_manager.hovered = id;
			hovering = true;
			middle_card = ds_list_find_value(obj_manager.discard, ds_list_size(obj_manager.discard) - 1);
			if(mouse_check_button_pressed(mb_left))
			{
				if (number == middle_card.number || card_color == middle_card.card_color || 
					wild || middle_card.card_color == "wild")
				{
					obj_manager.player_selected = id;
					discardCard(obj_manager.player_hand, id);
					in_player_hand = false;
					hovering = false;
				}
				else
				{
					audio_play_sound(snd_unplayable, 1, 0);
				}
			}
		}
		else
		{
			//revert back to original position when not hovered over
			target_y = original_y;
			target_depth = -ds_list_find_index(obj_manager.player_hand, id);
			hovering = false;
		}
	}
}
