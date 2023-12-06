/// @description Insert description here
// You can write your code in this editor

if(obj_manager.player_selected == noone)
{
	if(in_player_hand)
	{
		with(obj_manager) player_x_offset = clamp(hand_x_offset - (9 * (ds_list_size(player_hand) - hand_count)), 45, hand_x_offset);
		if (ds_list_size(obj_manager.player_hand) > 31)
		{
			setCollisionBoxes(31);
		}
		else if(ds_list_size(obj_manager.player_hand) > 16)
		{
			setCollisionBoxes(15);
		}
		else
		{
			if (ds_list_find_index(obj_manager.player_hand, id) == ds_list_size(obj_manager.player_hand) - 1)
			{
				x_collision = sprite_width;	
			}
			else
			{
				x_collision = min(obj_manager.player_x_offset - 1, sprite_width);	
			}
			y_collision = sprite_height;	
		}
		if(point_in_rectangle(mouse_x, mouse_y, x, y, x + x_collision, y + y_collision) && global.state = STATES.PLAYER_TURN)
		{
			if(!hovering) audio_play_sound(snd_card_hover, 1, 0);
			//raises when hovered over
			target_y = original_y - 10;
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
			hovering = false;
		}
	}
}
