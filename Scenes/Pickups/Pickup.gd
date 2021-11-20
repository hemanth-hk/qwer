extends KinematicBody2D

signal pickup

var gravitypickup = 50
var velocitypickup = Vector2(0,0)
func _physics_process(delta):
	 velocitypickup.y += gravitypickup
	 move_and_slide(Vector2(velocitypickup), Vector2(0, -1))


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.change(1)
		get_parent().queue_free()
