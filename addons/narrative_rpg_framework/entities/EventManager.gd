extends Node
class_name EventManager

# Asume que GlobalEnums es autoload
const EventType = GlobalEnums.EventType

var current_event: EventResource = null
var current_index: int = 0
var is_running := false

func start_event(event: EventResource):
	if not event:
		push_error("Invalid event passed to EventManager.")
		return

	current_event = event
	current_index = 0
	is_running = true
	_process_next_step()

func _process_next_step():
	if not is_running or current_index >= current_event.steps.size():
		_finish_event()
		return

	var step = current_event.steps[current_index]
	current_index += 1

	match step.get("type"):
		EventType.DIALOGUE:
			_show_dialogue(step.get("text", ""))
		EventType.GIVE_ITEM:
			print("Added item '%s' to inventory, amount: %d" % [step.get("item", ""), step.get("amount", 1)])
			_process_next_step()
		EventType.SET_FLAG:
			print("Set flag '%s' to value: %s" % [step.get("flag", ""), str(step.get("value", true))])
			_process_next_step()
		EventType.CHANGE_SCENE:
			print("Changed scene to: %s" % step.get("scene_path", ""))
			_process_next_step()
		EventType.WAIT_INPUT:
			print("Waiting for player input...")
			get_tree().paused = true
			await _wait_for_input()
			get_tree().paused = false
			_process_next_step()
		_:
			print("Unknown event step:", step)
			_process_next_step()

func _show_dialogue(text: String):
	print("[DIALOGUE]: %s" % text)
	await get_tree().create_timer(1.5).timeout
	_process_next_step()

func _wait_for_input():
	print("[INPUT] Pressing a key is asked")
	return

func _finish_event():
	is_running = false
	current_event = null
	current_index = 0
	print("Event finished.")
