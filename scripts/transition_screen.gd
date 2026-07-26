extends Node2D

@onready var label = $WinLossMessage

func launch_bad(text):
	label.text = text
	$RocketExplosion.play()

func launch_good(text):
	$Cheering.play()
	await get_tree().create_timer(4.0).timeout
	$RocketLaunch.play()
	
func stop_bad(text):
	label.text = text
	$Relief.play()
	
func stop_good(text):
	label.text = text
	$Booing.play()
	
