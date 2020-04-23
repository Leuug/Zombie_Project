extends Node

var enimietarget
var score = 0
var _change_scene

func _process(_delta):
	if score == 20:
		_change_scene = get_tree().change_scene("res://Scenes/Menus/Yey.tscn")
