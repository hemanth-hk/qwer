extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

const ACC = 2048
const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000
const FRICTION = 0.25
const AIR_RESIST = 0.05
var JUMPED = 0
var motion = 0
var y_velo = 0
var NUMOFJUMPS = 2
var facing_right = false
var dead = false
var gun_allowed = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(_delta):
	if not dead:
		var move_dir = 0
	#	print(get_node("MovementParticles").process_material.initial_velocity)
#		if gun_allowed and Input.is_action_just_pressed("ui_mouse_left"):
#			fire()
		if Input.is_action_pressed("ui_right"):
			move_dir += 1
		if Input.is_action_pressed("ui_left"):
			move_dir -= 1
		if move_dir != 0:
			motion += move_dir * ACC * _delta
			motion = clamp(motion, -MOVE_SPEED, MOVE_SPEED)
			
		var grounded = is_on_floor()

			
		if grounded:
			if move_dir == 0:
				motion = lerp(motion, 0, FRICTION)
		else:
			if Input.is_action_just_released("ui_up") and y_velo < -JUMP_FORCE/2:
				y_velo = -JUMP_FORCE/2
			if move_dir == 0:
				motion = lerp(motion, 0, AIR_RESIST)
				
		move_and_slide(Vector2(motion, y_velo), Vector2(0, -1))
		y_velo += GRAVITY
		if JUMPED < NUMOFJUMPS and Input.is_action_just_pressed("ui_up"):
			JUMPED += 1
			y_velo = -JUMP_FORCE
		if grounded and y_velo >= 0:
			y_velo = 5
			JUMPED = 0
		if y_velo > MAX_FALL_SPEED:
			y_velo = MAX_FALL_SPEED




#func die():
#	dead = true
#	get_node("MovementParticles").emitting = false
#	$"AnimationPlayer".play("death")
#	yield(get_tree().create_timer(0.2), "timeout")
#	get_node("DeathParticles").emitting = true
#	yield(get_tree().create_timer(1), "timeout")
#	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")
##	$"Sprite/AnimatedSprite".play("default")
#
#func _on_WindowsDefender_die():
#	die()
#
#func fire():
#	var bullet_scene = load("res://Scenes/Hazards/PlayerBullet.tscn")
#	var bullet = bullet_scene.instance()
#	bullet.transform = transform
#	print(position)
#	print(self.position)
#	get_parent().add_child(bullet)
#
#func change(level):
#	print(level)
#	if(level==1):
#		NUMOFJUMPS = 3
#		$"Sprite/AnimatedSprite".play("triplejump")
#	if(level==3):
#		$"Sprite/AnimatedSprite".play("gun")
#		gun_allowed = true
#
#func change_scene(level):
#	get_tree().change_scene("res://Scenes/Levels/Level" + str(level) + ".tscn")


func _on_diaArea_body_entered(body):
	if body.name == "KinematicBody2D":
		dead = true
