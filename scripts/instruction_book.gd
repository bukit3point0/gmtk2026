extends CharacterBody2D

@onready var tab_1_animation: AnimatedSprite2D = $Pages/Thermometer/Tab1Animation
@onready var tab_1_animation_player: AnimationPlayer = $Pages/Thermometer/AnimationPlayer
@onready var tab_2_animation: AnimatedSprite2D = $Pages/Cody1/Tab2Animation
@onready var tab_2_animation_player: AnimationPlayer = $Pages/Cody1/AnimationPlayer
@onready var tab_3_animation: AnimatedSprite2D = $Pages/Cody2/Tab3Animation
@onready var tab_3_animation_player: AnimationPlayer = $Pages/Cody2/AnimationPlayer

var instruction_book_dragging = false
var currently_open_tab = 1
var tab_1_opened = false
var tab_2_opened = false
var tab_3_opened = false

signal instruction_book_drag_signal

func _ready() -> void:
	connect("instruction_book_drag_signal", Callable(self, "_set_instruction_book_drag"))
	play_tab_1()

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

func _on_tab_1_button_pressed() -> void:
	if currently_open_tab != 1:
		play_tab_1()
	currently_open_tab = 1
	close_other_tabs()
	tab_1_opened = true

func _on_tab_2_button_pressed() -> void:
	if currently_open_tab != 2:
		play_tab_2()
	currently_open_tab = 2
	close_other_tabs()
	tab_2_opened = true

func _on_tab_3_button_pressed() -> void:
	if currently_open_tab != 3:
		play_tab_3()
	currently_open_tab = 3
	close_other_tabs()
	tab_3_opened = true

func close_other_tabs() -> void:
	match currently_open_tab:
		1:
			play_tab_2(false)
			play_tab_3(false)
		2:
			play_tab_1(false)
			play_tab_3(false)
		3:
			play_tab_1(false)
			play_tab_2(false)

func play_tab_1(open: bool = true) -> void:
	if tab_1_opened and !open:
		tab_1_animation.play("close_tab")
		tab_1_animation_player.play("close_tab")
	elif !tab_1_opened and open:
		tab_1_animation.play("open_tab")
		tab_1_animation_player.play("open_tab")
	tab_1_opened = open

func play_tab_2(open: bool = true) -> void:
	if tab_2_opened and !open:
		tab_2_animation.play("close_tab")
		tab_2_animation_player.play("close_tab")
	elif !tab_2_opened and open:
		tab_2_animation.play("open_tab")
		tab_2_animation_player.play("open_tab")
	tab_2_opened = open

func play_tab_3(open: bool = true) -> void:
	if tab_3_opened and !open:
		tab_3_animation.play("close_tab")
		tab_3_animation_player.play("close_tab")
	elif !tab_3_opened and open:
		tab_3_animation.play("open_tab")
		tab_3_animation_player.play("open_tab")
	tab_3_opened = open
