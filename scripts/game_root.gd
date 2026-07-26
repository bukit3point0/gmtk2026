extends Node2D

var game_starting = false

const GAME = preload("uid://c3cc25nyiaeyd")
const TRANSITION = preload("res://scenes/transition_screen.tscn")

const LEVEL_2 = preload("res://scenes/level2.tscn")

var current_level

func _ready() -> void:
	SaveLoad.load_game()

func load_game() -> void:
	for child in get_children():
		child.queue_free()
	var level = LEVEL_2.instantiate()
	add_child(level)
	level.connect("_win_level", _on_win_level)
	level.connect("_fail_level", _on_fail_level)
	current_level = level

	remove_child($Home)

func go_to_transition(win: bool, condition: int):
	remove_child(current_level)

	var transition = TRANSITION.instantiate()
	add_child(transition)
	if win:
		if condition == 0:
			pass # the rocket was fine and it launched
		else:
			pass # the rocket had problems but you stopped it
	else:
		if condition == 0:
			pass # the rocket was fine but you stopped it for no reason
		else:
			pass # the rocke had issues and you let it launch

func _on_win_level(condition: int):
	go_to_transition(true, condition)

func _on_fail_level(condition: int):
	go_to_transition(false, condition)
