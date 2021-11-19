extends KinematicBody2D

onready var path_follow = get_parent()
signal die
export var _speed = 0

func _physics_process(delta):
	path_follow.set_offset(path_follow.get_offset() + _speed * delta)


func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		emit_signal("die")
