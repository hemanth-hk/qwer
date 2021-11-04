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

const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000
var JUMPED = 0

var y_velo = 0
var facing_right = false

func _physics_process(_delta):
	var move_dir = 0
	if Input.is_action_pressed("ui_right"):
		move_dir += 1
	if Input.is_action_pressed("ui_left"):
		move_dir -= 1
	
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
	
	var grounded = is_on_floor()
	y_velo += GRAVITY
	if JUMPED < 2 and Input.is_action_just_pressed("ui_up"):
		JUMPED += 1
		y_velo = -JUMP_FORCE
	if grounded and y_velo >= 0:
		y_velo = 5
		JUMPED = 0
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
