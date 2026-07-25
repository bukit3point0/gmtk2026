extends Node2D

@export var report_data: Report

func _ready():
	$Text.text = report_data.contents

func get_problem_level() -> int:
	return report_data.condition
