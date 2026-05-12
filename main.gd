extends Node

@export var coin_sence : PackedScene
@export var playtime = 30


var level =1 
var score = 0
var time_left = 0
var screen_size = Vector2.ZERO
var playing = false

@onready var ui = $CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size
	$Player.screenSize = screen_size
	$Player.hide()
	ui.update_score(score)
	ui.update_timer(time_left)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playing and get_tree().get_nodes_in_group("coins").size() == 0:
		level +=1
		time_left += level + 10 +1
		spwan_coins()

func new_game():
	playing = true
	level = 1
	score = 0
	time_left =  playtime
	$Player.start()
	$Player.show()
	$GameTimer.start()
	spwan_coins()
	

	
func spwan_coins():
	for i in level + 4:
		var coin = coin_sence.instantiate()
		add_child(coin)
		coin.screenSize = screen_size
		coin.position = Vector2(randi_range(0,screen_size.x),randi_range(0,screen_size.y))

func game_over():
	playing = false
	$GameTimer.stop()
	get_tree().call_group("coins","queue_free")
	ui.show_game_over()
	$Player.die()


func _on_game_timer_timeout() -> void:
	time_left -=1
	print(time_left)
	ui.update_timer(time_left)
	if time_left <= 0:
		game_over()






func _on_canvas_layer_start_game() -> void:
	new_game()


func _on_player_pickup() -> void:
	score += 1
	ui.update_score(score)
	


func _on_player_hurt() -> void:
	game_over()
