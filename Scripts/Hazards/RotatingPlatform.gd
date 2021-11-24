extends Node2D

func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		$AnimationPlayer.play("rotate")

func _on_Area2D_area_entered(area):
	get_child(1).queue_free()
