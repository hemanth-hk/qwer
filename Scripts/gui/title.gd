extends MarginContainer


onready var indicator_start = $"CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Sprite"
onready var indicator_rules = $"CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Sprite"
var current_idx = 0



# Called when the node enters the scene tree for the first time.
func _ready():
#	yield(get_tree().create_timer(2), "timeout")
#	get_tree().change_scene("res://Scenes/Levels/defender.tscn")
	mark_selection(0)


func mark_selection(select_idx):
	indicator_start.visible  = false
	indicator_rules.visible = false
	if select_idx == 0:
		indicator_start.visible  = true
	if select_idx == 1:
		indicator_rules.visible = true

func _process(delta):
	if Input.is_action_just_pressed("ui_up") and current_idx > 0:
		current_idx -= 1
		mark_selection(current_idx)
	elif Input.is_action_just_pressed("ui_down") and current_idx < 1:
		current_idx += 1
		mark_selection(current_idx)

	if Input.is_action_just_pressed("ui_accept"):
		if current_idx  == 0:
			Variables.optisus.stop()
			get_tree().change_scene("res://Scenes/Levels/defender.tscn")
		elif current_idx == 1:
			get_tree().change_scene("res://Scenes/GUI/Rules.tscn")
