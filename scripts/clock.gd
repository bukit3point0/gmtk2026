extends Node2D
class_name Clock

var level_time = 150 # seconds

@onready var clock_time: RichTextLabel = $Sprite2D/MarginContainer/RichTextLabel

var pause_countdown = false

func _ready() -> void:
	countdown()
	EventBus.connect("_pause", stop_clock)
	EventBus.connect("_unpause", start_clock)


func stop_clock() -> void:
	pause_countdown = true

func start_clock() -> void:
	pause_countdown = false
	countdown()


func set_time(new_time: int):
	level_time = min(new_time, level_time)
	update_time_on_clock()

func countdown() -> void:
	var launch_countdown = get_parent().get_node("LaunchCountdown")
	update_time_on_clock()
	await get_tree().create_timer(1.0).timeout
	while level_time > 0 and !pause_countdown:
		level_time -= 1
		update_time_on_clock()
		if level_time == 149:
			$OfficeAmbience.play()
			
		if level_time <= 10:
			launch_countdown.show_countdown_timer(level_time)
		
		if level_time == 10:
			$Countdown.play()
		
		if get_tree() != null:
			await get_tree().create_timer(1.0).timeout

func update_time_on_clock() -> void:
	if level_time <= 0:
		level_time = 0
		EventBus._countdown_ended.emit()
	if level_time <= -5:
		stop_clock()

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


	
	
