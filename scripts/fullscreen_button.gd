extends Node2D

var is_fullscreen

func _ready():
	is_fullscreen =	DisplayServer.window_get_mode() ==  DisplayServer.WINDOW_MODE_FULLSCREEN

func _process(_delta: float) -> void:
	# If escape is pressed it triggers the func to pause timer and open pause menu
	if Input.is_action_just_pressed("Fullscreen"):
		switch_fullscreen()

func _on_check_button_pressed():
	switch_fullscreen()
	
func switch_fullscreen():
	is_fullscreen = !is_fullscreen
	if is_fullscreen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
