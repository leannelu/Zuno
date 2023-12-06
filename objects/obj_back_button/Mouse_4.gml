/// @description Insert description here
// You can write your code in this editor

audio_play_sound(snd_button, 1, 0);
if(room = rm_instructions)
{
	room_goto(rm_menu);
}
else
{
	room_goto(rm_instructions);	
}
