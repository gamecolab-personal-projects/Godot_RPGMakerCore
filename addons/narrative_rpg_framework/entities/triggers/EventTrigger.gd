extends Area2D

@export var event_name: String = ""

signal event_triggered(event_name: String)

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		emit_signal("event_triggered", event_name)
