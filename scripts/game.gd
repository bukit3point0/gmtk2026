extends Node2D

func _ready() -> void:
	EventBus.connect("_pause_screen", pause_button_trigger)
	
func pause_trigger():
	EventBus._pause.emit()
	var pauseMenu = get_node("PauseMenu")
	print("pause ", pauseMenu)
	pauseMenu.visible = true

func unpause():
	EventBus._unpause.emit()

func pause_button_trigger():
	pause_trigger()
