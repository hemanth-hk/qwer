extends Node2D

signal teleport

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		emit_signal("teleport")
