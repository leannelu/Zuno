/// @description Insert description here
// You can write your code in this editor

draw_self();
draw_set_font(fnt_score);
draw_text(x + sprite_width / 2, y + sprite_height / 2 - 5, string(number));
draw_set_font(fnt_small_nums);
draw_text(x + 12, y + 12, string(number));
draw_text(x + 68, y + 113, string(number));
