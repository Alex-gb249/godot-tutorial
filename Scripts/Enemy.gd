extends CharacterBody2D

var gravity = 10
var speed = 25
var moving_left = true

func _ready():
	$AnimationPlayer.play("Walk")

func _process(delta):
	move_character()
	turn()
	
func move_character():
	velocity.y += gravity
	if moving_left:
		velocity.x = -speed
	else: 
		velocity.x = speed
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.lose_life(position.x)

func turn():
	if not $RayCast2D.is_colliding():
		moving_left = !moving_left
		scale.x = -scale.x
