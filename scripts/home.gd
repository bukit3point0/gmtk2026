extends Node2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	audio_stream_player_2d.playing = true

func _process(_delta) -> void:
	if !audio_stream_player_2d.playing:
		audio_stream_player_2d.playing = true
