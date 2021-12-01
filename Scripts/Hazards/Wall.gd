extends StaticBody2D

func _on_Area2D_area_entered(area):
	print(area.name)
	if "PlayerBullet" in area.name and Variables.powers[2]:
		$AnimationPlayer.play("destroy")
		yield(get_tree().create_timer(1.5), "timeout")
		queue_free()
#		area.queue_free()
	elif "Bullet" in area.name:
		area.queue_free()
