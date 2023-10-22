extends CharacterBody2D

const moveSpeed = 25
const maxSpeed = 50

const jumpHeight = -300
const up = Vector2(0,-1)
const gravity = 15

@onready
var sprite = $Sprite2D
@onready
var animationPlayer = $AnimationPlayer

signal custom_signal

var lifes = 3

@onready
var canvasLayer = get_node("/root/World1/CanvasLayer")

func _physics_process(_delta):
	velocity.y += gravity
	var friction = false

	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = true
		animationPlayer.play("Walk")
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)

	elif Input.is_action_pressed("ui_left"):
		sprite.flip_h = false
		animationPlayer.play("Walk")
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)

	else:
		animationPlayer.play("Idle")
		friction = true

	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = jumpHeight
			custom_signal.emit()
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.5)
	else:
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.01)

	move_and_slide()

func add_coin():
	var canvasLayer = get_node("../CanvasLayer")
	canvasLayer.handle_coin_collected()

func _on_spikes_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()

func lose_life(enemyPositionX):
	if position.x < enemyPositionX:
		velocity.x = -200
		velocity.y = -100
		
	if position.x > enemyPositionX:
		velocity.x = 200
		velocity.y = -100
		
	lifes = lifes-1
	
	canvasLayer.handle_hearts(lifes)
	
	if lifes <= 0:
		get_tree().reload_current_scene()
