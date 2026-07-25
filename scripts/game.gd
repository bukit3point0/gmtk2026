extends Node2D

func pause_trigger():
	EventBus._pause.emit()
	var pauseMenu = get_node("PauseMenu")
	print("pause ", pauseMenu)
	pauseMenu.visible = true

func unpause():
	EventBus._unpause.emit()

func _process(_delta: float) -> void:
	# If escape is pressed it triggers the func to pause timer and open pause menu
	if Input.is_action_just_pressed("Escape"):
		pause_trigger()
