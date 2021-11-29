extends KinematicBody2D

var bullet_scene = preload("res://Scenes/Hazards/Bullet.tscn")

func fire():
	var bullet = bullet_scene.instance()
	bullet.direction = ($Node2D/Position2D.global_position-global_position).normalized()
	bullet.global_position = $Node2D/Position2D.global_position
	bullet.rotation_degrees = self.rotation_degrees
	get_tree().get_root().add_child(bullet)
	
func _ready():
	$Timer.start(1)
	
func _on_Timer_timeout():
	fire()
	$Timer.start(2)

func _on_Area2D_body_entered(body):
	if body.name=="Player":
		body.die()

func die():
	yield(get_tree().create_timer(0.1), "timeout")
	$"AnimationPlayer".play("kill_request")
	yield(get_tree().create_timer(0.3), "timeout")
	queue_free()
