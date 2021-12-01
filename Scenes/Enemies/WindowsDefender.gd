extends KinematicBody2D

onready var path_follow = get_parent()
signal die
signal kill_windows
export var _speed = 0

func _physics_process(delta):
	path_follow.set_offset(path_follow.get_offset() + _speed * delta)


func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		body.die()


func _on_Area2D3_body_entered(body):
	if body.name == "Player":
		body.die()
		
func _on_Area2D4_body_entered(body):
	if body.name == "Player":
		body.die()

func die():
	$DeathMusic.play()
	var pickup = load("res://Scenes/Pickups/Pickup.tscn")
	var scene_instance = pickup.instance()
#	get_node("CollisionShape2D").queue_free()
	$"AnimationPlayer".play("kill_windows")
	yield(get_tree().create_timer(0.2), "timeout")
	if Variables.current_scene == 1:
		get_parent().add_child(scene_instance)
	queue_free()

func _on_Area2D_body_entered(body):
	if body and body.name == "Player":
		die()
