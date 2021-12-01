extends MarginContainer


onready var move = $"MarginContainer/GridContainer/SideContainer/leftBar/move"
onready var allow = $"MarginContainer/GridContainer/SideContainer/leftBar/allow"
onready var extra = $"MarginContainer/GridContainer/SideContainer/leftBar/extra"
onready var gun = $"MarginContainer/GridContainer/SideContainer/leftBar/gun"
onready var ip = $"MarginContainer/GridContainer/SideContainer/leftBar/ip"
onready var windows = $"MarginContainer/GridContainer/SideContainer/leftBar/windows"
onready var network = $"MarginContainer/GridContainer/SideContainer/leftBar/network"
onready var arrive = $"MarginContainer/GridContainer/SideContainer/leftBar/exit"


onready var movetag = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/movetag"
onready var allowtag = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/allowtag"
onready var allowimg = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/allowimg"
onready var extratag = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/extratag"
onready var extraimg = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/extraimg"
onready var guntag  = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/guntag"
onready var gunimg = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/gunimg"
onready var iptag = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/iptag"
onready var ipimg = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/ipimg"
onready var windowstag = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/windowstag"
onready var windowsimg = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/windowsimg"
onready var networktag = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/networktag"
onready var networkimg = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/networkimg"
onready var arrivetag = $"MarginContainer/GridContainer/MainContainer/CenterContainer/mainScreen/arive"



var moveComponents = [movetag]
var allowComponents = [allowtag, allowimg]
var extraComponents = [extratag, extraimg]
var gunComponents  = [guntag, gunimg]
var ipComponents  = [iptag, ipimg]
var windowsComponents = [windowstag, windowsimg]
var networkComponents = [networktag, networkimg]
var arriveComponents = [arrivetag]

var allComponents = [moveComponents, allowComponents, extraComponents, gunComponents, ipComponents, windowsComponents, networkComponents, arriveComponents]
var allLabels = [move, allow, extra, gun, ip, windows, network, arrive]


var current_idx = 0


func makeInvis(tag):
	tag.visible = false
	
func makeVis(tag):
	tag.visible = true

func makeWhite(tag):
	tag.modulate = Color(1,1,1)

func makeYellow(tag):
	tag.modulate = Color(1,1,0)

func idxChange(idx):
	for tag in allLabels:
		print(tag)
		makeWhite(tag)
	
	for comp in allComponents:
		for compTag in comp:
			makeInvis(compTag)
	
	makeYellow(allLabels[idx])
	for a in allComponents[idx]:
		makeVis(a)
	
	
func _ready():
	moveComponents = [movetag]
	allowComponents = [allowtag, allowimg]
	extraComponents = [extratag, extraimg]
	gunComponents  = [guntag, gunimg]
	ipComponents  = [iptag, ipimg]
	windowsComponents = [windowstag, windowsimg]
	networkComponents = [networktag, networkimg]
	arriveComponents = [arrivetag]

	allComponents = [moveComponents, allowComponents, extraComponents, gunComponents, ipComponents, windowsComponents, networkComponents, arriveComponents]
	allLabels = [move, allow, extra, gun, ip, windows, network, arrive]
	idxChange(current_idx)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_up") and current_idx > 0:
		current_idx -= 1
		idxChange(current_idx)
	elif Input.is_action_just_pressed("ui_down") and current_idx < 7:
		current_idx += 1
		idxChange(current_idx)

	if Input.is_action_just_pressed("ui_accept"):
		if current_idx  == 7:
			get_tree().change_scene("res://Scenes/gui/title.tscn")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
