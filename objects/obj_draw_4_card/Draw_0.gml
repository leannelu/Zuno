/// @description Insert description here
// You can write your code in this editor

image_speed = 0;
draw_self();
draw_set_font(fnt_plus);
draw_text(x + sprite_width / 2, y + sprite_height / 2 - 10, "+4");
/*draw_set_font(fnt_small_nums);
draw_text(x + 14, y + 11, "+4");
draw_text(x + 67, y + 114, "+4");*/

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_slightly_smaller);
draw_text_ext(x + sprite_width + 185, y + sprite_height / 2, "Draw 4 - A Wild Card. Your opponent must draw 4 cards, and their turn is skipped", 25, 340);

