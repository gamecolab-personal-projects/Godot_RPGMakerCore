@tool
extends EditorPlugin

const AUTOLOAD_NAME := "GameState"
const AUTOLOAD_PATH := "res://addons/narrative_rpg_framework/GameState.gd"

func _enter_tree():
	_create_game_folders()
	_create_autoload()

func _exit_tree():
	_delete_autoload()

func _create_game_folders():
	var folders = [
		"res://game/",
		"res://game/core/",
		"res://game/systems/",
		"res://game/scenes/",
		"res://game/data/"
	]
	
	for folder_path in folders:
		if not DirAccess.dir_exists_absolute(folder_path):
			var err = DirAccess.make_dir_recursive_absolute(folder_path)
			if err == OK:
				print("Folder created:", folder_path)
			else:
				print("Failed to create folder:", folder_path)

func _create_autoload():
	if not ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_PATH)
		print("GameState singleton: CREATED OK")
	else:
		print("GameState singleton: EXISTS OK")

func _delete_autoload():
	if ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		remove_autoload_singleton(AUTOLOAD_NAME)
		print("GameState singleton: DELETED OK")
