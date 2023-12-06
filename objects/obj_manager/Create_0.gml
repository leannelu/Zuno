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

computer_score = 0;
player_score = 0;

num_cards = 53;
hand_count = 7;

hand_x_offset = 85;
hand_y_offset = 80;
center_x_offset = 210;
center_y_offset = 75;

player_x_offset = hand_x_offset;
player_y_offset = 131;
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
swap_particles = false;

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
	else if(_i < 22) _new_card.card_color = "blue";
	else if(_i < 33) _new_card.card_color = "yellow";
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

particles = part_system_create();
part_system_depth(particles, 0);

skip = part_type_create();
part_type_sprite(skip, spr_skip, 0, 0, 0);
part_type_size(skip, 0.5, 0.9, -0.001, 0);
part_type_speed(skip, 3, 4, 0, 0);
part_type_direction(skip, 0, 360, 0, 0);
part_type_alpha2(skip, 0.8, 0.3);
part_type_life(skip, 40, 60);

shield = part_type_create();
part_type_sprite(shield, spr_shield_particles, 0, 0, 0);
part_type_size(shield, 0.4, 0.9, -0.001, 0);
part_type_speed(shield, 3, 4, 0, 0);
part_type_direction(shield, 0, 360, 0, 0);
part_type_alpha2(shield, 0.8, 0.4);
part_type_life(shield, 40, 60);

swap = part_type_create();
part_type_sprite(swap, spr_swap, 0, 0, 0);
part_type_size(swap, 0.4, 0.8, -0.001, 0);
part_type_speed(swap, 3, 4, 0, 0);
part_type_direction(swap, 0, 360, 0, 0);
part_type_alpha2(swap, 0.8, 0.4);
part_type_life(swap, 40, 60);

firework = part_type_create();
part_type_shape(firework, pt_shape_line);
part_type_size(firework, 0.4, 0.8, -0.001, 0);
part_type_color3(firework, c_red, c_yellow, c_blue);
part_type_speed(firework, 3, 4, 0, 0);
part_type_direction(firework, 0, 359, 0, 0);
part_type_life(firework, 50, 70);
part_type_orientation(firework, 0, 0, 0, 0, true);

two = part_type_create();
part_type_sprite(two, spr_plus_2, 0, 0, 0);
part_type_size(two, 0.8, 1, -0.001, 0);
part_type_speed(two, 3, 4, 0, 0);
part_type_direction(two, 0, 360, 0, 0);
part_type_alpha2(two, 0.8, 0.4);
part_type_life(two, 40, 60);

four = part_type_create();
part_type_sprite(four, spr_plus_4, 0, 0, 0);
part_type_size(four, 0.6, 0.9, -0.001, 0);
part_type_speed(four, 3, 4, 0, 0);
part_type_direction(four, 0, 360, 0, 0);
part_type_alpha2(four, 0.8, 0.4);
part_type_life(four, 40, 60);