extends Node2D

@onready var label = $WinLossMessage

func show_win():
	label.text = "Congratulations engineer!"

func show_fail():
	label.text = "A disaster lies on your hands..."
