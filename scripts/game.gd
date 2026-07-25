extends Node2D

@onready var background: Background = %Background

func _ready() -> void:
	EventBus.connect("_abort_launch", _on_abort_launch)
	EventBus.connect("_confirm_launch", _on_confirm_launch)

func _on_abort_launch() -> void:
	print("Launch aborted")
	background.stop_clock()

func _on_confirm_launch() -> void:
	print("Launch confirmed")

func pause_trigger():
	var clock_node = get_node("Level1/Background/TextureRect/Clock")
	clock_node.pause_countdown = true
	var pauseMenu = get_node("PauseMenu")
	print("pause ", pauseMenu)
	pauseMenu.visible = true

func unpause():
	var clock_node = get_node("Level1/Background/TextureRect/Clock")
	clock_node.pause_countdown = false
	clock_node.countdown()

func _process(_delta: float) -> void:
	# If escape is pressed it triggers the func to pause timer and open pause menu
	if Input.is_action_just_pressed("Escape"):
		pause_trigger()
