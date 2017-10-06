extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Calc_pressed():
	get_tree().change_scene("res://scenes/Calculator.tscn")

func _on_CharSelect_pressed():
	get_tree().change_scene("res://scenes/CharacterSelect.tscn")