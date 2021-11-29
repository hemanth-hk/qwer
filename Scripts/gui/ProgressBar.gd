extends ProgressBar

func _ready():
	set_process(false)

func set_bar_value(value_to_set):
	value = value_to_set
	$Timer.start()
	if(value_to_set > $ProgressBar2.value):
		$ProgressBar2.value = value_to_set

func _on_Timer_timeout():
	set_process(true)

func _process(delta):
	$ProgressBar2.value = lerp($ProgressBar2.value, value, 0.1)
	if($ProgressBar2.value - value <=0.5):
		$ProgressBar2.value = value
		set_process(false)

func decrease_value(dec_val):
	set_bar_value(value - dec_val)
