extends Sprite2D

var speed = 200
var moving = false

func _ready() -> void:
	EventBus.connect("_countdown_ended", launch)

func launch():
	moving = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moving == true:
		position.y -= speed * delta
	
	if position.y < -120:
		queue_free()
		moving = false
