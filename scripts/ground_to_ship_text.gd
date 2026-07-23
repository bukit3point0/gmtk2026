extends Sprite2D

@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $MarginContainer/AudioStreamPlayer2D

var is_printing_words = false

func _ready() -> void:
	display_word_by_word()

func _process(_delta) -> void:
	# as long as it is printing words and the player is not currently running, play the audio
	if is_printing_words and !audio_stream_player_2d.playing:
		play_typing_sound()

func display_word_by_word() -> void:
	is_printing_words = true
	var text = rich_text_label.text
	var words = text.split(" ")
	rich_text_label.text = ""
	for word in words:
		rich_text_label.text += word + " "
		await get_tree().create_timer(0.2).timeout
	is_printing_words = false
	rich_text_label.text += "\n" # line break for the next set of text

func play_typing_sound() -> void:
	audio_stream_player_2d.playing = true
