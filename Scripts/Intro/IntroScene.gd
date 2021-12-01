extends Control
	
func _ready():
	$"AnimationPlayer".play("twinkle")
	yield(get_tree().create_timer(4), "timeout")
	get_tree().change_scene("res://Scenes/Story/arcticCodeVault.tscn")
