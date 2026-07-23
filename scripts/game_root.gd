extends Node2D

const GAME = preload("uid://crn0td2ubi874")

func load_game() -> void:
	var game = GAME.instantiate()
	add_child(game)
