extends CanvasLayer


onready var tri = $"tri"
onready var gun = $"gun"
onready var ref = $"ref"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	$"MainContainer/RichTextLabel".text = "Deaths : " + str(Variables.deaths)
	if Variables.powers[0] == false:
		tri.visible = false
	else:
		tri.visible = true
		
	if Variables.powers[1] == false:
		gun.visible = false
	else:
		gun.visible = true
		
	if Variables.powers[2] == false:
		ref.visible = false
	else:
		ref.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
