@tool
extends EditorPlugin

const AUTOLOAD_NAME := "GameState"
const AUTOLOAD_PATH := "res://addons/narrative_rpg_framework/core/GameState.gd"

func _enter_tree():
	_create_autoload()

func _exit_tree():
	_delete_autoload()

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
