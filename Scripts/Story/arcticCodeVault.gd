extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://Scenes/Story/storyStart.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
