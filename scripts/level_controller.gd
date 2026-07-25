extends Node2D
class_name Level

signal _win_level(condition: int)
signal _fail_level(condition: int)

@onready var background: Background = %Background

func _ready() -> void:
	EventBus.connect("_abort_launch", _on_abort_launch)
	EventBus.connect("_confirm_launch", _on_confirm_launch)

func _on_abort_launch() -> void:
	print("Launch aborted")
	background.stop_clock()

	var condition = rocket_condition()
	if condition == 0:
		_win_level.emit(condition)
	else:
		_fail_level.emit(condition)

func _on_confirm_launch() -> void:
	print("Launch confirmed")
	breakpoint

func rocket_condition() -> int:
	var condition: int = 0

	var possible_problems = get_tree().get_nodes_in_group("rocket_problems")
	for problem in possible_problems:
		if problem.has_method("get_problem_level"):
			condition = max(condition, problem.get_problem_level())
			
	return condition

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
