extends Node2D

var clock

func _ready() -> void:
	clock = get_parent().get_node("Clock")

func _on_confirm_button_pressed() -> void:
	stop_clock()

func _on_reject_button_pressed() -> void:
	stop_clock()

func stop_clock() -> void:
	clock.pause_countdown = true
