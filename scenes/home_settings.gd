extends VBoxContainer

@onready var settings: Node2D = $"../../Settings"

func _on_play_game_button_pressed() -> void:
	var game_root = owner.owner
	game_root.load_game()

func _on_settings_button_pressed() -> void:
	settings.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()
