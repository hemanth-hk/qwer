extends Node2D

func _ready():
	var current_level = int(get_tree().get_current_scene().name[get_tree().get_current_scene().name.length()-1])
	var teleporter = int(self.name[self.name.length()-1])
	if(current_level == 2 and teleporter==4):
		get_node("AnimatedSprite").play("close")
	else:
		get_node("AnimatedSprite").play("open")
	

func _on_Area2D_body_entered(body):
	var teleporter = int(self.name[self.name.length()-1])
	if body.name == "Player":
		body.change_scene(teleporter+1)
