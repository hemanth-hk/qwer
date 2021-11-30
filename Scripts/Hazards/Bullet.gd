extends Area2D

export var direction = Vector2.RIGHT
export var speed = 120
var target = null
var target_name = ""

func _physics_process(delta):
	translate(direction*speed*delta)
	speed = 120
#	print(target)
	if target:
		direction = target.global_position - global_position
		direction = direction.normalized()
		speed= 80
		look_at(target.global_position)


func _on_Bullet_body_entered(body):
	if body.name == 'Player':
		body.die()
	queue_free()

func _on_Aiming_Area_body_entered(body):
	target = body
	target_name = body.name

func _on_VisibilityNotifier2D_screen_exited():
	speed = 160

func _on_Aiming_Area_body_exited(body):
	target = null
