extends Node

const EventManager = preload("res://addons/narrative_rpg_framework/entities/EventManager.gd")
const EventResource = preload("res://addons/narrative_rpg_framework/entities/data/EventResource.gd")
const EventType = GlobalEnums.EventType

var event_manager: EventManager

func _ready():
	event_manager = EventManager.new()
	add_child(event_manager)

	var test_event = EventResource.new()
	test_event.steps = [
		{ "type": EventType.DIALOGUE, "text": "Welcome to the narrative RPG framework!" },
		{ "type": EventType.GIVE_ITEM, "item": "sword", "amount": 1 },
		{ "type": EventType.SET_FLAG, "flag": "tutorial_done", "value": true },
		{ "type": EventType.WAIT_INPUT },
		{ "type": EventType.CHANGE_SCENE, "scene_path": "res://scenes/next_level.tscn" }
	]

	event_manager.start_event(test_event)
