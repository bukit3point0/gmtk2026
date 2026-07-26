extends Node2D
class_name Level

signal _win_level(condition: int)
signal _fail_level(condition: int)

@onready var background: Background = %Background

var level_ended: bool = false

func _ready() -> void:
	EventBus.connect("_abort_launch", _on_abort_launch)
	EventBus.connect("_confirm_launch", _on_confirm_launch)
	EventBus.connect("_countdown_ended", _on_countdown_ended)
	EventBus.connect("_pause_screen", pause_button_trigger)


func _on_abort_launch() -> void:
	if level_ended:
		return #ignore further input

	print("Launch aborted")
	background.stop_clock()

	var condition = rocket_condition()
	if condition != 0:
		_win_level.emit(condition)
	else:
		_fail_level.emit(condition)

func _on_confirm_launch() -> void:
	if level_ended:
		return #ignore further input
	
	print("Launch confirmed")
	background.trigger_final_countdown()

func _on_countdown_ended():
	var condition = rocket_condition()
	if condition == 0:
		_win_level.emit(condition)
	else:
		_fail_level.emit(condition)

func rocket_condition() -> int:
	var condition: int = 0

	var possible_problems = get_tree().get_nodes_in_group("rocket_problems")
	for problem in possible_problems:
		if problem.has_method("get_problem_level"):
			condition = max(condition, problem.get_problem_level())
			
	return condition

func pause_trigger():
	EventBus._pause.emit()
	var pauseMenu = get_node("PauseMenu")
	print("pause ", pauseMenu)
	pauseMenu.visible = true

func unpause():
	EventBus._unpause.emit()

func pause_button_trigger():
	pause_trigger()
