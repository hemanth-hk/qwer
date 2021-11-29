extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_diaArea_body_entered(body):
	print(body.name)
	if body.name == "KinematicBody2D":
		$"Brown".get_node("diaArea").queue_free()
		var new_dialog = Dialogic.start('storystart')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end")
		
		
func end(timeline_name):
	get_tree().change_scene("res://Scenes/GUI/title.tscn")
