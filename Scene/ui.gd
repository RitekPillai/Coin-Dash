extends CanvasLayer

signal start_game

func update_score(value):
	print(value)
	$score.text = str(value)
	
func update_timer(value):
	$level.text = str(value)

func show_message(value):
	$title.text = value
	$title.show()
	$waitTime.start()

func _on_timer_timeout():
	$title.hide()


	

func show_game_over():
	show_message("Game Over")
	await $waitTime.timeout
	$StartButton.show()
	$title.text = "Coin Dash!"
	$title.show()

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$title.hide()
	start_game.emit()
