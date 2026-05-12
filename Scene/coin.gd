extends Area2D

var screenSize = Vector2.ZERO

@onready var audioPlayer = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func  pickup():
	$CollisionShape2D.set_deferred("disabled",true)
	
	$AnimatedSprite2D.hide()
	
	audioPlayer.play()
	
	await audioPlayer.finished
	
	
	queue_free()
