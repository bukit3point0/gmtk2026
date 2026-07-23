extends Node2D

const GAME = preload("uid://crn0td2ubi874")

func _ready() -> void:
	SaveLoad.load_game()

func load_game() -> void:
	var game = GAME.instantiate()
	add_child(game)
