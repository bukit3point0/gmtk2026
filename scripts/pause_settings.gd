extends Node2D

@onready var settings = get_node("Settings")

var game_root

signal restart_signal

func _ready() -> void:
	game_root = owner.get_parent()
	connect("restart_signal", Callable(game_root, "load_game"))

#opposite of pause
func _on_resume_button_pressed() -> void:
	var game_script = owner
	game_script.unpause()
	visible = false

func _on_restart_level_button_pressed() -> void:
	emit_signal("restart_signal")

func _on_settings_button_pressed() -> void:
	settings.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()
