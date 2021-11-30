extends Node2D

var done = false


func _ready():
	$"bg".play()

func _process(delta):
	if not done and Variables.powers[1]:
		$Teleporter32.queue_free()
		$Teleporter34.visible = true
		done = true
