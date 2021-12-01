extends Area2D
	
var windows_defender = preload("res://Scenes/Enemies/WindowsDefenderWithStraightPath.tscn")
var request = preload("res://Scenes/Enemies/Request.tscn")

func spawn():
	
	var arr1 = [get_children()[5], get_children()[6], get_children()[7], get_children()[8], get_children()[9]]
	var arr2 = [get_children()[10], get_children()[11], get_children()[12], get_children()[13], get_children()[14]]
	randomize()
	var rand_value_1 = arr1[randi() % arr1.size()]
	var rand_value_2 = arr2[randi() % arr2.size()]
	var windows_defender_instance = windows_defender.instance()
#	windows_defender_instance.direction = ($WindowsPosition1.global_position-global_position).normalized()
	windows_defender_instance.global_position = rand_value_1.global_position
	windows_defender_instance.rotation_degrees = self.rotation_degrees
	
	var request_instance = request.instance()
#	windows_defender_instance.direction = ($WindowsPosition1.global_position-global_position).normalized()
	request_instance.global_position = rand_value_2.global_position
	request_instance.rotation_degrees = self.rotation_degrees
	request_instance.scale = 2*request_instance.scale
	var arr3 = [0,1,2,3,4]
	var rand_value_3 = arr3[randi() % arr3.size()]
	
	if rand_value_3 == Variables.enemy_spawn[0]  or rand_value_3 == Variables.enemy_spawn[1]:
		$AnimatedSprite.play("windows")
		get_tree().get_root().add_child(windows_defender_instance)
	elif rand_value_3 == Variables.enemy_spawn[2] or rand_value_3 == Variables.enemy_spawn[3]:
		$AnimatedSprite.play("request")
		get_tree().get_root().add_child(request_instance)
	else:
		$AnimatedSprite.play("default")
	

func _ready():
	$Timer.start(1)
	
func _on_Timer_timeout():
	var val = get_node("../bg/ProgressBar/ProgressBar2").value
	if val<66:
		var arr1=[0,1,2]
		arr1.shuffle()
		Variables.powers[arr1[0]] = false
		Variables.powers[arr1[1]] = true
		Variables.powers[arr1[2]] = true
	if val<33:
		var arr1=[0,1,2]
		arr1.shuffle()
		Variables.powers[arr1[0]] = false
		Variables.powers[arr1[1]] = false
		Variables.powers[arr1[2]] = true
	if not Variables.dialog_started:
		spawn()
#	get_node("../bg/ProgressBar").decrease_value(2)
	$Timer.start(6)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.die()
		
func _on_Area2D_area_entered(area):
	if area.name == "PlayerBullet":
		get_node("../bg/ProgressBar").decrease_value(2)
		area.queue_free()
	elif area.name == "Bullet":
		get_node("../bg/ProgressBar").decrease_value(5)
		area.queue_free()
	var val = get_node("../bg/ProgressBar/ProgressBar2").value
	if val<=0:
		get_tree().change_scene("res://Scenes/Story/end.tscn")	
