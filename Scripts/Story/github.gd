extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Level1Start".play()
	yield(get_tree().create_timer(3), "timeout")
	if Variables.current_scene == 2:
		get_tree().change_scene("res://Scenes/Levels/Level2.tscn")
	elif Variables.current_scene == 4:
		get_tree().change_scene("res://Scenes/Levels/Level4.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
