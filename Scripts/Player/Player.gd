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

export var fire_rate = 0.6

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
var can_fire = false

func _physics_process(_delta):
	if not Variables.powers[1]:
		$"Node2D".visible = false
		
	if not Variables.powers[2]:
		$"Area2D".visible = false
	if not dead:
		if Variables.powers[2] == true:
			$"Sprite/AnimatedSprite".play("reflect")
		elif Variables.powers[1] == true:
			$"Sprite/AnimatedSprite".play("gun")
		elif Variables.powers[0] == true:
			$"Sprite/AnimatedSprite".play("triplejump")
			
		var move_dir = 0
		if Variables.powers[0]:
			NUMOFJUMPS = 3
	#	print(get_node("MovementParticles").process_material.initial_velocity)
		if Variables.powers[1] and Input.is_action_just_pressed("ui_mouse_left") and can_fire:
			fire()
		if Input.is_action_pressed("ui_right"):
			move_dir += 1
			$Node2D/Position2D.position = Vector2(18,0)
			$Node2D/Sprite.position = Vector2(18,0)
			$Node2D/Sprite.rotation_degrees = 0
			$Area2D.rotation_degrees = 0
		if Input.is_action_pressed("ui_left"):
			move_dir -= 1
			$Node2D/Position2D.position = Vector2(-20,0)
			$Node2D/Sprite.position = Vector2(-20,0)
			$Node2D/Sprite.rotation_degrees = 180
			$Area2D.rotation_degrees = 180
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
	Variables.deaths+=1
	$DeathMusic.play()
	get_node("MovementParticles").emitting = false
	$"AnimationPlayer".play("death")
	if Variables.current_scene == 1:
		$"../Level1BG".stop()
		Variables.powers[0] = false
	if Variables.current_scene == 2:
		$"../bg".stop()
	if Variables.current_scene == 3:
		$"../bg".stop()
		Variables.powers[1] = false
	if Variables.current_scene == 4:
		$"../bg".stop()
		Variables.powers[2] = false
	if Variables.current_scene == 5:
		$"../bg".stop()
	
	yield(get_tree().create_timer(0.2), "timeout")
	get_node("DeathParticles").emitting = true
	yield(get_tree().create_timer(1), "timeout")
	if Variables.current_scene == 1:
		get_tree().change_scene("res://Scenes/Levels/defender.tscn")
	if Variables.current_scene == 2 or Variables.current_scene == 4:
		get_tree().change_scene("res://Scenes/Levels/github.tscn")
	if Variables.current_scene == 3:
		get_tree().change_scene("res://Scenes/Levels/reddit.tscn")
	if Variables.current_scene == 5:
		get_tree().change_scene("res://Scenes/Levels/stackoverflow.tscn")
#	$"Sprite/AnimatedSprite".play("default")

func _on_WindowsDefender_die():
	die()

func fire():
	var bullet_scene = load("res://Scenes/Hazards/PlayerBullet.tscn")
	var bullet = bullet_scene.instance()
	print(get_viewport().get_mouse_position().angle_to_point(position))
	print(position)
#	bullet.direction = ($Node2D/Position2D.global_position-global_position).normalized()
	bullet.global_position = $Node2D/Position2D.global_position
	bullet.rotation_degrees = self.rotation_degrees
	get_tree().get_root().add_child(bullet)
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true
#	bullet.transform = $Sprite/Position2D.transform
#	get_parent().add_child(bullet)
	

func change(level):
	print(level)
	if(level==1):
		$"Sprite/AnimatedSprite".play("triplejump")
		Variables.powers[0] = true
		$"pickup".play()
	if(level==3):
		$"Sprite/AnimatedSprite".play("gun")
		Variables.powers[1] = true
		$"Node2D".visible = true
	if(level==4):
		$"Sprite/AnimatedSprite".play("reflect")
		Variables.powers[2] = true
		$"Area2D".visible = true
		
func change_scene(level):
	if level == 1:
		get_tree().change_scene("res://Scenes/Levels/defender.tscn")
	if level == 2 or level == 4:
		get_tree().change_scene("res://Scenes/Levels/github.tscn")
	if level == 3:
		get_tree().change_scene("res://Scenes/Levels/reddit.tscn")
	if level == 5:
		get_tree().change_scene("res://Scenes/Levels/stackoverflow.tscn")


func _on_Area2D_area_entered(area):
	if "Bullet" in area.name and Variables.powers[2]:
		area.queue_free()
