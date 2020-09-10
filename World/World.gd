extends Node2D

onready var limit := $LeftLimit
onready var camera := $MainCamera

func set_left_limit(pos_x: int) -> void:
	camera.limit_left = pos_x
	limit.global_position.x = pos_x
