extends Node2D

func _on_confirm_button_pressed() -> void:
	EventBus._confirm_launch.emit()
	$Button.play()

func _on_reject_button_pressed() -> void:
	EventBus._abort_launch.emit()
	$Button.play()
