extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	get_node("Test").connect("pressed", self, "_on_test_button_clicked")

func _on_test_button_clicked():
	get_tree().change_scene("res://scenes/Battle.tscn")