extends Sprite2D

var speed = 200

func _ready() -> void:
	EventBus.connect("_countdown_ended", rocket)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func rocket(delta: float) -> void:
	position.y -= speed * delta
	
	if position.y < -120:
		queue_free()
