extends CharacterBody2D

const FRAME_COUNT = 18

var thermometer_dragging = false
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var noise_timer: float = 0
var target_temp: float

signal thermometer_drag_signal

func _ready() -> void:
	connect("thermometer_drag_signal", Callable(self, "_set_thermometer_drag"))
	EventBus.connect("_set_temp", _on_set_temp)


func _process(delta: float) -> void:
	if thermometer_dragging:
		var mouse_position = get_viewport().get_mouse_position()
		position = Vector2(mouse_position.x, mouse_position.y)
		move_and_slide()
	
	noise_timer -= delta
	if noise_timer <= 0:
		noise_timer = randf_range(0.1, 0.2)
		var twiddled_temp = target_temp + randf_range(-0.1, 0.1)
		var frame = floor(twiddled_temp * FRAME_COUNT)
		frame = min(frame, FRAME_COUNT)
		frame = max(frame, 0)
		sprite.frame = frame

func _on_set_temp(temp: float):
	target_temp = temp
	sprite.frame = floor(temp * FRAME_COUNT)

func _set_thermometer_drag() -> void:
	thermometer_dragging = !thermometer_dragging

func _on_thermometer_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("thermometer_drag_signal")
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			emit_signal("thermometer_drag_signal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()
