extends Node

const save_location = "user://stop_the_launch.json"

func save_game() -> void:
	var contents_to_save: Dictionary = {
		"puzzle_index": GlobalVariables.puzzle_index,
		"master_volume": GlobalVariables.master_volume,
		"music_volume": GlobalVariables.music_volume,
		"gameplay_volume": GlobalVariables.gameplay_volume,
		"player_lives": GlobalVariables.player_lives,
	}
	
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(contents_to_save.duplicate())
	file.close()

func load_game() -> void:
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		
		GlobalVariables.puzzle_index = save_data.puzzle_index
		GlobalVariables.master_volume = save_data.master_volume
		GlobalVariables.music_volume = save_data.music_volume
		GlobalVariables.gameplay_volume = save_data.gameplay_volume
		GlobalVariables.player_lives = save_data.player_lives
