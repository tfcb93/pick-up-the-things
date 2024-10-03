extends Node;

signal collectable_picked;

signal count_down_start;
signal count_down_end;

signal timer_start;
signal timer_end;
signal add_time(time: int);

signal win;
signal lose;
signal game_stop;

signal restart_game;

signal is_paused;
signal is_unpaused;


signal invert_mouse(is_inverted: bool);