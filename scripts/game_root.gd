extends Node2D

var game_starting = false

const GAME = preload("uid://crn0td2ubi874")

func _ready() -> void:
	SaveLoad.load_game()

func load_game() -> void:
	var game_state = preload("uid://crn0td2ubi874")
	var game = game_state.instantiate()
	print("Game", game)
	add_child(game)
