extends Area2D

#signal custom_signal

func _on_body_entered(body):
	if body.get_name() == "Player":
		#custom_signal.emit()
		body.add_coin()
		queue_free()
