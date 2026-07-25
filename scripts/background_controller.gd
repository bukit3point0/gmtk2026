extends Node2D
class_name Background

@onready var clock: Clock = %Clock

func stop_clock() -> void:
	clock.stop_clock()

func trigger_final_countdown():
	clock.set_time(11)
