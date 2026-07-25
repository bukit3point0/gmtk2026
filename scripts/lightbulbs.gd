extends Node2D

@onready var page_1: Node2D = $Page1
@onready var page_2: Node2D = $Page2

func _ready() -> void:
	show_page()

func show_page(page_number: int = 1) -> void:
	page_1.visible = page_number == 1
	page_2.visible = page_number == 2

func _on_next_page_from_1_button_pressed() -> void:
	show_page(2)
