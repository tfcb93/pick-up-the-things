extends Node

# signal for when a collectable is picked
signal _collectable_picked;

#
signal _count_down_start;

signal _count_down_end;

# start timer of the game
signal _timer_start;

# after finished everything, dispatch the timerEnd event
signal _timer_end;

# Win event
signal _win;

# Lose event
signal _lose;
