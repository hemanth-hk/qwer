extends Node2D


func dioded(name):
	Variables.dialog_started = false

func _ready():
	$"AnimationPlayer".play("plat")
	$"bgmusic".play()
	if not Variables.lvl5_done:
		Variables.dialog_started = true
		var new_dialog = Dialogic.start('dio')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "dioded")
		Variables.lvl5_done = true
	
