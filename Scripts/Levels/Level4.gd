extends Node2D

var chosen
var pickup = preload("res://Scenes/Pickups/Pickup.tscn")
var done = false


func done_with_this(name):
	Variables.dialog_started = false

func _ready():
	$"bg".play()
	Variables.dialog_started = true
	var new_dialog = Dialogic.start('destro')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "done_with_this")
	


func _process(delta):
	if not done and len($Requests.get_children()) == 0:
		var pickup_scene = pickup.instance()
#		pickup_scene.global_position = $Node2D/Position2D.global_position
		$Node2D.add_child(pickup_scene)
		done = true
