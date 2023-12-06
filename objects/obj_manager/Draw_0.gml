/// @description Insert description here
// You can write your code in this editor

/*draw_set_font(fnt_score);
draw_text(20, 20, computer_score);
draw_text(20, room_height - 80, player_score);*/

if(global.state == STATES.PLAYER_TURN || global.state == STATES.PLAYER_RESOLVE)
{
	draw_set_font(fnt_small);
	draw_text(105, room_height - 150, "Your Turn");
}
if(global.state == STATES.COMP_TURN || global.state == STATES.COMP_RESOLVE)
{
	draw_set_font(fnt_small);
	draw_text(105, 140, "Computer's\nTurn");
}
if(wild_info)
{
	draw_set_font(fnt_small);
	draw_text_ext(center_x_offset + 95, room_height / 2 - 10, "Choose a new color by clicking a color on this card", 30, 225);
}
if(wild_trans_info)
{
	draw_set_font(fnt_small);
	draw_text_ext(center_x_offset + 95, room_height / 2 - 10, 
		"Click a color on this card.\nAll cards in your opponent's hand will turn into that color", 30, 230);
}
if(computer_shield)
{
	draw_sprite(spr_shield, 0, 75, 175);	
}
if(player_shield)
{
	draw_sprite(spr_shield, 0, 75, room_height - 250);	
}
if(hovered != noone)
{
	if(hovered.number == 10 && hovered.hovering)
	{
		draw_set_font(fnt_smaller);
		draw_text(room_width/2, room_height - 40, "Skip - Skip your opponent's turn");
	}
	else if(hovered.number == 11 && hovered.hovering)
	{
		draw_set_font(fnt_smaller);
		draw_text(room_width/2, room_height - 40, "Draw 2 - Your opponent must draw 2 cards, and their turn is skipped");
	}
	else if(hovered.number == 12 && hovered.hovering)
	{
		draw_set_font(fnt_smaller);
		draw_text(room_width/2, room_height - 40, "Draw 4 (Wild) - Your opponent must draw 4 cards and their turn is skipped");
	}
	else if(hovered.number == 13 && hovered.hovering)
	{
		draw_set_font(fnt_smaller);
		draw_text(room_width/2, room_height - 40, "Swap (Wild) - Swap hands with your opponent");
	}
	else if(hovered.number == 14 && hovered.hovering)
	{
		draw_set_font(fnt_smaller);
		draw_text(room_width/2, room_height - 40, "Shield (Wild) - Protects you from the next +2 or +4 card");
	}
	else if(hovered.number == 15 && hovered.hovering)
	{
		draw_set_font(fnt_smaller);
		draw_text(room_width/2, room_height - 40, "Oops, all __s! (Wild) - Change the color of all cards in your opponent's hand, except wild cards.\nThen change this card's color");
	}
	else if(hovered.wild && hovered.hovering)
	{
		draw_set_font(fnt_smaller);
		draw_text(room_width / 2, room_height - 40, "Wild Card - Can be played on any color. After playing this card, choose a new color");
	}
}