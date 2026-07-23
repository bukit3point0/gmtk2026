extends Node2D

var level_time = 15 # 5m in seconds as a default for now

@onready var clock_time: RichTextLabel = $Sprite2D/MarginContainer/RichTextLabel

func _ready() -> void:
	countdown()

func countdown() -> void:
	var launch_countdown = get_parent().get_node("LaunchCountdown")
	set_time_on_clock()
	await get_tree().create_timer(1.0).timeout
	while level_time > 0:
		print("level_time", level_time)
		level_time -= 1
		set_time_on_clock()
		await get_tree().create_timer(1.0).timeout
		print("level_time", level_time)
		if level_time <= 11:
			launch_countdown.show_countdown_timer(level_time - 1)
		print(" ")

func set_time_on_clock() -> void:
	var minutes = int(floor(level_time / 60.0))
	var seconds = level_time % 60
	if minutes < 10:
		minutes = "0" + str(minutes)
	else:
		minutes = str(minutes)
	if seconds < 10:
		seconds = "0" + str(seconds)
	else:
		seconds = str(seconds)
	clock_time.text = minutes + ":" + seconds
	
