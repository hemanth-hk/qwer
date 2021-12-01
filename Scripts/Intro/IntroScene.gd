extends Control	

func _ready():
	OS.window_fullscreen = true
	$"AnimationPlayer".play("twinkle")
	yield(get_tree().create_timer(4), "timeout")
	get_tree().change_scene("res://Scenes/Story/arcticCodeVault.tscn")

func _input(event):
	OS.window_fullscreen = true
