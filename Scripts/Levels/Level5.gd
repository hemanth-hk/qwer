extends Node2D


func dioded(name):
	Variables.dialog_started = false

func _ready():
	$"bgmusic".play()
	Variables.dialog_started = true
	var new_dialog = Dialogic.start('dio')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "dioded")
