extends CanvasLayer

var coins = 0
	
var heart1
var heart2
var heart3

func _ready():
	heart1 = get_node("Heart1")
	heart2 = get_node("Heart2")
	heart3 = get_node("Heart3")

func handle_coin_collected():
	coins += 1
	$CoinsCollectedText.text = str(coins)
	
	if coins == 4:
		await get_tree().create_timer(2.0).timeout
		var nextLevel = str(int(str(get_tree().current_scene.name)) + 1)
		print(nextLevel)
		get_tree().change_scene_to_file("res://Scenes/World"+nextLevel+".tscn")

func handle_hearts(lifes):
	if lifes == 0:
		heart1.visible = false
	if lifes == 1:
		heart2.visible = false
	if lifes == 2:
		heart3.visible = false
