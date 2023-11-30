// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/*Allows user to select a card color. Returns the color that is selected, 
or an empty string if nothing is selected. Used to change wild card colors and for "Oops, all __s!"
*/
function changeColor(_middle_card){
	if(mouse_x >= _middle_card.x + 3 && mouse_x <= _middle_card.x + 40 && mouse_y >= _middle_card.y + 3
		&& mouse_y <= _middle_card.y + 65){
		_middle_card.red_outline = true;
		if(mouse_check_button_pressed(mb_left))
		{
			_middle_card.red_outline = false;
			return("red");
		}
	}
	else
	{
		_middle_card.red_outline = false;
	}
	if(mouse_x >= _middle_card.x + 41 && mouse_x <= _middle_card.x + 79 && mouse_y >= _middle_card.y + 3 
		&& mouse_y <= _middle_card.y + 65){
		_middle_card.blue_outline = true;
		if(mouse_check_button_pressed(mb_left))
		{
			_middle_card.blue_outline = false;
			return("blue");
		}
	}
	else
	{
		_middle_card.blue_outline = false;
	}
	if(mouse_x >= _middle_card.x + 3 && mouse_x <= _middle_card.x + 40 && mouse_y >= _middle_card.y + 66 
		&& mouse_y <= _middle_card.y + 128){
		_middle_card.yellow_outline = true;
		if(mouse_check_button_pressed(mb_left))
		{
			_middle_card.yellow_outline = false;
			return("yellow");
		}
	}
	else
	{
		_middle_card.yellow_outline = false;	
	}
	if(mouse_x >= _middle_card.x + 41 && mouse_x <= _middle_card.x + 79 && mouse_y >= _middle_card.y + 66 
		&& mouse_y <= _middle_card.y + 128)
	{
		_middle_card.green_outline = true;
		if(mouse_check_button_pressed(mb_left))
		{
			_middle_card.green_outline = false;
			return("green");
		}
	}
	else
	{
		_middle_card.green_outline = false;	
	}
	return("");
}