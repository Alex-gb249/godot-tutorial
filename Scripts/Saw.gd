extends Area2D

func _ready():
	$AnimationPlayer.play("RotateSaw")


func _on_body_entered(body):
	if body.get_name() == "Player":
		body.lose_life(position.x)
