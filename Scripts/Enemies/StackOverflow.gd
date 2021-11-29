extends Area2D
	
var windows_defender = preload("res://Scenes/Enemies/WindowsDefenderWithStraightPath.tscn")
var request = preload("res://Scenes/Enemies/Request.tscn")

func spawn():
	
	var arr1 = [get_children()[5], get_children()[6]]
	var arr2 = [get_children()[7], get_children()[8], get_children()[9]]
	arr1.shuffle()
	arr2.shuffle()
	print(arr1,arr2)
	var windows_defender_instance = windows_defender.instance()
#	windows_defender_instance.direction = ($WindowsPosition1.global_position-global_position).normalized()
	windows_defender_instance.global_position = arr1[0].global_position
	windows_defender_instance.rotation_degrees = self.rotation_degrees
	
	var request_instance = request.instance()
#	windows_defender_instance.direction = ($WindowsPosition1.global_position-global_position).normalized()
	request_instance.global_position = arr2[0].global_position
	request_instance.rotation_degrees = self.rotation_degrees
	var arr3 = [0,1,2,3,4]
	arr3.shuffle()
	
	if arr3[0] == 0:
		$AnimatedSprite.play("windows")
		get_tree().get_root().add_child(windows_defender_instance)
	elif arr3[0] == 1:
		$AnimatedSprite.play("request")
		get_tree().get_root().add_child(request_instance)
	else:
		$AnimatedSprite.play("default")
	

func _ready():
	$Timer.start(1)
	
func _on_Timer_timeout():
	spawn()
	get_node("../bg/ProgressBar").decrease_value(2)
	$Timer.start(4)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.die()
		
func _on_Area2D_area_entered(area):
	if area.name == "PlayerBullet":
		get_node("../bg/ProgressBar").decrease_value(2)
	if area.name == "Bullet":
		get_node("../bg/ProgressBar").decrease_value(5)