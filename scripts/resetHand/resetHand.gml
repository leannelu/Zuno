// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function resetHand(hand, nextTurn){
	var hand_size = ds_list_size(hand);
	var offset = clamp(hand_x_offset - (9 * (hand_size - hand_count)), 45, hand_x_offset);
	for(var _i = 0; _i < hand_size; _i++)
	{
		hand[|_i].target_depth = -_i;
		hand[|_i].target_x = center_x_offset + _i * offset;
		if(hand == player_hand)
		{
			if (_i > 31)
			{
				player_hand[|_i].target_y = room_height - hand_y_offset - 61;
				player_hand[|_i].original_y = room_height - hand_y_offset - 61;
				player_hand[|_i].target_x = center_x_offset + (_i - 32) * offset;
			}
			else if(_i > 15)
			{
				player_hand[|_i].target_y = room_height - hand_y_offset - 96;
				player_hand[|_i].original_y = room_height - hand_y_offset - 96;
				player_hand[|_i].target_x = center_x_offset + (_i - 16) * offset;
			}
			else
			{
				player_hand[|_i].target_y = room_height - hand_y_offset - 131;
				player_hand[|_i].original_y = room_height - hand_y_offset - 131;
			}
		}
	}		
	if(ds_list_size(deck) == 0)
	{
		if(move_time == 0)
		{
			next_turn = nextTurn;
			num_cards = ds_list_size(discard) - 1;
			shuffle_time = 0;
			global.state = STATES.RESHUFFLE;
		}
	}
}