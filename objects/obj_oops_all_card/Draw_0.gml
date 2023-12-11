/// @description Insert description here
// You can write your code in this editor

image_speed = 0;
draw_self();
draw_set_font(fnt_small);
draw_text(x + sprite_width / 2, y + sprite_height / 2, "Oops,\nall\n__s!");
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_slightly_smaller);
draw_text_ext(x + sprite_width + 185, y + sprite_height / 2, "Oops, all __s!- Change the color of all your opponent's non-wild cards, then change this Wild Card's color", 25, 340);
