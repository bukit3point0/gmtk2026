extends Sprite2D

var speed = 200
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= speed * delta
	
	if position.y < -100:
		queue_free()
