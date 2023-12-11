/// @description Insert description here
// You can write your code in this editor

image_speed = 0;

draw_self();
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_small);
if(room = rm_main)
{
	draw_text(x + sprite_width / 2, y + sprite_height / 2, "Quit");	
}
else draw_text(x + sprite_width / 2, y + sprite_height / 2, "Main Menu");