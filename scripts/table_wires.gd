extends CharacterBody2D

var wires_dragging = false

signal wires_drag_signal

func _ready() -> void:
	connect("wires_drag_signal", Callable(self, "_set_wires_drag"))

func _process(_delta: float) -> void:
	if wires_dragging:
		var mouse_position = get_viewport().get_mouse_position()
		position = Vector2(mouse_position.x, mouse_position.y)
		move_and_slide()

func _set_wires_drag() -> void:
	wires_dragging = !wires_dragging

func _on_wires_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("wires_drag_signal")
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			emit_signal("wires_drag_signal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()
