extends Node

var flags: Dictionary = {}
var inventory: Array = []

func add_item(item: String) -> void:
	inventory.append(item)

func has_item(item: String) -> bool:
	return item in inventory
