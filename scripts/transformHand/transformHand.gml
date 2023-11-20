// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function transformHand(hand, color){
	hand_size = ds_list_size(hand);
	for(var _i = 0; _i < hand_size; _i++)
	{
		if(!hand[|_i].wild) hand[|_i].card_color = color;	
	}
	audio_play_sound(snd_change_color, 1, 0);
	wild_trans_info = false;
	transformed = true;
}