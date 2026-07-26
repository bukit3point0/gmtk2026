extends Node2D

@onready var confirm_button: TextureButton = $HBoxContainer/ConfirmButton
@onready var reject_button: TextureButton = $HBoxContainer/RejectButton

func _on_confirm_button_pressed() -> void:
	EventBus._confirm_launch.emit()
	confirm_button.offset_transform_position.x = 16
	await get_tree().create_timer(1.0).timeout
	$Button.play()

func _on_reject_button_pressed() -> void:
	EventBus._abort_launch.emit()
	reject_button.offset_transform_position.x = 16
	await get_tree().create_timer(1.0).timeout
	$Button.play()
