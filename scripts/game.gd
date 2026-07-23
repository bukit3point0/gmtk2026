extends Node2D

func pause_trigger():
	var clock_node = get_node("Level1/Background/TextureRect/Clock")
	clock_node.pause_countdown = true
	var pauseMenu = get_node("PauseMenu")
	pauseMenu.visible = true

func unpause():
	var clock_node = get_node("Level1/Background/TextureRect/Clock")
	clock_node.pause_countdown = false
	clock_node.countdown()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If escape is pressed it triggers the func to pause timer and open pause menu
	if Input.is_action_just_pressed("Escape"):
		pause_trigger()
	pass
