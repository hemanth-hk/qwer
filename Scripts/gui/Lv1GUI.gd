extends CanvasLayer


onready var tri = $"MainContainer/tri"
onready var gun = $"MainContainer/gun"
onready var ref = $"MainContainer/ref"

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
		
