extends KinematicBody2D
export var ACC = 1024
export var MAX_SPEED = 128
export var FRICTION = 0.25
export var AIR_RESIST = 0.02
export var GRAVITY = 300
export var JUMP_FORCE = 256

var motion = Vector2.ZERO

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		motion.x += x_input * ACC * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		
	motion.y += GRAVITY * delta
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESIST)
	
	motion = move_and_slide(motion, Vector2.UP)
