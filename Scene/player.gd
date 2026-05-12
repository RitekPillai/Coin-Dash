extends Area2D
@export var speed = 100
var velocity= Vector2.ZERO
var screenSize = Vector2.ZERO



signal  pickup
signal 	hurt

@onready var sprite =  $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Input.get_vector("left","right","up","down");
	position +=velocity * speed * delta
	
	var direction = Input.get_axis("left","right")
	
	if velocity.length() > 0:
		sprite.animation = "run"
	else:
		sprite.animation = "idle"
	
	if velocity.x !=0:
		sprite.flip_h = velocity.x<0;
	
	
	position.x = clamp(position.x,0,screenSize.x)
	position.y = clamp(position.y,0,screenSize.y)
	

func start():
	set_process(true)
	position = screenSize/2
	sprite.animation = "idle"
	
func die():
	sprite.animation = "hurt"
	if(sprite.animation_finished):
		hide()
	



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit()# board cast it 
	if area.is_in_group("obstacles"):
		hurt.emit()
		die()
