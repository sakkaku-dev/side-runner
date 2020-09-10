extends Area2D

class_name HurtArea

export var health_path: NodePath
onready var health: Health = get_node(health_path)

func damage(dmg: int) -> void:
	health.health -= dmg
