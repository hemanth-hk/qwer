extends Area2D

var speed = 10
var movement = Vector2()
onready var mouse_pos = null

func _ready():
	mouse_pos = get_local_mouse_position()

func _physics_process(delta):
	movement = movement.move_toward(mouse_pos,delta)
	movement = movement.normalized() * speed
	position = position + movement

func _on_PlayerBullet_body_entered(body):
	if body.is_in_group("enemy"):
		body.queue_free()
	queue_free()
