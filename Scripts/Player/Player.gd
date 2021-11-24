#extends KinematicBody2D
#export var ACC = 1024
#export var MAX_SPEED = 128
#export var FRICTION = 0.25
#export var AIR_RESIST = 0.02
#export var GRAVITY = 500
#export var JUMP_FORCE = 256
#
#var motion = Vector2.ZERO
#
#func _physics_process(delta):
#	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#
#	if x_input != 0:
#		motion.x += x_input * ACC * delta
#		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
#
#	motion.y += GRAVITY * delta
#
#	if is_on_floor():
#		if x_input == 0:
#			motion.x = lerp(motion.x, 0, FRICTION)
#		if Input.is_action_just_pressed("ui_up"):
#			motion.y = -JUMP_FORCE
#	else:
#		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
#			motion.y = -JUMP_FORCE/2
#		if x_input == 0:
#			motion.x = lerp(motion.x, 0, AIR_RESIST)
#
#	motion = move_and_slide(motion, Vector2.UP)

extends KinematicBody2D


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

func _physics_process(_delta):
	if not dead:
		var move_dir = 0
	#	print(get_node("MovementParticles").process_material.initial_velocity)
		if gun_allowed and Input.is_action_just_pressed("ui_mouse_left"):
			fire()
		if Input.is_action_pressed("ui_right"):
			move_dir += 1
		if Input.is_action_pressed("ui_left"):
			move_dir -= 1
		if move_dir != 0:
			motion += move_dir * ACC * _delta
			motion = clamp(motion, -MOVE_SPEED, MOVE_SPEED)
			
		var grounded = is_on_floor()
		if move_dir == 0:
			get_node("MovementParticles").emitting = false
		else:
			get_node("MovementParticles").emitting = true
			if move_dir == 1:
				get_node("MovementParticles").process_material.initial_velocity = abs(motion)/10 * _delta
				get_node("MovementParticles").set_rotation_degrees(-180)
			if move_dir == -1:
				get_node("MovementParticles").process_material.initial_velocity = abs(motion)/10 * _delta
				get_node("MovementParticles").set_rotation_degrees(0)
			
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

func die():
	dead = true
	get_node("MovementParticles").emitting = false
	$"AnimationPlayer".play("death")
	yield(get_tree().create_timer(0.2), "timeout")
	get_node("DeathParticles").emitting = true
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")
#	$"Sprite/AnimatedSprite".play("default")

func _on_WindowsDefender_die():
	die()

func fire():
	var bullet_scene = load("res://Scenes/Hazards/PlayerBullet.tscn")
	var bullet = bullet_scene.instance()
	bullet.transform = transform
	print(position)
	print(self.position)
	get_parent().add_child(bullet)

func change(level):
	print(level)
	if(level==1):
		NUMOFJUMPS = 3
		$"Sprite/AnimatedSprite".play("triplejump")
	if(level==3):
		$"Sprite/AnimatedSprite".play("gun")
		gun_allowed = true
		
func change_scene(level):
	get_tree().change_scene("res://Scenes/Levels/Level" + str(level) + ".tscn")
