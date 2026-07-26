extends Node2D

@onready var label = $WinLossMessage

func show_win():
	label.text = "Congratulations engineer!"
	$Cheering.play()
	await get_tree().create_timer(3.0).timeout
	$RocketLaunch.play()

func show_fail():
	label.text = "A disaster lies on your hands..."
	$RocketExplosion.play()
	
