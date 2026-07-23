extends Sprite2D

@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel

func display_word_by_word() -> void:
	var text = rich_text_label.text
	var words = text.split(" ")
	rich_text_label.text = ""
	for word in words:
		rich_text_label.text += word + " "
		await get_tree().create_timer(0.2).timeout
	rich_text_label.text += "\n" # line break for the next set of text
