extends Node

signal zero_health
signal health_changed(hp)

class_name Health

export var max_health = 10
onready var health = max_health setget set_health

func set_health(hp: int) -> void:
	health = hp
	if health <= 0:
		health = 0
		emit_signal("zero_health")
	else:
		emit_signal("health_changed", health)
