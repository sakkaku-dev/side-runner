extends Area2D

class_name BounceArea

signal bounced

export var bounce_factor = 1

func bounced() -> void:
	emit_signal("bounced")
