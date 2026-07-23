extends Node2D

@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel

func show_countdown_timer(time: int) -> void:
	visible = true
	match time:
		10:
			rich_text_label.add_theme_color_override("default_color", "#ffffff")
			rich_text_label.add_theme_font_size_override("normal_font_size", 150)
			rich_text_label.text = "10"
		9:
			rich_text_label.add_theme_color_override("default_color", "#fbe8e6")
			rich_text_label.add_theme_font_size_override("normal_font_size", 164)
			rich_text_label.text = "9"
		8:
			rich_text_label.add_theme_color_override("default_color", "#f7d1cd")
			rich_text_label.add_theme_font_size_override("normal_font_size", 177)
			rich_text_label.text = "8"
		7:
			rich_text_label.add_theme_color_override("default_color", "#f3bab4")
			rich_text_label.add_theme_font_size_override("normal_font_size", 191)
			rich_text_label.text = "7"
		6:
			rich_text_label.add_theme_color_override("default_color", "#efa39b")
			rich_text_label.add_theme_font_size_override("normal_font_size", 205)
			rich_text_label.text = "6"
		5:
			rich_text_label.add_theme_color_override("default_color", "#eb8c82")
			rich_text_label.add_theme_font_size_override("normal_font_size", 219)
			rich_text_label.text = "5"
		4:
			rich_text_label.add_theme_color_override("default_color", "#e77569")
			rich_text_label.add_theme_font_size_override("normal_font_size", 232)
			rich_text_label.text = "4"
		3:
			rich_text_label.add_theme_color_override("default_color", "#e35e50")
			rich_text_label.add_theme_font_size_override("normal_font_size", 245)
			rich_text_label.text = "3"
		2:
			rich_text_label.add_theme_color_override("default_color", "#df4737")
			rich_text_label.add_theme_font_size_override("normal_font_size", 260)
			rich_text_label.text = "2"
		1:
			rich_text_label.add_theme_color_override("default_color", "#db301e")
			rich_text_label.add_theme_font_size_override("normal_font_size", 273)
			rich_text_label.text = "1"
		0:
			rich_text_label.add_theme_color_override("default_color", "#d61600")
			rich_text_label.add_theme_font_size_override("normal_font_size", 287)
			rich_text_label.text = "0"
