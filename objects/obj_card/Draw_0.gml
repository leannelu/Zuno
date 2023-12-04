/// @description Insert description here
// You can write your code in this editor

if(abs(x - target_x) > 1)
{
	x = lerp(x, target_x, 0.2);
	depth = -1000;
}
else
{
	x = target_x;
	depth = target_depth;
}

if(abs(y - target_y) > 1)
{
	y = lerp(y, target_y, 0.2);
	depth = -1000;
}
else
{
	y = target_y;
	depth = target_depth;
}

draw_self();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if(!face_up) sprite_index = spr_back;
else 
{
	sprite_index = asset_get_index("spr_" + card_color);
	if(number == 12)
	{
		draw_set_font(fnt_plus);
		draw_text(x + sprite_width / 2, y + sprite_height / 2, "+4");
	}
	else if(number == 13)
	{
		sprite_index = asset_get_index("spr_" + card_color + "_swap");
	}
	else if(number == 14)
	{
		sprite_index = asset_get_index("spr_" + card_color + "_shield");
	}
	else if(number == 15)
	{
		draw_set_font(fnt_small);
		draw_text(x + sprite_width / 2, y + sprite_height / 2, "Oops,\nall\n__s!");
	}
	else if(number == 10)
	{
		sprite_index = asset_get_index("spr_" + card_color + "_skip");
	}
	else if(number == 11)
	{
		sprite_index = asset_get_index("spr_" + card_color + "_lined");
		draw_set_font(fnt_plus);
		draw_text(x + sprite_width / 2, y + sprite_height / 2 - 10, "+2");
		draw_set_font(fnt_small_nums);
		draw_text(x + 14, y + 11, "+2");
		draw_text(x + 67, y + 114, "+2");
	}
	else if (!wild)
	{
		sprite_index = asset_get_index("spr_" + card_color + "_lined");
		draw_set_font(fnt_score);
		draw_text(x + sprite_width / 2, y + sprite_height / 2 - 5, string(number));
		draw_set_font(fnt_small_nums);
		draw_text(x + 12, y + 12, string(number));
		draw_text(x + 68, y + 113, string(number));
	}
}
if(highlight)
{
	draw_sprite(spr_highlight, 0, x - 2, y - 2);
}

if(red_outline)
{
	image_index = 1;
	//draw_rectangle_color(x + 3, y + 3, x + 40, y + 65, c_aqua, c_aqua, c_aqua, c_aqua, true);
}
else if(blue_outline)
{
	image_index = 2;
}
else if(yellow_outline)
{
	image_index = 3;
}
else if(green_outline)
{
	image_index = 4;
}
else
{
	image_index = 0;
}