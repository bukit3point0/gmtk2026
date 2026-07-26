extends Node2D

var game_starting = false

const GAME = preload("uid://c3cc25nyiaeyd")
const TRANSITION = preload("res://scenes/transition_screen.tscn")

const LEVEL_1 = preload("res://scenes/level1.tscn")
const LEVEL_2 = preload("res://scenes/level2.tscn")
const LEVEL_3 = preload("res://scenes/level3.tscn")

var levels = [LEVEL_1, LEVEL_2, LEVEL_3]

var level_number: int = 0
var current_level
var current_data: ShipProblems

func _ready() -> void:
	SaveLoad.load_game()
	level_number = 0	

func load_game() -> void:
	for child in get_children():
		child.queue_free()

	var level = levels[level_number].instantiate()

	add_child(level)
	level.connect("_win_level", _on_win_level)
	level.connect("_fail_level", _on_fail_level)

	current_level = level
	current_data = level.level_data

	remove_child($Home)

func go_to_transition(win: bool, condition: int):
	current_level.disconnect("_win_level", _on_win_level)
	current_level.disconnect("_fail_level", _on_fail_level)
	remove_child(current_level)

	var transition = TRANSITION.instantiate()
	add_child(transition)
	if win:
		if condition == 0:
			pass # the rocket was fine and it launched
			var victory_text = current_data.launched_good_rocket
			transition.launch_good(victory_text)
		else:
			pass # the rocket had problems but you stopped it
			var victory_text = current_data.stopped_bad_rocket
			transition.stop_bad(victory_text)
	else:
		if condition == 0:
			pass # the rocket was fine but you stopped it for no reason
			var fail_text = current_data.stopped_good_rocket
			transition.stop_good(fail_text)
		else:
			pass # the rocket had issues and you let it launch
			var fail_text = current_data.launched_bad_rocket
			transition.launch_bad(fail_text)

	await get_tree().create_timer(3.0).timeout
	level_number += 1

	remove_child(transition)

	if level_number < 3:
		load_game()
	else:
		transition = TRANSITION.instantiate()
		add_child(transition)
		transition.launch_good("CONGRATUALTIONS")


func _on_win_level(condition: int):
	go_to_transition(true, condition)

func _on_fail_level(condition: int):
	go_to_transition(false, condition)
