/// @description Insert description here
// You can write your code in this editor

enum STATES
{
	DEAL,
	PLAYER_TURN,
	PLAYER_RESOLVE,
	COMP_TURN,
	COMP_RESOLVE,
	RESHUFFLE
}

global.state  = STATES.DEAL;

deck = ds_list_create();
player_hand = ds_list_create();
computer_hand = ds_list_create();
discard = ds_list_create();
comp_options = ds_list_create();
temp_hand = ds_list_create();

player_selected = noone;
computer_selected = noone;
hovered = noone;
hovered_list = ds_list_create();

computer_score = 0;
player_score = 0;

num_cards = 53;
hand_count = 7;

hand_x_offset = 85;
hand_y_offset = 80;
center_x_offset = 210;
center_y_offset = 75;

player_x_offset = hand_x_offset;
comp_x_offset = hand_x_offset;

reveal_time = 0;
move_time = 0;
compare_time = 0;
shuffle_time = 0;

shuffled = false;
shuffle_i = 0;
comp_i = 0;
draw = 0;
drawn = 0;
played_sound = false;
wild_info = false;
wild_trans_info = false;
transformed = false;

computer_shield = false;
player_shield = false;

next_turn = "player";

randomize();

for(var _i = 0; _i < num_cards; _i++) 
{
	var _new_card = instance_create_layer(x, y, "Instances", obj_card);
	//assign the cards numbers 1-9; 10 is skip and 11 is +2
	_new_card.number = (_i % 11) + 1;
	_new_card.num_string = string(_new_card.number)
	if(_i < 11) _new_card.card_color = "red";
	else if(_i < 21) _new_card.card_color = "blue";
	else if(_i < 31) _new_card.card_color = "yellow";
	else _new_card.card_color = "green";
	if(_i > 43)
	{
		_new_card.wild = true;
		_new_card.card_color = "wild";
		//set number to 0 so it cannot match with anything by number
		_new_card.number = 0;
		if(_i > 47 && _i < 50)
		{
			//draw 4
			_new_card.number = 12;
		}
		if(_i == 50) _new_card.number = 13; //swap
		if(_i == 51) _new_card.number = 14; //shield
		if(_i == 52) _new_card.number = 15; //oops, all __s!
	}
	_new_card.face_up = false;
	_new_card.in_player_hand = false;
	_new_card.target_x = x;
	_new_card.target_y = y;
	ds_list_add(deck, _new_card);
}

ds_list_shuffle(deck);

for(var _i = 0; _i < num_cards; _i++)
{
	deck[|_i].target_depth = num_cards - _i;
	deck[|_i].target_y = y - _i;
	deck[|_i].original_y = y - _i;
}
