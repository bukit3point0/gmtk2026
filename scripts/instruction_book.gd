extends CharacterBody2D

@onready var tab_1_animation: AnimatedSprite2D = $Tab1Animation

var instruction_book_dragging = false
var tab_1_opened = false

signal instruction_book_drag_signal

func _ready() -> void:
	connect("instruction_book_drag_signal", Callable(self, "_set_instruction_book_drag"))

func _process(_delta: float) -> void:
	if instruction_book_dragging:
		var mouse_position = get_viewport().get_mouse_position()
		position = Vector2(mouse_position.x, mouse_position.y)
		move_and_slide()

func _set_instruction_book_drag() -> void:
	instruction_book_dragging = !instruction_book_dragging

func _on_instruction_book_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("instruction_book_drag_signal")
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			emit_signal("instruction_book_drag_signal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()

func _on_button_pressed() -> void:
	tab_1_animation.play("close_tab") if tab_1_opened else tab_1_animation.play("open_tab")
	tab_1_opened = !tab_1_opened
