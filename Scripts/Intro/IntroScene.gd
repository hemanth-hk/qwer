extends Node2D
	
func _ready():
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")
