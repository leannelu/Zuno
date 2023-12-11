/// @description Insert description here
// You can write your code in this editor

switch(global.state)
{
	case STATES.DEAL:
		if(move_time = 0)
		{
			var _player_hand_count = ds_list_size(player_hand);
			var _comp_hand_count = ds_list_size(computer_hand);

			if (_comp_hand_count < hand_count)
			{
				//deal card to the computer
				var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
				ds_list_delete(deck, ds_list_size(deck) - 1);
				ds_list_add(computer_hand, _dealt_card);
				audio_play_sound(snd_card, 1, 0);
				_dealt_card.target_x = center_x_offset + _comp_hand_count * hand_x_offset;
				_dealt_card.target_y = hand_y_offset;
				//TESTING
				//_dealt_card.face_up = true;
			}
			else if(_player_hand_count < hand_count)
			{
				//deal card to the player
				var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
				ds_list_delete(deck, ds_list_size(deck) - 1);
				ds_list_add(player_hand, _dealt_card);
				audio_play_sound(snd_card, 1, 0);
				_dealt_card.target_x = center_x_offset + _player_hand_count * hand_x_offset;
				_dealt_card.target_y = room_height - hand_y_offset - 131; //sprite height
				//save y position for later
				_dealt_card.original_y = _dealt_card.target_y;
			
				_dealt_card.face_up = true;
				_dealt_card.in_player_hand = true;
			}
			else if(ds_list_size(discard) < 1)
			{
				//put starting card in middle
				var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
				var _i = 2;
				//make sure starting card isn't a wild or action card
				while(_dealt_card.wild || _dealt_card.number > 9)
				{
					_dealt_card = ds_list_find_value(deck, ds_list_size(deck) - _i);
					_i++;
				}
				discardCard(deck, _dealt_card);
				for(var i = 0; i < ds_list_size(deck); i++)
				{
					deck[|i].target_depth = ds_list_size(deck) - i;
					deck[|i].target_y = y - i;
					deck[|i].original_y = y - i;
				}
			}
			else
			{
				global.state = STATES.PLAYER_TURN;
			}
		}
		break;
	case STATES.PLAYER_TURN:
		if(player_selected == noone)
		{
			var _deck_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
			//draw from deck
			if (ds_list_size(deck) != 0)
			{
				if(position_meeting(mouse_x, mouse_y, _deck_card)) 
				{
					_deck_card.highlight = true;
					if(mouse_check_button_pressed(mb_left))
					{
						var _player_hand_count = ds_list_size(player_hand);
						ds_list_delete(deck, ds_list_size(deck) - 1);
						ds_list_add(player_hand, _deck_card);
						audio_play_sound(snd_card, 1, 0);
						_deck_card.target_x = center_x_offset + _player_hand_count * hand_x_offset;
						_deck_card.target_y = room_height - hand_y_offset - 131; //sprite height
						//save y position for later
						_deck_card.original_y = _deck_card.target_y;
						_deck_card.highlight = false;
			
						_deck_card.face_up = true;
						_deck_card.in_player_hand = true;
						move_time = 0;
						reveal_time = 0;
						//resetHand(player_hand, "player");
						next_turn = "player";
						global.state = STATES.PLAYER_RESOLVE;
					}
				}
				else
				{
					_deck_card.highlight = false;	
				}
			}
			compare_time = 0;
			reveal_time = 0;
		}
		else
		{
			resetHand(player_hand, "player");
			//skip
			if(player_selected.number == 10) 
			{
				if(player_selected.y == player_selected.target_y && player_selected.x == player_selected.target_x)
				{
					audio_play_sound(snd_skip, 1, 0);
					part_particles_create(particles, player_selected.x + 30, player_selected.y + 60, skip, 10);
				}
				else
				{
					break;	
				}
				next_turn = "player";
			}
			//+2 or +4
			else if(player_selected.number == 11 || player_selected.number == 12)
			{
				if(computer_shield)
				{
					next_turn = "computer";
					computer_shield = false;
					audio_play_sound(snd_shield_break, 1, 0);
				}
				else
				{
					if(player_selected.number == 11) draw = 2;
					else draw = 4;
					next_turn = "player";
					if(drawn < draw)
					{
						if(ds_list_size(deck) == 0)
						{
							//if deck is empty and there aren't enough cards to reshuffle, stop drawing
							if(ds_list_size(discard) == 1)
							{
								drawn = draw;
								break;
							}
							if(move_time == 0)
							{
								num_cards = ds_list_size(discard) - 1;
								shuffle_time = 0;
								global.state = STATES.RESHUFFLE;
							}
							else break;
						}
						if(drawn == 0){
							//delay
							if(!played_sound) 
							{
								if(player_selected.y == player_selected.target_y && player_selected.x == player_selected.target_x)
								{
									audio_play_sound(snd_draw_card, 1, 0);
									if(draw = 2)
										part_particles_create(particles, player_selected.x + 30, player_selected.y + 60, two, 10);
									else
										part_particles_create(particles,player_selected.x + 30, player_selected.y + 60, four, 10);
									played_sound = true;
								}
								else break;
							}
							if(reveal_time == 0)
							{
								var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
								ds_list_delete(deck, ds_list_size(deck) - 1);
								ds_list_add(computer_hand, _dealt_card);
								audio_play_sound(snd_card, 1, 0);
								_dealt_card.target_y = hand_y_offset;
								resetHand(computer_hand, "player");
								drawn++;
							}
							move_time = 0;
							resetHand(computer_hand, "player");
						}
						else
						{
							if(move_time == 0)
							{
								var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
								ds_list_delete(deck, ds_list_size(deck) - 1);
								ds_list_add(computer_hand, _dealt_card);
								audio_play_sound(snd_card, 1, 0);
								_dealt_card.target_y = hand_y_offset;
								drawn++;
							}
						}
						resetHand(computer_hand, "player");
						break;
					}
					else
					{
						drawn = 0;	
					}
				}
			}
			//swap
			else if(player_selected.number == 13)
			{
				if(player_selected.y == player_selected.target_y && player_selected.x == player_selected.target_x)
				{
					if(!swap_particles)
					{
						part_particles_create(particles, player_selected.x + 30, player_selected.y + 60, swap, 10);
						audio_play_sound(snd_swap, 1, 0);
						swap_particles = true;
					}
				}
				else
				{
					break;	
				}
				if(compare_time == 0)
				{
					if(ds_list_size(player_hand) == 0)
					{
						global.state = STATES.PLAYER_RESOLVE;
						break;
					}
					player_selected = noone;
					ds_list_copy(temp_hand, player_hand);
					ds_list_copy(player_hand, computer_hand);
					ds_list_copy(computer_hand, temp_hand);
					//change positions
					for(var _i = 0; _i < ds_list_size(player_hand); _i++)
					{
						player_hand[|_i].in_player_hand = true;
						player_hand[|_i].face_up = true;
						player_hand[|_i].target_y = room_height - hand_y_offset - 131;
						player_hand[|_i].original_y = player_hand[|_i].target_y;
					}
					for(var _i = 0; _i < ds_list_size(computer_hand); _i++)
					{
						computer_hand[|_i].in_player_hand = false;
						computer_hand[|_i].face_up = false;
						computer_hand[|_i].target_y = hand_y_offset;
					}
					next_turn = "computer";
					ds_list_clear(temp_hand);
					resetHand(player_hand, "computer");
					resetHand(computer_hand, "computer");
					swap_particles = false;
				}
				else break;
			}
			//shield
			else if(player_selected.number == 14)
			{
				if(player_selected.y == player_selected.target_y && player_selected.x == player_selected.target_x)
				{
					player_shield = true;
					audio_play_sound(snd_shield, 1, 0);
					part_particles_create(particles, player_selected.x + 30, player_selected.y + 60, shield, 10);
				}
				else
				{
					break;	
				}
				next_turn = "computer";
			}
			else 
			{
				next_turn = "computer";
			}
			player_selected = noone;
			move_time = 0;
			reveal_time = 0;
			compare_time = 0;
			played_sound = false;
			global.state = STATES.PLAYER_RESOLVE;
		}
		break;
	case STATES.PLAYER_RESOLVE:
		//player wins
		if(ds_list_size(player_hand) == 0)
		{
			part_particles_create(particles, room_width / 2, room_height / 2, firework, 5);
			if(!audio_is_playing(snd_win)) {
				audio_play_sound(snd_win, 1, 0);
			}
			if(reveal_time == 0){
				part_system_destroy(particles);
				room = rm_win;
			}
			break;
		}
		//reset hand positions
		player_x_offset = clamp(hand_x_offset - (9 * (ds_list_size(player_hand) - hand_count)), 45, hand_x_offset);
		for(var _i = 0; _i < ds_list_size(player_hand); _i++)
		{
			player_hand[|_i].target_depth = -_i;
			player_hand[|_i].target_x = center_x_offset + _i * player_x_offset;
			//if there are too many cards, put in another row
			if (_i > 31)
			{
				player_y_offset = 70;
				player_hand[|_i].target_y = room_height - hand_y_offset - 61;
				player_hand[|_i].original_y = room_height - hand_y_offset - 61;
				player_hand[|_i].target_x = center_x_offset + (_i - 32) * player_x_offset;
			}
			else if(_i > 15)
			{
				player_y_offset = 35;
				player_hand[|_i].target_y = room_height - hand_y_offset - 96;
				player_hand[|_i].original_y = room_height - hand_y_offset - 96;
				player_hand[|_i].target_x = center_x_offset + (_i - 16) * player_x_offset;
			}
		}
		var _middle_card = ds_list_find_value(discard, ds_list_size(discard) - 1);
		//change wild card color
		//oops all __s
		if(_middle_card.card_color == "wild" && _middle_card.number == 15 && !transformed)
		{
			wild_trans_info = true;
			var _new_color = changeColor(_middle_card);
			if(_new_color != "")
			{
				if(_new_color == "yellow") part_type_color1(transform, c_yellow);
				if(_new_color == "green") part_type_color1(transform, c_green);
				if(_new_color == "blue") part_type_color1(transform, c_blue);
				if(_new_color == "red") part_type_color1(transform, c_red);
				_middle_card.oops_color = _new_color;
				part_particles_create(particles, _middle_card.x + 41, _middle_card.y, transform, 40);
				transformHand(computer_hand, _new_color);	
			}
		}
		else if(_middle_card.card_color == "wild")
		{
			wild_info = true;
			var _new_color = changeColor(_middle_card);
			if(_new_color != "")
			{
				audio_play_sound(snd_change_color, 1, 0);
				_middle_card.card_color = _new_color;
				wild_info = false;
			}
		}
		//reshuffle empty deck
		else if(ds_list_size(deck) == 0)
		{
			if(move_time == 0)
			{
				num_cards = ds_list_size(discard) - 1;
				shuffle_time = 0;
				global.state = STATES.RESHUFFLE;
			}
		}
		else
		{
			compare_time = 0;
			if(next_turn == "player") global.state = STATES.PLAYER_TURN;
			else global.state = STATES.COMP_TURN;
		}
		break;
	case STATES.COMP_TURN:
		if(computer_selected == noone)
		{
			var _middle_card = ds_list_find_value(discard, ds_list_size(discard) - 1);
			//loop through computer's hand
			if(comp_i < ds_list_size(computer_hand))
			{
				var _comp_card = ds_list_find_value(computer_hand, comp_i);
				//if a card can be played, add it to a list of options
				if(_comp_card.card_color == _middle_card.card_color || _comp_card.number == _middle_card.number || _comp_card.wild)
				{
					ds_list_add(comp_options, _comp_card);
				}
				comp_i++;
				reveal_time = 0;
			}
			else
			{
				if(reveal_time == 0)
				{
					var _num_options = ds_list_size(comp_options);
					//if there are any cards that can be played
					if(_num_options > 0)
					{
						//randomly select one of the playable cards
						var selected = irandom_range(0, _num_options - 1);
						computer_selected = ds_list_find_value(comp_options, selected);
						discardCard(computer_hand, computer_selected);
					}
					else //if there are no playable cards, draw from deck
					{
						if(ds_list_size(deck) > 0)
						{
							var _comp_hand_count = ds_list_size(computer_hand);
							var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
							ds_list_delete(deck, ds_list_size(deck) - 1);
							ds_list_add(computer_hand, _dealt_card);
							audio_play_sound(snd_card, 1, 0);
							_dealt_card.target_x = center_x_offset + _comp_hand_count * hand_x_offset;
							_dealt_card.target_y = hand_y_offset;
							//TESTING
							//_dealt_card.face_up = true;
							comp_i = 0;
							reveal_time = 0;
							compare_time = 0;
							next_turn = "computer";
							global.state = STATES.COMP_RESOLVE;
						}
						else
						{
							next_turn = "player";
							comp_i = 0;
							reveal_time = 0;
							compare_time = 0;
							played_sound = false;
							global.state = STATES.COMP_RESOLVE;
						}
					}
				}
			}
			compare_time = 0;
		}
		else
		{
			resetHand(computer_hand, "computer");
			//skip
			if(computer_selected.number == 10) 
			{
				if(computer_selected.y == computer_selected.target_y && computer_selected.x == computer_selected.target_x)
				{
					audio_play_sound(snd_skip, 1, 0);
					part_particles_create(particles, computer_selected.x + 30, computer_selected.y + 60, skip, 10);
				}
				else
				{
					break;	
				}
				next_turn = "computer";
			}
			//+2 and +4
			else if(computer_selected.number == 11 || computer_selected.number == 12)
			{
				if(player_shield)
				{
					next_turn = "player";
					player_shield = false;
					audio_play_sound(snd_shield_break, 1, 0);
				}
				else
				{
					if(computer_selected.number == 11) draw = 2;
					else draw = 4;
					next_turn = "computer";
					if(drawn < draw)
					{
						if(ds_list_size(deck) == 0)
						{
							if(ds_list_size(discard) == 1)
							{
								drawn = draw;
								break;
							}
							if(move_time == 0)
							{
								num_cards = ds_list_size(discard) - 1;
								shuffle_time = 0;
								global.state = STATES.RESHUFFLE;
							}
							else break;
						}
						if(drawn == 0)
						{
							if(!played_sound) 
							{
								if(computer_selected.y == computer_selected.target_y && computer_selected.x == computer_selected.target_x)
								{
									if(draw = 2)
										part_particles_create(particles, computer_selected.x + 30, computer_selected.y + 60, two, 10);
									else
										part_particles_create(particles, computer_selected.x + 30, computer_selected.y + 60, four, 10);
									audio_play_sound(snd_draw_card, 1, 0);
									played_sound = true;
								}
								else break;
							}
							if(compare_time == 0)
							{
								var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
								ds_list_delete(deck, ds_list_size(deck) - 1);
								ds_list_add(player_hand, _dealt_card);
								audio_play_sound(snd_card, 1, 0);
								_dealt_card.target_y = room_height - hand_y_offset - 131;
								_dealt_card.original_y = _dealt_card.target_y;
								_dealt_card.face_up = true;
								_dealt_card.in_player_hand = true;
								drawn++;
							}
							resetHand(player_hand, "computer");
							move_time = 0;
						}
						else
						{
							if(move_time = 0)
							{
								var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
								ds_list_delete(deck, ds_list_size(deck) - 1);
								ds_list_add(player_hand, _dealt_card);
								audio_play_sound(snd_card, 1, 0);
								_dealt_card.target_y = room_height - hand_y_offset - 131;
								_dealt_card.original_y = _dealt_card.target_y;
								_dealt_card.face_up = true;
								_dealt_card.in_player_hand = true;
								drawn++;
							}
						}
						resetHand(player_hand, "computer");
						break;
					}
					else
					{
						drawn = 0;
					}
				}
			}
			//swap
			else if(computer_selected.number == 13)
			{
				if(computer_selected.y == computer_selected.target_y && computer_selected.x == computer_selected.target_x)
				{
					if(!swap_particles)
					{
						part_particles_create(particles, computer_selected.x + 30, computer_selected.y + 60, swap, 10);
						audio_play_sound(snd_swap, 1, 0);
						swap_particles = true;
					}
					if(ds_list_size(computer_hand) == 0)
					{
						global.state = STATES.COMP_RESOLVE;
						break;
					}
				}
				else
				{
					break;	
				}
				if(compare_time == 0)
				{
					computer_selected = noone;
					ds_list_copy(temp_hand, player_hand);
					ds_list_copy(player_hand, computer_hand);
					ds_list_copy(computer_hand, temp_hand);
					for(var _i = 0; _i < ds_list_size(player_hand); _i++)
					{
						player_hand[|_i].in_player_hand = true;
						player_hand[|_i].face_up = true;
						player_hand[|_i].target_y = room_height - hand_y_offset - 131;
						player_hand[|_i].original_y = player_hand[|_i].target_y;
					}
					for(var _i = 0; _i < ds_list_size(computer_hand); _i++)
					{
						computer_hand[|_i].in_player_hand = false;
						computer_hand[|_i].face_up = false;
						computer_hand[|_i].target_y = hand_y_offset;
					}
					next_turn = "player";
					ds_list_clear(temp_hand);
					resetHand(player_hand, "computer");
					resetHand(computer_hand, "computer");
					swap_particles = false;
				}
				else break;
			}
			//shield
			else if(computer_selected.number == 14)
			{
				if(computer_selected.y == computer_selected.target_y && computer_selected.x == computer_selected.target_x)
				{
					audio_play_sound(snd_shield, 1, 0);
					part_particles_create(particles, computer_selected.x + 30, computer_selected.y + 60, shield, 10);
				}
				else
				{
					break;	
				}
				computer_shield = true;	
				next_turn = "player";
			}
			else 
			{
				next_turn = "player";
			}
			comp_i = 0;
			ds_list_clear(comp_options);
			computer_selected = noone;
			reveal_time = 0;
			compare_time = 0;
			played_sound = false;
			global.state = STATES.COMP_RESOLVE;	
		}
		break;
	case STATES.COMP_RESOLVE:
		//computer wins
		if(ds_list_size(computer_hand) == 0)
		{
			if(!audio_is_playing(snd_lose)) audio_play_sound(snd_lose, 1, 0);
			if(reveal_time == 0){
				room = rm_lose;
			}
			break;
		}
		//reset card positions
		comp_x_offset = clamp(hand_x_offset - (9 * (ds_list_size(computer_hand) - hand_count)), 45, hand_x_offset);
		for(var _i = 0; _i < ds_list_size(computer_hand); _i++)
		{
			computer_hand[|_i].target_depth = -_i;
			computer_hand[|_i].target_x = center_x_offset + _i * comp_x_offset;
		}
		//deal with playing a wild card
		var _middle_card = ds_list_find_value(discard, ds_list_size(discard) - 1);
		if(_middle_card.card_color == "wild")
		{
			if(reveal_time == 0) 
			{
				//oops all __: choose a color to turn the player's hand into
				if(_middle_card.number == 15 && !transformed)
				{
					new_color = choose("red", "blue", "yellow", "green");
					_middle_card.oops_color = new_color;
					transformHand(player_hand, new_color);
				}
				else 
				{
					if(_middle_card.number == 15 && new_color == "red") _middle_card.card_color = choose("blue", "yellow", "green");
					else if(_middle_card.number == 15 && new_color == "blue") _middle_card.card_color = choose("red", "yellow", "green");
					else if(_middle_card.number == 15 && new_color == "green") _middle_card.card_color = choose("red", "yellow", "blue");
					else if(_middle_card.number == 15 && new_color == "yellow") _middle_card.card_color = choose("red", "blue", "green");
					else 
					{
						var options = ds_list_create();
						for(var i = 0; i < ds_list_size(computer_hand); i++)
						{
							var card = ds_list_find_value(computer_hand, i);
							if(card.card_color != "wild") ds_list_add(options, card);
						}
						if(ds_list_size(options) > 0)
						{
							var index = irandom_range(0, ds_list_size(options) - 1);
							var card = ds_list_find_value(options, index);
							_middle_card.card_color = card.card_color;
						}
						else
						{
							_middle_card.card_color = choose("red", "blue", "yellow", "green");
						}
					}
					audio_play_sound(snd_change_color, 1, 0);
				}
			}
		}
		//reshuffle
		else if(ds_list_size(deck) == 0)
		{
			if(move_time == 0)
			{
				num_cards = ds_list_size(discard) -1;
				shuffle_time = 0;
				global.state = STATES.RESHUFFLE;
			}
		}
		else
		{
			reveal_time = 0;
			move_time = 0;
			if(next_turn == "player") global.state = STATES.PLAYER_TURN;
			else global.state = STATES.COMP_TURN;
		}
		break;
		case STATES.RESHUFFLE:
			if(ds_list_size(deck) < num_cards)
			{
				if(shuffle_time == 0)
				{
					if(ds_list_size(deck) == 0)
					{
						//move top card to the bottom to save it
						var _top_card = ds_list_find_value(discard, ds_list_size(discard) - 1);
						ds_list_delete(discard, ds_list_size(discard) - 1);
						ds_list_insert(discard, 0, _top_card);
						_top_card.target_depth = 0;
						_top_card.target_y = room_height / 2 - _top_card.sprite_height / 2 - 2;
					}
					//remove from discard and add to deck
					var _discard_card = ds_list_find_value(discard, ds_list_size(discard) - 1);
					_discard_card.face_up = false;
					if(_discard_card.wild) _discard_card.card_color = "wild";
					transformed = false;
					ds_list_delete(discard, ds_list_size(discard) - 1);
					ds_list_add(deck, _discard_card);
					audio_play_sound(snd_card, 1, 0);
			
					_discard_card.target_x = x;
					_discard_card.target_y = y - ds_list_size(deck);
					_discard_card.target_depth = -ds_list_size(deck);
				}
			}
			else
			{
				if(!shuffled)
				{
					ds_list_shuffle(deck);
					shuffled = true;
				}
				if(shuffle_time == 0)
				{
					//put each shuffled card in correct position in deck
					if(shuffle_i < num_cards)
					{
						audio_play_sound(snd_card, 1, 0);
						deck[|shuffle_i].target_depth = num_cards - shuffle_i;
						deck[|shuffle_i].target_y = y - shuffle_i;
						deck[|shuffle_i].original_y = y - shuffle_i;
						shuffle_i++;
						move_time = 0;
					}
					else
					{
						if(move_time == 0)
						{
							shuffled = false;
							shuffle_i = 0;
							if(next_turn == "player") global.state = STATES.PLAYER_TURN;
							else global.state = STATES.COMP_TURN;
						}
					}
				}
			}
			break;
}

move_time++;
if(move_time >= 15)
{
	move_time = 0;	
}

reveal_time++;
if(reveal_time >= room_speed * 1.5)
{
	reveal_time = 0;	
}

compare_time++;
if(compare_time >= room_speed) compare_time = 0;

shuffle_time++;
if(shuffle_time >= 4) shuffle_time = 0;