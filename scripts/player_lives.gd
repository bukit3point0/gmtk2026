extends Node2D

var lives_left = GlobalVariables.player_lives

@onready var life_1: Sprite2D = $Life1
@onready var life_2: Sprite2D = $Life2
@onready var life_3: Sprite2D = $Life3

func _ready() -> void:
	set_lives()

func set_lives() -> void:
	var player_life = preload("uid://d3th7nm1kllde")
	var lost_life = preload("uid://dnopv2wk5mllr")
	life_1.texture = player_life
	life_2.texture = player_life
	life_3.texture = player_life
	match lives_left:
		2:
			life_1.texture = lost_life
		1:
			life_1.texture = lost_life
			life_2.texture = lost_life

func remove_a_life() -> void:
	GlobalVariables.player_lives -= 1
	set_lives()
