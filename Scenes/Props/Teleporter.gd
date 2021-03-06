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
	print("Tele " + str(teleporter))
	if body.name == "Player":
		if Variables.current_scene == teleporter:
			teleporter -= 1
		if Variables.current_scene == 3 and Variables.powers[1] == false:
			teleporter = 2
		Variables.current_scene = teleporter
		body.change_scene(teleporter)
