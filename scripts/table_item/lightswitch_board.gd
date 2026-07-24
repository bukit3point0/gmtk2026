extends CharacterBody2D

var lightswitch_dragging = false

signal lightswitch_drag_signal

func _ready() -> void:
	connect("lightswitch_drag_signal", Callable(self, "_set_lightswitch_drag"))

func _process(_delta: float) -> void:
	if lightswitch_dragging:
		var mouse_position = get_viewport().get_mouse_position()
		position = Vector2(mouse_position.x, mouse_position.y)
		move_and_slide()

func _set_lightswitch_drag() -> void:
	lightswitch_dragging = !lightswitch_dragging

func _on_lightswitch_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	print("input")
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("lightswitch_drag_signal")
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			emit_signal("lightswitch_drag_signal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()


func _on_mouse_entered() -> void:
	print("maus")


func _on_lightswitch_drag_signal() -> void:
	print('drag')
