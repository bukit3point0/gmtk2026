extends Node2D

var game_starting = false

const GAME = preload("uid://crn0td2ubi874")
const TRANSITION = preload("res://scenes/transition_screen.tscn")

const LEVEL_2 = preload("res://scenes/level2.tscn")

var current_level

func _ready() -> void:
	SaveLoad.load_game()

func load_game() -> void:
	var level = LEVEL_2.instantiate()
	add_child(level)
	level.connect("_win_level", _on_win_level)
	level.connect("_fail_level", _on_fail_level)
	current_level = level

	remove_child($Home)

func go_to_transition(win: bool):
	remove_child(current_level)

	var transition = TRANSITION.instantiate()
	add_child(transition)
	if win:
		transition.show_win()
	else:
		transition.show_fail()

func _on_win_level(_condition: int):
	go_to_transition(true)

func _on_fail_level(_condition: int):
	go_to_transition(false)
