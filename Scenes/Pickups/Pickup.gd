extends KinematicBody2D

signal pickup

var gravitypickup = 50
var velocitypickup = Vector2(0,0)
func _physics_process(delta):
	 velocitypickup.y += gravitypickup
	 move_and_slide(Vector2(velocitypickup), Vector2(0, -1))


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		var level = int(get_tree().get_current_scene().name[get_tree().get_current_scene().name.length()-1])
		print(get_tree().get_current_scene().name)
		body.change(level)
		queue_free()
