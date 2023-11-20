// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function discardCard(hand, card_id){
	//remove it from the hand, add it to the discard
	var index = ds_list_find_index(hand, card_id);
	ds_list_delete(hand, index);
	ds_list_add(obj_manager.discard, card_id);
	audio_play_sound(snd_card, 1, 0);
			
	//put it in the discard pile position
	card_id.face_up = true;
	card_id.target_x = room_width / 2 - card_id.sprite_width / 2;
	card_id.target_y = room_height / 2 - card_id.sprite_height / 2 - (2 * ds_list_size(obj_manager.discard));
	card_id.target_depth = -ds_list_size(obj_manager.discard);
}