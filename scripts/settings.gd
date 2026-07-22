extends Node2D

@onready var master_slider: HSlider = $ColorRect/MarginContainer/VBoxContainer/SettingsContainer/MasterVolume/HSlider
@onready var music_slider: HSlider = $ColorRect/MarginContainer/VBoxContainer/SettingsContainer/Music/HSlider
@onready var gameplay_slider: HSlider = $ColorRect/MarginContainer/VBoxContainer/SettingsContainer/GameplaySounds/HSlider

@export var master_volume_bus := "Master"
@export var music_volume_bus := "Music"
@export var gameplay_volume_bus := "Gameplay"

@onready var _master_volume := AudioServer.get_bus_index(master_volume_bus)
@onready var _music_volume := AudioServer.get_bus_index(music_volume_bus)
@onready var _gameplay_volume := AudioServer.get_bus_index(gameplay_volume_bus)

var master_volume
var music_volume
var gameplay_volume

func _ready() -> void:
	master_volume = db_to_linear(AudioServer.get_bus_volume_db(_master_volume))
	music_volume = db_to_linear(AudioServer.get_bus_volume_db(_music_volume))
	gameplay_volume = db_to_linear(AudioServer.get_bus_volume_db(_gameplay_volume))

func _on_master_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_master_volume, master_slider.value)

func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_master_volume, music_slider.value)

func _on_gameplay_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_master_volume, gameplay_slider.value)

func _on_return_button_pressed() -> void:
	visible = false
