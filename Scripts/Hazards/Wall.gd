extends StaticBody2D

func _on_Area2D_area_entered(area):
	if "PlayerBullet" in area.name:
		$AnimationPlayer.play("destroy")
		yield(get_tree().create_timer(1.5), "timeout")
		queue_free()
	elif "Bullet" in area.name:
		queue_free()
