extends Node2D
class_name Background

@onready var clock: Clock = %Clock
@onready var ship_plate_id_label: RichTextLabel = $TextureRect/ShipPlateId/RichTextLabel

func stop_clock() -> void:
	clock.stop_clock()

func trigger_final_countdown():
	clock.set_time(11)

func _on_button_pressed() -> void:
	EventBus._pause_screen.emit()

func update_ship_plate_id(id: String) -> void:
	ship_plate_id_label.text = id
