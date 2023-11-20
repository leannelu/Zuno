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
/*
if(color_index == 0)
{
	card_color = "blue";	
}
else if(color_index == 1)
{
	card_color = "green";
}
else if(color_index == 2)
{
	card_color = "red";	
}
else
{
	card_color = "yellow";	
}*/

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
		draw_set_font(fnt_plus);
		draw_text(x + sprite_width / 2, y + sprite_height / 2, "+2");
	}
	else if (!wild)
	{
		draw_set_font(fnt_score);
		draw_text(x + sprite_width / 2, y + sprite_height / 2 - 5, string(number));
	}
}

