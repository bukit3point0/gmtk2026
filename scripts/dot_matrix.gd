extends Sprite2D

@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $MarginContainer/AudioStreamPlayer2D

const TIME_BETWEEN_WORDS = 0.2

var print_timer: float = 0.2
var is_printing_words = false

var words: Array[String]

func _ready() -> void:
	EventBus.connect("_print_message", _on_print_message)
	words = ["Launch", "sequence", "begin"]
	rich_text_label.text = ""

func _process(delta) -> void:
	print_timer -= delta
	if print_timer <= 0:
		print_timer = TIME_BETWEEN_WORDS
		if words.is_empty():
			audio_stream_player_2d.playing = false
		else:
			audio_stream_player_2d.playing = true
			var word = words.pop_front()
			rich_text_label.text += word + " "
			if words.is_empty():
				rich_text_label.text += "\n\n"

func _on_print_message(message: String):
	var individual_words = message.split(" ")
	for word in individual_words:
		words.push_back(word)
