extends Node2D
class_name Level

signal _win_level(condition: int)
signal _fail_level(condition: int)

@onready var bulbs_and_switches: Node2D = $Game/Table/BulbsAndSwitches
@onready var wires: Node2D = $Game/Table/Wires
@onready var background: Background = %Background

@export var level_data: ShipProblems

var level_ended: bool = false

const LEVEL_END_DELAY = 4

func _ready() -> void:
	EventBus.connect("_abort_launch", _on_abort_launch)
	EventBus.connect("_confirm_launch", _on_confirm_launch)
	EventBus.connect("_countdown_ended", _on_countdown_ended)
	EventBus.connect("_pause_screen", pause_button_trigger)
	wires.update_wires(level_data.wires_array)
	background.update_ship_plate_id(level_data.ship_plate_id)
	bulbs_and_switches.set_initial_switches(level_data.switches_on)
	bulbs_and_switches.set_step_results(level_data.nsc1, level_data.temperature_test, level_data.final)

func _on_abort_launch() -> void:
	if level_ended:
		return # ignore further input

	print("Launch aborted")
	background.stop_clock()

	var condition = rocket_condition()
	if condition != 0:
		_win_level.emit(condition)
	else:
		_fail_level.emit(condition)

func _on_confirm_launch() -> void:
	if level_ended:
		return # ignore further input
	
	print("Launch confirmed")
	background.trigger_final_countdown()

func _on_countdown_ended():
	var condition = rocket_condition()
	if condition == 0:
		await get_tree().create_timer(LEVEL_END_DELAY).timeout
		_win_level.emit(condition)
	else:
		await get_tree().create_timer(LEVEL_END_DELAY).timeout
		_fail_level.emit(condition)

func rocket_condition() -> int:
	var condition: int = 0

	if get_tree() == null:
		return 0
		
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
