extends StaticBody2D

func _on_Area2D_area_entered(area):
	if area.name == "PlayerBullet":
		$AnimationPlayer.play("destroy")
		yield(get_tree().create_timer(1.5), "timeout")
		queue_free()
	elif area.name == "Bullet":
		queue_free()
