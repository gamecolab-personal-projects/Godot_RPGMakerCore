@tool
extends EditorPlugin

const AUTOLOADS = {
	"GameState": "res://addons/narrative_rpg_framework/core/GameState.gd",
	"GlobalEnums": "res://addons/narrative_rpg_framework/core/GlobalEnums.gd"
}

func _enter_tree():
	for name in AUTOLOADS.keys():
		_create_autoload(name, AUTOLOADS[name])

func _exit_tree():
	for name in AUTOLOADS.keys():
		_delete_autoload(name)

func _create_autoload(name: String, path: String):
	if not ProjectSettings.has_setting("autoload/" + name):
		add_autoload_singleton(name, path)
		print("%s singleton: CREATED OK" % name)
	else:
		print("%s singleton: EXISTS OK" % name)

func _delete_autoload(name: String):
	if ProjectSettings.has_setting("autoload/" + name):
		remove_autoload_singleton(name)
		print("%s singleton: DELETED OK" % name)
