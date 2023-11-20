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
	draw_text(center_x_offset + 95, room_height / 2 - 5, 
		"Choose a color to\nturn this card into:\nPress R for red\nPress B for blue\nPress Y for yellow\nPress G for green");
}
if(wild_trans_info)
{
	draw_set_font(fnt_small);
	draw_text(center_x_offset + 95, room_height / 2 - 5, 
		"Choose another\ncolor. All cards\nin your opponent's\nhand will turn\ninto that color.\nPress R for red\nPress B for blue\nPress Y for yellow\nPress G for green");
}
if(computer_shield)
{
	draw_sprite(spr_shield, 0, 75, 190);	
}
if(player_shield)
{
	draw_sprite(spr_shield, 0, 75, room_height - 250);	
}