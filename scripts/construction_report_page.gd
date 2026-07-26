extends CharacterBody2D

var construction_report_dragging = false
var difference = 0.0

signal construction_report_drag_signal

func _ready() -> void:
	connect("construction_report_drag_signal", Callable(self, "_set_construction_report_drag"))

func _process(_delta: float) -> void:
	if construction_report_dragging:
		var mouse_position = get_viewport().get_mouse_position()
		position = mouse_position
		move_and_slide()

func _set_construction_report_drag() -> void:
	construction_report_dragging = !construction_report_dragging

func _on_construction_report_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	var mouse_position = get_viewport().get_mouse_position()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			difference = mouse_position - position
			emit_signal("construction_report_drag_signal")
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			emit_signal("construction_report_drag_signal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()
