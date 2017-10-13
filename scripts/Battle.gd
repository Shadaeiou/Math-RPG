extends Node

# class member variables go here, for example:
var timer      = null
var timerLabel = null

func _ready():
	timerLabel = get_node("TimerLabel");
	timer      = get_node("Timer");
	timer.connect("timeout", self, "_on_timer_timeout");
	timer.set_wait_time(5);
	timer.start();
	
func _on_timer_timeout():
	print("asdf");